//
//  GPBottomLoadingView.m
//  
//
//  Created by HarrisHan on 15/7/15.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "GPBottomLoadingView.h"



@interface GPBottomLoadingView ()

@property (nonatomic , retain) UIImageView *mainGear;//主齿轮

@property (nonatomic , retain) UIView *errorLabelView;//错误标签视图

@property (nonatomic , retain) UILabel *errorLabel;//错误标签


@property (nonatomic , assign) CGFloat scale;//缩放比例

@property (nonatomic , assign) BOOL isLoading;//是否正在加载状态

@property (nonatomic , assign) BOOL isErrorAnimation;//是否正在进行加载错误动画

@end

@implementation GPBottomLoadingView

-(void)dealloc {
    
    [_mainGear release];
    
    [_errorLabel release];
    
    [_errorLabelView release];
    
    [super dealloc];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.clipsToBounds = YES;
        
        //初始化错误标签视图
        
        _errorLabelView = [[UIView alloc]initWithFrame:CGRectMake(0 - 100 , 15 , 100, 30)];
        
        _errorLabelView.clipsToBounds = YES;
        
        _errorLabelView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_errorLabelView];
        
        
        //初始化错误标签
        
        _errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 , 0 , 100, 30)];
        
        _errorLabel.text = @"加载失败";
        
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        
        _errorLabel.textColor = [UIColor lightGrayColor];
        
        [_errorLabelView addSubview:_errorLabel];

        
        //初始化主齿轮
        
        _mainGear = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        _mainGear.tintColor = [UIColor colorWithRed:99/255.0 green:141/255.0 blue:237/255.0 alpha:1];
        
        _mainGear.image = [[UIImage imageNamed:@"maingear"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _mainGear.clipsToBounds = YES;
        
        [self addSubview:_mainGear];
        
        //设置默认属性值
        
        _isLoading = NO;
        
        _isErrorAnimation = NO;
        
        _scale = 0.2;
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //判断是否正在进行加载错误动画 (没有进行错误动画时才可以进行操作)
    
    if (_isErrorAnimation == NO) {
        
        //加载时不可更改大小
        
        if (self.isLoading == NO) {
            
            //设置主齿轮大小
            
            CGFloat mainHeight = CGRectGetHeight(self.frame) < 40 ? CGRectGetHeight(self.frame) : 40;
            
            _mainGear.frame = CGRectMake(10, 10, mainHeight , mainHeight);
            
        }
        
        //设置主齿轮位置
        
        CGFloat mainx = self.frame.size.width / 2;
        
        CGFloat mainy = self.frame.size.height / 2;
        
        _mainGear.center = CGPointMake( mainx , mainy );
        
        
        //设置错误标签视图位置
        
        _errorLabelView.center = CGPointMake( _errorLabelView.frame.origin.x + 50 , mainy );
        
    }

    
    
}



#pragma mark ---即将开始加载视图

- (void)willLoadView{

    //旋转齿轮
    
//    self.mainGear.transform = CGAffineTransformRotate(self.mainGear.transform, - M_PI_4 / 20);

}

#pragma mark ---正在加载视图

- (void)loadingView{
    
    //更新加载状态
    
    self.isLoading = YES;
    
    //旋转角度归0
    
    self.mainGear.transform = CGAffineTransformMakeRotation(0);
    
    //运行主齿轮
    
    [self.mainGear.layer addAnimation:[self rotationGear:M_PI * 2.0] forKey:@"Rotation"];
    
    
    
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

#pragma mark ---已加载完毕视图

- (void)didLoadView{
    
    if (self.isLoading) {
        
        //清除原加载动画
        
        [self.mainGear.layer removeAnimationForKey:@"Rotation"];
        
        __block GPBottomLoadingView *Self = self;
        
        [UIView animateWithDuration:0.2f animations:^{
            
            //放大
            
            Self.mainGear.frame = CGRectMake(0, 0, 50, 50);
            
            CGFloat mainx = self.frame.size.width / 2;
            
            CGFloat mainy = self.frame.size.height / 2;
            
            Self.mainGear.center = CGPointMake( mainx , mainy );
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.8f animations:^{
                
                //缩小
                
                Self.mainGear.frame = CGRectMake(0, 0, 0, 0);
                
                CGFloat mainx = self.frame.size.width / 2;
                
                CGFloat mainy = self.frame.size.height / 2;
                
                Self.mainGear.center = CGPointMake( mainx , mainy );
                
            } completion:^(BOOL finished) {
                
                //调用加载结束的Block
                
                Self.didBottomLoadBlock();
                
                //更新加载状态
                
                Self.isLoading = NO;
                
            }];
            
        }];

        
    }
    
}


#pragma  mark ---错误加载视图

#define angelToRandian(x)  ((x)/180.0*M_PI)

- (void)errorLoadView{
    
    if (self.isLoading) {
        
        //设置加载错误动画状态为YES
        
        _isErrorAnimation = YES;
        
        //清空原加载动画
        
        [self.mainGear.layer removeAnimationForKey:@"Rotation"];
        
        //加速旋转动画
        
        [self.mainGear.layer addAnimation:[self rotationGear:M_PI * 7.0] forKey:@"Rotation"];
        
        
        __block GPBottomLoadingView *Self = self;
        
        [UIView animateWithDuration:1.0f animations:^{
            
            //主齿轮滚出屏幕 加载失败提示视图显示
            
            Self.errorLabelView.center = CGPointMake(CGRectGetWidth(Self.frame) / 2, CGRectGetHeight(Self.frame) / 2);
            
            Self.mainGear.center = CGPointMake(CGRectGetWidth(Self.frame) + 20, CGRectGetHeight(Self.frame) / 2);
            
            
        } completion:^(BOOL finished) {
            
            //延迟一秒执行
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //调用加载结束的Block
                
                Self.didBottomLoadBlock();
                
                //更新加载状态
                
                Self.isLoading = NO;
                
                //还原错误标签视图位置
                
                _errorLabelView.center = CGPointMake( 0 - 50 , self.frame.size.height / 2 );
                
                //清空加速旋转加载动画
                
                [Self.mainGear.layer removeAnimationForKey:@"Rotation"];
                
                //设置加载错误动画状态为NO
                
                _isErrorAnimation = NO;
                
            });
            
            
        }];

        
    }
    
}









@end
