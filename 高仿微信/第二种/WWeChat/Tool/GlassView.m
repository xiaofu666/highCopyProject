//
//  GlassView.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/17.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "GlassView.h"

@implementation GlassView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
       // self.backgroundColor = [UIColor whiteColor];
        //加毛玻璃效果
        UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView * ve = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        ve.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self addSubview:ve];
    }
    return self;
}

- (void)showToView:(UIView *)view
{
    [view addSubview:self];
}

- (void)hide
{
    [self removeFromSuperview];
}
@end
