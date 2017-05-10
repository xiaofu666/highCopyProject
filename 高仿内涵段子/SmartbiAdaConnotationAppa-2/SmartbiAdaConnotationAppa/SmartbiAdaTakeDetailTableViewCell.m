//
//  SmartbiAdaHomeTableViewCell.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaTakeDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "SmartbiAdaPlayerView.h"

@interface SmartbiAdaTakeDetailTableViewCell()

@property (nonatomic,strong) AVPlayer *player;

@property (nonatomic,strong) AVPlayerItem *item;
@property (nonatomic) CMTime time;

@end
@implementation SmartbiAdaTakeDetailTableViewCell
-(void)refreshUI:(SmartbiAdaTakeDetail *)TakeDetail{
   
    [self.userAvatarView sd_setImageWithURL:[NSURL URLWithString:TakeDetail.avatar_url] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.userAvatarView.layer.cornerRadius=20.0f;
    self.nameLabel.text=TakeDetail.name;
    self.TEXTLabel.text=TakeDetail.text;
    self.TEXTLabel.numberOfLines=0;

    
    //    [self.categoryButton setTitle:TakeDetail.category_name forState:UIControlStateNormal];
    if ([TakeDetail.imageUrl length] >0) {
        [self.IMAGEView sd_setImageWithURL:[NSURL URLWithString:TakeDetail.imageUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
    }
    
    
    self.digg_countLabel.text=[NSString stringWithFormat:@"%@",TakeDetail.digg_count];
    self.bury_countLabel.text=[NSString stringWithFormat:@"%@",TakeDetail.bury_count];
    self.comment_countLabel.text=[NSString stringWithFormat:@"%@",TakeDetail.comment_count];
    self.share_countLabel.text=[NSString stringWithFormat:@"%@",TakeDetail.share_count];
    
//    self.UIView
    
    
    
    //设置cell中笑话的高度
    self.TEXTHeight.constant =TakeDetail.contentSize.height;
    if (TakeDetail.imageHeight > 0) {
        self.UIImageViewHeight.constant=TakeDetail.imageHeight;
    }else{
        self.UIImageViewHeight.constant=0;
        self.IMAGEView.backgroundColor=[UIColor whiteColor];
    }
    self.statVideo.selected = NO;
//    [self.videoView sendSubviewToBack:self.backView];
    [self.statVideo setHidden:YES];
    [self.Sli setHidden:YES];
    self.Sli.value=0.0f;
//    [self.backView setHidden:YES];
    if(TakeDetail.videoHeight > 0){
    self.videoHeight.constant=TakeDetail.videoHeight;
    }
    else
    {
        self.videoHeight.constant=0;
//        self.videoView.backgroundColor=[UIColor whiteColor];
    }
  
    if (self.videoHeight.constant > 0) {
        [self videoStart:TakeDetail.videoUrl];
    }

}
-(void)videoStart:(NSString *)videoUrl{
    [self.statVideo setHidden:NO];
    [self.Sli setHidden:NO];
    [self.backView setHidden:NO];
    self.item=[[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:videoUrl]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.item];
     ((AVPlayerLayer *)self.videoView.layer).player = self.player;
    //启动定时器
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(change) userInfo:nil repeats:YES];
   

}

-(void)change
{
   
            //CMTime  ---->  seconds
            //value    总帧数
            //timeScale  每秒播放的帧数
            self.time = self.player.currentItem.duration;
            if (self.time.timescale != 0) {
                self.Sli.maximumValue = self.time.value / self.time.timescale;   
            }
            
            __weak UISlider *slider = self.Sli;
            //addPeriodicTimeObserverForInterval  1
            //time  当前视频播放的时间
            [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
//                NSLog(@"123");
                slider.value = time.value / time.timescale;
            }];
        
    
}

- (IBAction)startVideoClick:(UIButton *)sender {
//    self.videoView.hidden = NO;
    if(!sender.selected)
    {
        [self.player play];
    }
    else
    {
        [self.player pause];
    }
    
    sender.selected = !sender.selected;
}
- (IBAction)sliValue:(UISlider *)sender {
    [self.player seekToTime:CMTimeMake(sender.value * self.time.timescale, self.time.timescale)];

}
-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"status"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
