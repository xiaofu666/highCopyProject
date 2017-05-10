//
//  CYPlayerView.m
//  AVPlayer
//
//  Created by lcy on 16/3/15.
//  Copyright (c) 2016年 lcy. All rights reserved.
//

#import "SmartbiAdaPlayerView.h"

@implementation SmartbiAdaPlayerView

//UIView ---> layer ---> CALayer

//UIView ---> layer ---> AVPlayerLayer

//改变layer的 类型   ---->  CALayer
//AVPlayerLayer
+(Class)layerClass
{
    return [AVPlayerLayer class];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
