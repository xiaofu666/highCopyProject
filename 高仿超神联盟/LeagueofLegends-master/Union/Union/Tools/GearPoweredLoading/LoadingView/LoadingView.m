//
//  LoadingView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/25.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic , retain) UIImageView *mainGear;//主齿轮

@end

@implementation LoadingView

-(void)dealloc{
    
    [_mainGear release];
    
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    //判断 设置最小尺寸
    
    if (frame.size.width < 70 || frame.size.height < 70) {
        
        frame.size.width = 70;
        
        frame.size.height = 70;
        
    }
    
    self = [super initWithFrame:frame];
   
    if (self) {
        
        //初始化主齿轮
        
        _mainGear = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        
        _mainGear.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , CGRectGetHeight(self.frame) / 2 );
        
        _mainGear.image = [[UIImage imageNamed:@"maingear"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _mainGear.clipsToBounds = YES;
        
        _mainGear.layer.cornerRadius = 35;
        
        [self addSubview:_mainGear];
        
        
    }
    return self;
}

-(void)setLoadingColor:(UIColor *)loadingColor{
    
    if (_loadingColor != loadingColor) {
        
        [_loadingColor release];
        
        _loadingColor = [loadingColor retain];
        
    }
    
    //设置颜色
    
    _mainGear.tintColor = loadingColor;
    
    
}

- (void)setHidden:(BOOL)hidden{
    
    if (hidden) {
    
        //隐藏时
        
        //移除旋转动画
        
        [self hiddenView];
        
    } else {
        
        //显示时
        
        //添加选中动画
        
        [self showView];
        
    }
    
    [super setHidden:hidden];
    
}

- (void)showView{
    
    //运行主齿轮
    
    [self.mainGear.layer addAnimation:[self rotationGear:M_PI * 2.0f ] forKey:@"Rotation"];
    
}

- (void)hiddenView{
    
    //删除原加载动画
    
    [self.mainGear.layer removeAnimationForKey:@"Rotation"];

    
}

#pragma mark ---旋转齿轮动画

-(CABasicAnimation *)rotationGear:(float)degree{
    
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat: degree ];
    
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    rotationAnimation.duration = 2;
    
    rotationAnimation.repeatCount = 100000;//设置到最大的整数值
    
    rotationAnimation.cumulative = NO;
    
    rotationAnimation.removedOnCompletion = NO;
    
    rotationAnimation.fillMode = kCAFillModeForwards;
    
    return rotationAnimation;
    
}

@end
