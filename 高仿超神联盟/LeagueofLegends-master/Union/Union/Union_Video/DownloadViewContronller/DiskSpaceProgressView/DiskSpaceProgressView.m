//
//  DiskSpaceProgressView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/24.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "DiskSpaceProgressView.h"

@interface DiskSpaceProgressView ()

@property (nonatomic , retain ) UIView *progressView;//进度视图

@property (nonatomic , retain ) UIView *trackView;//背景视图

@property (nonatomic , retain ) UILabel *titleLabel;//标题



@end

@implementation DiskSpaceProgressView


-(void)dealloc{
    
    [_progressColor release];
    
    [_trackColor release];
    
    [_progressView release];
    
    [_trackView release];
    
    [super dealloc];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //初始化背景条视图

        _trackView = [[UIView alloc]init];
        
        _trackView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:_trackView];
        
        //初始化进度条视图
        
        _progressView = [[UIView alloc]init];
        
        _progressView.backgroundColor = [UIColor redColor];
        
        [self addSubview:_progressView];
        
        //初始化标题Label
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_titleLabel];
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _trackView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    _progressView.frame = CGRectMake(0, 0, CGRectGetWidth(_progressView.frame), CGRectGetHeight(self.frame));
    
    _titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
}

#pragma mark --- 设置标题

-(void)setTitleStr:(NSString *)titleStr{
    
    if (_titleStr != titleStr) {
        
        [_titleStr release];
        
        _titleStr = [titleStr retain];
        
    }
    
    _titleLabel.text = titleStr;
    
}


#pragma mark --- 设置颜色

- (void)setProgressColor:(UIColor *)progressColor{
    
    if (_progressColor != progressColor) {
        
        [_progressColor release];
        
        _progressColor = [progressColor retain];
        
    }
    
    _progressView.backgroundColor = progressColor;
    
}

- (void)setTrackColor:(UIColor *)trackColor{
    
    if (_trackColor != trackColor) {
        
        [_trackColor release];
        
        _trackColor = [trackColor retain];
        
    }
    
    _trackView.backgroundColor = trackColor;
    
}



#pragma mark --- 设置进度

- (void)setProgress:(float)progress{
    
    if (progress >= 0.9f) {
        
        _progressView.backgroundColor = [UIColor colorWithRed:250/255.0 green:85/255.0 blue:88/255.0 alpha:1];
        
    } else {
        
        _progressView.backgroundColor = self.progressColor;
        
    }
    
    //设置进度视图
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:0.3f animations:^{
       
        _progressView.frame = CGRectMake(0, 0, CGRectGetWidth(Self.frame) * progress , CGRectGetHeight(_progressView.frame));
        
    }];

}

@end
