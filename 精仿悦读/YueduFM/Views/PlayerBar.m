//
//  PlayerBar.m
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "PlayerBar.h"
#import "PlayBarActionTableViewCell.h"

@interface PlayerBar () {
    NSTimer*                    _timer;
    UIView*                     _processBar;
    BOOL                        _seeking;
}


@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIView* container;
@property (nonatomic, strong) PlayBarActionTableViewCell* actionCell;
@property (nonatomic, strong) StreamerService* streamerService;

@end

@implementation PlayerBar

+ (instancetype)shareBar {
    static PlayerBar* bar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bar = [PlayerBar viewWithNibName:@"PlayerBar"];
    });
    return bar;
}

+ (void)show {
    [[PlayerBar shareBar] setForceHidden:NO];
}

+ (void)hide {
    [[PlayerBar shareBar] setForceHidden:YES];
}

+ (void)setContainer:(UIView* )container {
    PlayerBar* bar = [PlayerBar shareBar];
    bar.container = container;
    [bar showIfNeed];
}

- (void)setForceHidden:(BOOL)forceHidden {
    if (_forceHidden == forceHidden) return;
    
    _forceHidden = forceHidden;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.actionCell.top = self.height;
    }];
    if (forceHidden) {
        [UIView animateWithDuration:0.3f animations:^{
            self.top = self.container.height;
        }];
    } else {
        self.top = self.container.height;
        [UIView animateWithDuration:0.3f animations:^{
            self.top -= self.height;
        }];
    }
}

- (void)showIfNeed {
    if (!_forceHidden && !self.visible && SRV(ArticleService).activeArticleModel && self.container) {
        self.width = self.container.width;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        [self removeFromSuperview];
        [self.container addSubview:self];
        self.top = self.container.height;
        [UIView animateWithDuration:0.3f animations:^{
            self.top -= self.height;
        }];
        self.visible = YES;
    }
}

- (void)awakeFromNib {
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    line.backgroundColor = RGBHex(@"#E0E0E0");
    [self addSubview:line];
    
    __weak typeof(self) weakSelf = self;
    
    if (SRV(ConfigService).config.allowDownload) {
        _actionCell = [PlayBarActionTableViewCell viewWithNibName:@"PlayBarActionTableViewCell"];

    } else {
        _actionCell = [PlayBarActionTableViewCell viewWithNibName:@"PlayBarActionTableViewCell-WithoutDownload"];
    }
    _actionCell.width = self.width;
    _actionCell.height = self.height;
    _actionCell.top = self.height;
    _actionCell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_actionCell.hideButton bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.actionCell.top = weakSelf.height;
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_actionCell];
    
    [self.actionButton bk_addEventHandler:^(id sender) {
        YDSDKArticleModelEx* model = [SRV(ArticleService) activeArticleModel];
        [WebViewController presentWithURL:model.url.url];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.playButton bk_addEventHandler:^(id sender) {
        YDSDKArticleModelEx* model = [SRV(ArticleService) activeArticleModel];
        if (weakSelf.streamerService.isPlaying) {
            [weakSelf.streamerService pause];
        } else {
            [weakSelf.streamerService play:model];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextButton bk_addEventHandler:^(id sender) {
        [weakSelf.streamerService next];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreButton bk_addEventHandler:^(id sender) {
        YDSDKArticleModelEx* model = [SRV(ArticleService) activeArticleModel];
        weakSelf.actionCell.model = model;
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.actionCell.top = 0;
        }];
    } forControlEvents:UIControlEventTouchUpInside];

    _streamerService = SRV(StreamerService);
    _processBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
    _processBar.backgroundColor = kThemeColor;
    self.progress = 0;
    [self addSubview:_processBar];
    
    [self.imageView setImage:[UIImage imageWithColor:kThemeColor]];
    [SRV(ArticleService) bk_addObserverForKeyPath:@"activeArticleModel" task:^(id target) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showIfNeed];
            
            YDSDKArticleModelEx* model = [SRV(ArticleService) activeArticleModel];
            [weakSelf.imageView sd_setImageWithURL:model.pictureURL.url placeholderImage:[UIImage imageWithColor:kThemeColor]];
            weakSelf.titleLabel.text = model.title;
            weakSelf.authorLabel.text = model.author;
            weakSelf.speakerLabel.text = model.speaker;
            weakSelf.durationLabel.text = [NSString stringWithSeconds:model.duration];
            
            [UIView animateWithDuration:0.3f animations:^{
                weakSelf.actionCell.top = self.height;
            }];
        });
    }];
    
    [_streamerService bk_addObserverForKeyPath:@"isPlaying" task:^(id target) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setPlaying:_streamerService.isPlaying];
            weakSelf.progress = _streamerService.duration?_streamerService.currentTime/_streamerService.duration:0;
        });
    }];

    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0f block:^(NSTimer *timer) {
        if (_streamerService.isPlaying && !_seeking && _streamerService.duration) {
            weakSelf.progress = _streamerService.currentTime/_streamerService.duration;
        }
    } repeats:YES];
    
    UILongPressGestureRecognizer* gesture = [UILongPressGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        if (!_streamerService.isPlaying)return;
        
        static CGPoint point;
        
        switch (state) {
            case UIGestureRecognizerStateBegan:
                point = location;
                _seeking = YES;
                break;
            case UIGestureRecognizerStateChanged:
            case UIGestureRecognizerStateEnded: {
                CGFloat x = location.x - point.x;
                self.progress += x/self.width;
                break;
            }
            default:
                break;
        }
        if (state == UIGestureRecognizerStateEnded) {
            StreamerService* streamer = SRV(StreamerService);
            streamer.currentTime = streamer.duration*self.progress;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _seeking = NO;
            });
        }
        point = location;
    }];

    gesture.numberOfTouchesRequired = 1;
    gesture.minimumPressDuration = 0.2;
    gesture.allowableMovement = 200;
    [self addGestureRecognizer:gesture];
}

- (CGFloat)progress {
    return _processBar.width/self.width;
}

- (void)setProgress:(CGFloat)progress {
    progress = fmax(0, progress);
    progress = fmin(progress, 1);
    _processBar.width = self.width*progress;
}

- (void)setPlaying:(BOOL)playing {
    _playing = playing;
    self.playButton.selected = playing;
}

@end
