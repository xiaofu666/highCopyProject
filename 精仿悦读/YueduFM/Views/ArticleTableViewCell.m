//
//  ArticleTableViewCell.m
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "DOUAudioStreamer.h"

@interface ArticleTableViewCell ()

@property (nonatomic, strong) StreamerService* streamerService;

@end

@implementation ArticleTableViewCell

- (void)awakeFromNib {
    self.pictureView.layer.cornerRadius = 3.0f;
    self.pictureView.clipsToBounds = YES;
    
    __weak typeof(self) weakSelf = self;
    _streamerService = SRV(StreamerService);
    self.detailLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    self.detailLabel.lineSpacing = 2.0f;
    
    [self.playButton bk_addEventHandler:^(id sender) {
        [SRV(DataService) writeData:weakSelf.model completion:nil];
        [weakSelf.streamerService play:weakSelf.model];
    } forControlEvents:UIControlEventTouchUpInside];

    [self addObserver];
}

- (BOOL)isMyPlaying {
    return (_streamerService.isPlaying && (_streamerService.playingModel.aid == self.model.aid));
}

- (void)addObserver {
    __weak typeof(self) weakSelf = self;
    [_streamerService bk_addObserverForKeyPath:@"isPlaying" task:^(id target) {
        if ([weakSelf isMyPlaying]) {
            weakSelf.playing = YES;
        } else {
            weakSelf.playing = NO;
        }
    }];
}

- (void)dealloc {
    [self bk_removeAllBlockObservers];
}

- (void)setModel:(YDSDKArticleModelEx* )model {
    [self bk_removeAllBlockObservers];
    _model = model;
    
    [self.pictureView sd_setImageWithURL:model.pictureURL.url placeholderImage:[UIImage imageWithColor:[UIColor colors][model.aid%[[UIColor colors] count]]]];
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.author;
    self.speakerLabel.text = model.speaker;
    self.durationLabel.text = [NSString stringWithSeconds:model.duration];
    self.detailLabel.text = model.abstract;
    self.playing = [self isMyPlaying];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPlaying:(BOOL)playing {
    _playing = playing;
    if (_playing) {
        [self.rhythmView startAnimating];
    } else {
        [self.rhythmView stopAnimating];
    }
}

@end
