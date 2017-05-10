//
//  GPLoadingView.m
//  
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "GPLoadingView.h"

#import "UIView+Shadow.h"




@interface GPLoadingView ()

@property (nonatomic , retain) UIView *topView;//顶部视图<用于阴影效果>

@property (nonatomic , retain) UIImageView *mainGear;//主齿轮

@property (nonatomic , retain) UIImageView *topGear;//上齿轮

@property (nonatomic , retain) UIImageView *leftGear;//左齿轮

@property (nonatomic , retain) UIImageView *downGear;//下齿轮

@property (nonatomic , retain) UIImageView *rightGear;//右齿轮

@property (nonatomic , retain) UIView *leftView;//左视图

@property (nonatomic , retain) UIView *rightView;//右视图

@property (nonatomic , assign) BOOL isLoading;//是否正在加载状态

@property (nonatomic , retain) UIView *errolView;//错误视图


@end

@implementation GPLoadingView

-(void)dealloc{
    
    [_topView release];
    
    [_mainGear release];
    
    [_topGear release];
    
    [_leftGear release];
    
    [_downGear release];
    
    [_rightGear release];
    
    [_leftView release];
    
    [_rightView release];
    
    [_errolView release];
    
    [super dealloc];

}


#pragma  mark ---初始化视图

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置背景颜色
        
        self.backgroundColor = [UIColor colorWithRed:37/255.0 green:77/255.0 blue:138/255.0 alpha:1];
        
        self.clipsToBounds = YES;
        
        //=======
        
        
        //初始化错误视图
        
        _errolView = [[UIView alloc]initWithFrame:CGRectMake(0 , 0 , 10, 10)];
        
        _errolView.center =  CGPointMake(0 - 10  , 0 -10);
        
        _errolView.clipsToBounds = YES;
        
        _errolView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_errolView];
        
        
        //==========
        
        
        //初始化左视图
        
        _leftView = [[UIView alloc]init];

        _leftView.backgroundColor = [UIColor colorWithRed:94/255.0 green:136/255.0 blue:233/255.0 alpha:1];
        
        [self addSubview:_leftView];
        
        
        //初始化右视图
        
        _rightView = [[UIView alloc]init];
        
        _rightView.backgroundColor = [UIColor colorWithRed:94/255.0 green:136/255.0 blue:233/255.0 alpha:1];
        
        [self addSubview:_rightView];
        
        //初始化主齿轮
        
        _mainGear = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        
        _mainGear.tintColor = [UIColor colorWithRed:99/255.0 green:141/255.0 blue:237/255.0 alpha:1];
        
        _mainGear.image = [[UIImage imageNamed:@"maingear"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _mainGear.clipsToBounds = YES;
        
        _mainGear.layer.cornerRadius = 35;
        
        [self addSubview:_mainGear];
        
        //初始化左齿轮
        
        _leftGear = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        
        _leftGear.tintColor = [UIColor colorWithRed:94/255.0 green:136/255.0 blue:232/255.0 alpha:0.6];
        
        _leftGear.image = [[UIImage imageNamed:@"othergear"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _leftGear.clipsToBounds = YES;
        
        _leftGear.layer.cornerRadius = 70;
        
        [self addSubview:_leftGear];
        
        
        //初始化下齿轮
        
        _downGear = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
    
        _downGear.tintColor = [UIColor colorWithRed:94/255.0 green:136/255.0 blue:232/255.0 alpha:0.8];
        
        _downGear.image = [[UIImage imageNamed:@"othergear@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _downGear.clipsToBounds = YES;
        
        _downGear.layer.cornerRadius = 55;
        
        [self addSubview:_downGear];
        
        
        //初始化上齿轮
        
        _topGear = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
        
        _topGear.tintColor = [UIColor colorWithRed:94/255.0 green:136/255.0 blue:232/255.0 alpha:0.8];
        
        _topGear.image = [[UIImage imageNamed:@"othergear"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _topGear.clipsToBounds = YES;
        
        _topGear.layer.cornerRadius = 55;
        
        [self addSubview:_topGear];
        
        
        //初始化右齿轮
        
        _rightGear = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        
        _rightGear.tintColor = [UIColor colorWithRed:94/255.0 green:136/255.0 blue:232/255.0 alpha:0.6];
        
        _rightGear.image = [[UIImage imageNamed:@"othergear"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _rightGear.clipsToBounds = YES;
        
        _rightGear.layer.cornerRadius = 70;
        
        [self addSubview:_rightGear];
        
        
        //初始化顶部视图
        
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, -5, CGRectGetWidth(self.frame), 5)];
        
        //添加阴影
        
        [_topView dropShadowWithOffset:CGSizeMake(0, 5) radius:5 color:[UIColor darkGrayColor] opacity: 0.8];
        
        [self addSubview:_topView];
        
        
    }
    
    return self;

}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    //设置左视图位置
    
    _leftView.frame = CGRectMake(10, 0, 10, self.frame.size.height);
    
    //设置右视图位置
    
    _rightView.frame = CGRectMake( CGRectGetWidth(self.frame) - 20, 0, 10, self.frame.size.height);
    
    
    
    //设置主齿轮位置
    
    CGFloat mainx = self.frame.size.width / 2;
    
    CGFloat mainy = self.frame.size.height / 2;
    
    _mainGear.center = CGPointMake( mainx , mainy );
    
    
    //是否正在加载状态
    
    if (self.isLoading == NO){
        
        //辅助齿轮移动
        
        [self moveAuxiliaryGear:mainx :mainy];
        
    } else {
        
        //是否要显示辅助齿轮
        
        if (self.isAuxiliaryGear == YES){
            
            //辅助齿轮移动
            
            [self moveAuxiliaryGear:mainx :mainy];
            
        }
        
    }
 
}

//辅助齿轮(上下左右)移动

- (void)moveAuxiliaryGear:(CGFloat)mainx :(CGFloat)mainy{
    
    //设置下齿轮位置
    
    CGFloat downx = mainx - 55 - 11;
    
    CGFloat downy = mainy + 55 -3;
    
    _downGear.center = CGPointMake( downx , downy );
    
    //设置左齿轮位置
    
    CGFloat leftx = ( downx - 55) +5;
    
    CGFloat lefty = downy - 140 + 35 - 2;
    
    _leftGear.center = CGPointMake( leftx , lefty );
    
    //设置上齿轮位置
    
    CGFloat topx = self.frame.size.width / 2 + 55 + 11;
    
    CGFloat topy =  self.frame.size.height / 2 - 55 + 3;
    
    _topGear.center = CGPointMake( topx , topy);
    
    //设置右齿轮位置
    
    CGFloat rightx = topx + 70 + 14;
    
    CGFloat righty = mainy + 32;
    
    _rightGear.center = CGPointMake( rightx , righty );

    
}


#pragma  mark ---即将开始加载视图

- (void)willLoadView{
    
    //未加载时
    
    if (self.isLoading == NO) {
        
        //旋转齿轮
        
        self.mainGear.transform = CGAffineTransformRotate(self.mainGear.transform, - M_PI_4 / 20 *2);
        
        self.downGear.transform = CGAffineTransformRotate(self.downGear.transform,  M_PI_4 / 36.0 * 2);
        
        self.leftGear.transform = CGAffineTransformRotate(self.leftGear.transform, - M_PI_4 / 36.0 * 2);
        
        self.topGear.transform = CGAffineTransformRotate(self.topGear.transform,  M_PI_4 / 36.0 * 2);
        
        self.rightGear.transform = CGAffineTransformRotate(self.rightGear.transform, - M_PI_4 / 36.0 * 2);
        
    }
    
}


#pragma  mark ---正在加载视图

- (void)loadingView{
    
    //更新正在加载状态
    
    self.isLoading = YES;
    
    //旋转角度归0
    
    self.mainGear.transform = CGAffineTransformMakeRotation(0);
    
    self.downGear.transform = CGAffineTransformMakeRotation(0);
    
    self.leftGear.transform = CGAffineTransformMakeRotation(0);
    
    self.topGear.transform = CGAffineTransformMakeRotation(0);
    
    self.rightGear.transform = CGAffineTransformMakeRotation(0);
    
    //运行齿轮
    
    [self runGear];
    
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


//运行旋转齿轮

- (void)runGear{
    
    //运行主齿轮
    
    [self runMainGear];
    
    //判断是否在加载时显示辅助齿轮
    
    if (self.isAuxiliaryGear == NO) {
        
        //收回辅助齿轮(上下左右)
        
        [self takeBackAuxiliaryGear];
        
    } else {
        
        //运行左齿轮
        
        [self runLeftGear];
        
        //运行上齿轮
        
        [self runTopGear];
        
        //运行右齿轮
        
        [self runRightGear];
        
        //运行下齿轮
        
        [self runDownGear];
        
    }
    
}

- (void)runMainGear{
    
    //运行主齿轮
    
    [self.mainGear.layer addAnimation:[self rotationGear:M_PI * 1.8] forKey:@"Rotation"];
    
    
}

- (void)runLeftGear{
    
    //运行左齿轮
    
    [self.leftGear.layer addAnimation:[self rotationGear: M_PI * 1.0] forKey:@"Rotation"];
    
}

- (void)runTopGear{
    
    //运行上齿轮
    
    [self.topGear.layer addAnimation:[self rotationGear:- M_PI * 1.0] forKey:@"Rotation"];
    
}

- (void)runRightGear{
    
    //运行右齿轮
    
    [self.rightGear.layer addAnimation:[self rotationGear:M_PI * 1.0] forKey:@"Rotation"];
    
}

- (void)runDownGear{
    
    //运行下齿轮
    
    [self.downGear.layer addAnimation:[self rotationGear:- M_PI * 1.0] forKey:@"Rotation"];
    
}

//删除正在加载动画

- (void)removeLoadingAnimations{
    
    //删除原加载动画
    
    [self.mainGear.layer removeAnimationForKey:@"Rotation"];
    
    [self.leftGear.layer removeAnimationForKey:@"Rotation"];
    
    [self.topGear.layer removeAnimationForKey:@"Rotation"];
    
    [self.downGear.layer removeAnimationForKey:@"Rotation"];
    
    [self.rightGear.layer removeAnimationForKey:@"Rotation"];
    
}

//收回辅助齿轮

- (void)takeBackAuxiliaryGear{
    
    //旋转角度归0
    
    self.downGear.transform = CGAffineTransformMakeRotation(0);
    
    self.leftGear.transform = CGAffineTransformMakeRotation(0);
    
    self.topGear.transform = CGAffineTransformMakeRotation(0);
    
    self.rightGear.transform = CGAffineTransformMakeRotation(0);
    
    [UIView beginAnimations:@"takeBackAuxiliaryGear" context:nil];
    
    [UIView setAnimationDuration:2.0f];
    
    //收回下齿轮
    
    self.downGear.frame = CGRectMake( 0 - CGRectGetWidth(self.downGear.frame)  , CGRectGetHeight(self.frame)  , CGRectGetWidth(self.downGear.frame), CGRectGetHeight(self.downGear.frame));
    
    //收回左齿轮
    
    self.leftGear.frame = CGRectMake( 0 - CGRectGetWidth(self.leftGear.frame)/ 2  , 0 - CGRectGetHeight(self.leftGear.frame) , CGRectGetWidth(self.leftGear.frame), CGRectGetHeight(self.leftGear.frame));
    
    //收回上齿轮
    
    self.topGear.frame = CGRectMake( self.topGear.frame.origin.x + 50 , 0 - CGRectGetHeight(self.topGear.frame)  , CGRectGetWidth(self.topGear.frame), CGRectGetHeight(self.topGear.frame));
    
    //收回右齿轮
    
    self.rightGear.frame = CGRectMake( CGRectGetWidth(self.frame) , CGRectGetHeight(self.frame) + CGRectGetHeight(self.rightGear.frame) , CGRectGetWidth(self.rightGear.frame), CGRectGetHeight(self.rightGear.frame));
    
    
    
    [UIView commitAnimations];

}


#pragma  mark ---已加载完毕视图

- (void)didLoadView{
    
    if (self.isLoading) {
        
        //清空正在加载动画
        
        [self removeLoadingAnimations];
        
        __block GPLoadingView *Self = self;
        
        [UIView animateWithDuration:0.2f animations:^{
            
            //放大
            
            Self.mainGear.transform = CGAffineTransformScale(Self.mainGear.transform , 1.2, 1.2);
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                [UIView animateWithDuration:0.5f animations:^{
                    
                    //缩小
                    
                    Self.mainGear.transform = CGAffineTransformScale(Self.mainGear.transform , 0.2, 0.2);
                    
                } completion:^(BOOL finished) {
                    
                    if (finished) {
                        
                        //调用加载结束的Block
                        
                        Self.didLoadBlock();
                        
                        //还原主齿轮大小
                        
                        Self.mainGear.transform = CGAffineTransformMakeScale ( 1.0, 1.0);
                        
                        //更新正在加载状态
                        
                        Self.isLoading = NO;
                        
                        //旋转角度归0
                        
                        self.mainGear.transform = CGAffineTransformMakeRotation(0);
                        
                        self.downGear.transform = CGAffineTransformMakeRotation(0);
                        
                        self.leftGear.transform = CGAffineTransformMakeRotation(0);
                        
                        self.topGear.transform = CGAffineTransformMakeRotation(0);
                        
                        self.rightGear.transform = CGAffineTransformMakeRotation(0);
                        
                    }
                    
                }];
                
            }
            
        }];

        
    }
    
}


#pragma  mark ---错误加载视图

#define angelToRandian(x)  ((x)/180.0*M_PI)

- (void)errorLoadView{
    
    if (self.isLoading) {
        
        //清空正在加载动画
        
        [self removeLoadingAnimations];
        
        //抖动动画
        
        CAKeyframeAnimation *erroranim=[CAKeyframeAnimation animation];
        
        erroranim.keyPath=@"transform.rotation";
        
        erroranim.values=@[@(angelToRandian(-7)),@(angelToRandian(7)),@(angelToRandian(-7))];
        
        erroranim.repeatCount=20;
        
        erroranim.duration=0.1;
        
        [self.mainGear.layer addAnimation:erroranim forKey:@"errorAnimation"];
        
        
        __block GPLoadingView *Self = self;
        
        [UIView animateWithDuration:1.0f animations:^{
            
            [UIView setAnimationDelay:1.0f];
            
            //移动错误视图 (达到延迟1秒的目的)
            
            Self.errolView.center = CGPointMake( 0 - 20, 0 - 20);
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                [Self didLoadView];
                
                //还原错误视图初始位置
                
                Self.errolView.center = CGPointMake( 0 - 10, 0 - 10);
                
                //此处添加提示框
                
            }
            
        }];

        
    }
    
}


// 暂停动画

- (void)pauseAnimation
{
    // 取出当前的时间点，就是暂停的时间点
    CFTimeInterval pausetime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    // 设定时间偏移量，让动画定格在那个时间点
    [self.layer setTimeOffset:pausetime];
    
    // 将速度设为0
    [self.layer setSpeed:0.0f];
    
}

// 恢复动画

- (void)resumeAnimation
{
    // 获取暂停的时间
    CFTimeInterval pausetime = self.layer.timeOffset;
    
    // 计算出此次播放时间(从暂停到现在，相隔了多久时间)
    CFTimeInterval starttime = CACurrentMediaTime() - pausetime;
    
    // 将时间偏移量设为0(重新开始)；
    self.layer.timeOffset = 0.0;
    
    // 设置开始时间(beginTime是相对于父级对象的开始时间,系统会根据时间间隔帮我们算出什么时候开始动画)
    self.layer.beginTime = starttime;
    
    // 将速度恢复，设为1
    self.layer.speed = 1.0;
    
}




@end
