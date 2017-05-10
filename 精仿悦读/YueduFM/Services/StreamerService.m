//
//  StreamerService.m
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "StreamerService.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DOUAudioStreamer.h"

@interface StreamerService () {
    DOUAudioStreamer*       _streamer;
    UIImageView*            _imageView;
    NSMutableDictionary*    _nowPlayingInfo;
    
}


@property (nonatomic, strong) NSMutableDictionary* nowPlayingInfo;
@property (nonatomic, strong) NSDate* updateDate;


@end

@implementation StreamerService

- (instancetype)initWithServiceCenter:(ServiceCenter *)serviceCenter {
    self = [super initWithServiceCenter:serviceCenter];
    if (self) {
        AVAudioSession* session = [AVAudioSession sharedInstance];
        [session setCategory: AVAudioSessionCategoryPlayback error:nil];
        [session setActive: YES error:nil];
        
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        _imageView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)start {
    self.isPlaying = self.isPlaying;
}

- (void)dealloc {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

- (void)play:(YDSDKArticleModelEx* )model {
    if (!model) return;
    
    if (![model.audioURL isEqualToString:self.playingModel.audioURL]) {
        self.playingModel = model;
        SRV(ArticleService).activeArticleModel = model;
        
        model.playedDate = [NSDate date];
        [SRV(DataService) writeData:model completion:nil];
        
        [_streamer bk_removeAllBlockObservers];
        [_streamer stop];
        _streamer = [DOUAudioStreamer streamerWithAudioFile:[[SRV(DownloadService) playableURLForModel:self.playingModel] audioFileURL]];
        [_streamer bk_addObserverForKeyPath:@"duration" task:^(id target) {
            [self updateNowPlayingPlayback];
        }];
        
        [_streamer bk_addObserverForKeyPath:@"status" task:^(id target) {
            if (_streamer.status == DOUAudioStreamerFinished) {
                self.isPlaying = NO;
                self.playingModel.preplayDate = [NSDate dateWithTimeIntervalSince1970:0];
                [SRV(DataService) writeData:self.playingModel completion:nil];
                [self next];
                self.playingModel = nil;
            } else if (_streamer.status == DOUAudioStreamerPaused) {
                self.isPlaying = NO;
            }
        }];
        
        NSDictionary* info = @{
                               MPMediaItemPropertyTitle:model.title,
                               MPMediaItemPropertyAlbumTitle:model.author,
                               MPMediaItemPropertyArtist:model.speaker,
                               MPNowPlayingInfoPropertyPlaybackRate:@(1),
                               };
        
        self.nowPlayingInfo = [NSMutableDictionary dictionaryWithDictionary:info];
        
        [_imageView sd_setImageWithURL:model.pictureURL.url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                self.nowPlayingInfo[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:image];
                self.nowPlayingInfo = self.nowPlayingInfo;
            }
        }];
    }
    
    //在线资源需要验证网络连接情况
    if (![_streamer.url isFileURL]) {
        if (SRV(ReachabilityService).status == NotReachable) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showInfoWithStatus:SRV(ReachabilityService).statusString];
            });
            self.isPlaying = NO;
        } else if ((SRV(ReachabilityService).status == ReachableViaWWAN) && SRV(SettingsService).flowProtection) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showInfoWithStatus:SRV(ReachabilityService).statusString];
            });
            [_streamer play];
            self.isPlaying = YES;
        } else {
            [_streamer play];
            self.isPlaying = YES;
        }
    } else {
        [_streamer play];
        self.isPlaying = YES;
    }
}

- (void)setNowPlayingInfo:(NSMutableDictionary *)nowPlayingInfo {
    _nowPlayingInfo = nowPlayingInfo;

    //防止频繁更新而导致crash
    if (([NSDate timeIntervalSinceReferenceDate] - self.updateDate.timeIntervalSinceReferenceDate)>0.1) {
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
        self.updateDate = [NSDate date];
    }
}

- (NSMutableDictionary* )nowPlayingInfo {
    return _nowPlayingInfo;
}

- (void)pause {
    [_streamer pause];
    self.isPlaying = NO;
}

- (void)resume {
    [self play:self.playingModel];
    [self updateNowPlayingPlayback];
}

- (void)next {
    [SRV(ArticleService) nextPreplay:self.playingModel completion:^(YDSDKArticleModelEx *nextModel) {
        if (nextModel) {
            self.playingModel.preplayDate = [NSDate dateWithTimeIntervalSince1970:0];
            [SRV(DataService) writeData:self.playingModel completion:nil];
            [self play:nextModel];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showInfoWithStatus:LOC(@"playlist_none_prompt")];
            });
        }
    }];
}

- (NSTimeInterval)duration {
    return self.playingModel?_streamer.duration:0;
}

- (NSTimeInterval)currentTime {
    return self.playingModel?_streamer.currentTime:0;
}

- (void)updateNowPlayingPlayback {
    NSMutableDictionary* info = self.nowPlayingInfo;
    info[MPMediaItemPropertyPlaybackDuration] = @(_streamer.duration);
    info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(_streamer.currentTime);
    self.nowPlayingInfo = info;        
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    _streamer.currentTime = currentTime;
    
    NSMutableDictionary* info = self.nowPlayingInfo;
    info[MPMediaItemPropertyPlaybackDuration] = @(_streamer.duration);
    info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(currentTime);
    self.nowPlayingInfo = info;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            [self resume];
            break;
        case UIEventSubtypeRemoteControlPause:
            [self pause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self next];
            break;
        default:
            break;
    }
}

@end
