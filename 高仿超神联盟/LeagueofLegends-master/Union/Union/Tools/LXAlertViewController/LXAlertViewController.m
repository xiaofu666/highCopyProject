//
//  LXAlertViewController.m
//  动效提示框封装
//
//  Created by HarrisHan on 15/8/14.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "LXAlertViewController.h"

@interface LXAlertViewController ()

@property (nonatomic , retain ) UIView *titleHolder;//标题持有视图

@property (nonatomic , retain ) UIView *positiveView;//确定视图

@property (nonatomic , retain ) UIView *negativeView;//否定视图

@property (nonatomic , retain ) UIButton *cancelButton;//关闭按钮

@property (nonatomic , retain ) UILabel *titleLabel;//提示Label

@property (nonatomic , retain ) UILabel *positiveLabel;//确定按钮Label

@property (nonatomic , retain ) UILabel *negativeLabel;//否定按钮Label


@property (nonatomic , assign ) BOOL isYes;//是否允许

@end

@implementation LXAlertViewController

-(void)dealloc{
    
    [_titleView release];
    
    [_titleHolder release];
    
    [_positiveView release];
    
    [_negativeView release];
    
    [_cancelButton release];
    
    [_titleLabel release];
    
    [_positiveLabel release];
    
    [_negativeLabel release];
    
    [_alertColor release];
    
    [_positiveColor release];
    
    [_negativeColor release];
    
    [_alertTitle release];
    
    [_againAlertTitle release];
    
    [_negativeTitle release];
    
    [_positiveTitle release];
    
    [_successAlertTitle release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    
    [self.view setBackgroundColor:[UIColor  colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    
    //初始化标题视图
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, -70, 280, 120)];
    
    _titleView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, _titleView.center.y);
    
    [_titleView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_titleView];
    
    
    //初始化确认视图
    
    _positiveView = [[UIView alloc] init];
    
    [_positiveView setFrame:CGRectMake(0, 92, 140, 50)];
    
    [_positiveView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    
    [_positiveView setBackgroundColor:[UIColor colorWithRed:0.20 green:0.28 blue:0.41 alpha:1]];
    
    [_positiveView.layer setZPosition:-1];
    
    //初始化确定Label
    
    _positiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    
    _positiveLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    [_positiveLabel setText:@"positive"];
    
    [_positiveLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_positiveLabel setTextColor:[UIColor lightTextColor]];
    
    [_positiveView addSubview:_positiveLabel];
    
    [self.titleView addSubview:_positiveView];
    
    //初始化否定视图
    
    _negativeView = [[UIView alloc] init];
    
    [_negativeView setFrame:CGRectMake(140, 92, 140, 50)];
    
    [_negativeView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    
    [_negativeView setBackgroundColor:[UIColor colorWithRed:0.26 green:0.33 blue:0.48 alpha:1]];
    
    [_negativeView.layer setZPosition:-1];
    
    //初始化否定Label
    
    _negativeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    
    _negativeLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    [_negativeLabel setText:@"negative"];
    
    [_negativeLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_negativeLabel setTextColor:[UIColor lightTextColor]];
    
    [_negativeView addSubview:_negativeLabel];
   
    [self.titleView addSubview:_negativeView];
    
    //初始化标题Label持有视图
    
    _titleHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width, self.titleView.frame.size.height)];
    
    [_titleHolder setBackgroundColor:[UIColor colorWithRed:0.20 green:0.25 blue:0.33 alpha:1]];
   
    //初始化标题Label
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 240, 120)];
    
    _titleLabel.numberOfLines = 0;
    
    [_titleLabel setText:@"alertView"];
    
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_titleLabel setTextColor:[UIColor lightTextColor]];
    
    [_titleHolder addSubview:_titleLabel];
    
    [self.titleView addSubview:_titleHolder];
    
    [self.titleView.layer setZPosition:1];
    
    //初始化关闭按钮
    
    _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), 30, 30)];
    
    _cancelButton.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, _cancelButton.center.y);
    
    _cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_cancelButton.layer setBorderColor:[UIColor lightTextColor].CGColor];
    
    [_cancelButton.layer setBorderWidth:1];
    
    [_cancelButton.layer setCornerRadius:15];
    
    [_cancelButton setTitle:@"X" forState:UIControlStateNormal];
    
    [_cancelButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    
    [_cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_cancelButton];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nagetiveAction:)];
    
    
    [self.view addGestureRecognizer:gesture];
    
}

#pragma mark ---视图即将出现

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark ---视图已经出现

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //添加动画
    
    [UIView animateWithDuration:0.25 animations:^{
    
        [self.titleView setFrame:CGRectMake(self.titleView.frame.origin.x, CGRectGetHeight(self.view.frame) / 2 - CGRectGetHeight(self.titleView.frame)  , self.titleView.frame.size.width, self.titleView.frame.size.height)];
        
    }];
    
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    
    [animation setDelegate:self];
    
    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
    
    animation.duration = 0.5f;
    
    [animation setKeyPath:@"transform.rotation"];
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    [self.titleView.layer addAnimation:animation forKey:@"shake"];

}

#pragma mark ---视图已经消失

- (void)viewWillDisappear:(BOOL)animated
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark ---获取数据

-(void)setAlertTitle:(NSString *)alertTitle{
    
    if (_alertTitle != alertTitle) {
        
        _alertTitle = alertTitle;
        
    }
    
    _titleLabel.text = alertTitle;
    
}

-(void)setPositiveTitle:(NSString *)positiveTitle{
    
    if (_positiveTitle != positiveTitle) {
        
        _positiveTitle = positiveTitle;
        
    }
    
    _positiveLabel.text = positiveTitle;
    
}

-(void)setNegativeTitle:(NSString *)negativeTitle{
    
    if (_negativeTitle != negativeTitle) {
        
        _negativeTitle = negativeTitle;
        
    }
    
    _negativeLabel.text = negativeTitle;
    
}

-(void)setAlertColor:(UIColor *)alertColor{
    
    if (_alertColor != alertColor) {
        
        _alertColor = alertColor;
        
    }
    
    [_titleHolder setBackgroundColor:alertColor];
    
}

-(void)setPositiveColor:(UIColor *)positiveColor{
    
    if (_positiveColor != positiveColor) {
        
        _positiveColor = positiveColor;
        
    }
    
    
    [_positiveView setBackgroundColor:positiveColor];
    
}

-(void)setNegativeColor:(UIColor *)negativeColor{
    
    if (_negativeColor != negativeColor) {
        
        _negativeColor = negativeColor;
        
    }
    
    [_negativeView setBackgroundColor:negativeColor];
    
}


#pragma mark ---添加要显示在哪个视图控制器

- (void)showView:(UIViewController *)VC
{
    
    [VC addChildViewController:self];
    
    self.view.frame = VC.view.bounds;
    
    [VC.view addSubview:self.view];

}




- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag == YES) {
        
        if ([anim isEqual:[self.titleView.layer animationForKey:@"shake"]])
        {
        
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            
            [animation setDelegate:self];
            
            animation.keyPath = @"transform";
            
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            
            animation.duration = 0.25;
            
            animation.removedOnCompletion = NO;
            
            animation.fillMode = kCAFillModeForwards;
            
            [_positiveView.layer addAnimation:animation forKey:@"rotate"];
        
        }
        else if([anim isEqual:[_positiveView.layer animationForKey:@"rotate"]])
        {
       
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            
            [animation setDelegate:self];
            
            animation.keyPath = @"transform";
            
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            
            animation.duration = 0.25;
            
            animation.removedOnCompletion = NO;
            
            animation.fillMode = kCAFillModeForwards;
            
            [_negativeView.layer addAnimation:animation forKey:@"rotate2"];
        
        }
        else if ([anim isEqual:[_negativeView.layer animationForKey:@"rotate2"]])
        {
        
            [UIView animateWithDuration:0.5 animations:^{
            
                [_cancelButton setFrame:CGRectMake(_cancelButton.frame.origin.x, self.titleView.frame.origin.y + CGRectGetHeight(self.titleView.frame) + 70 , _cancelButton.frame.size.width, _cancelButton.frame.size.height)];
                
            }];
            
            
            CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            
            rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
            
            rotateAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
            
            rotateAnimation.duration = 0.75;
            
            [_cancelButton.layer addAnimation:rotateAnimation forKey:@"rotate3"];
        
        }
        else if([anim isEqual:[self.titleView.layer animationForKey:@"rotate"]])
        {
         
            //添加再次提示内容
            
            [_titleLabel setText:self.againAlertTitle];
            
            //设置允许
            
            _isYes = YES;
        
        }
        else if ([anim isEqual:[_positiveView.layer animationForKey:@"close"]])
        {
        
            CATransform3D transFrom = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200);
            
            CATransform3D trans = CATransform3DIdentity ;
            
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            
            [animation setDelegate:self];
            
            animation.keyPath = @"transform";
            
            animation.fromValue = [NSValue valueWithCATransform3D:transFrom];
            
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            
            animation.duration = 0.25;
            
            animation.removedOnCompletion = NO;
            
            animation.fillMode = kCAFillModeForwards;
            
            [_negativeView.layer addAnimation:animation forKey:@"close2"];
        
        }
        else if ([anim isEqual:[_negativeView.layer animationForKey:@"close2"]])
        {
        
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 0, 1, 0), CGPointMake(0, 0), 200) ;
            
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            
            [animation setDelegate:self];
            
            animation.keyPath = @"transform";
            
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            
            animation.duration = 0.5;
            
            animation.removedOnCompletion = NO;
            
            [self.titleView.layer addAnimation:animation forKey:@"surerotate"];
        
        }
        else if ([anim isEqual:[self.titleView.layer animationForKey:@"surerotate"]])
        {
        
            //添加成功提示内容
            
            [_titleLabel setText:self.successAlertTitle];
            
            [self performSelector:@selector(cancelAction) withObject:self afterDelay:1];
        
        }
    
    }

}



CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
  
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    
    CATransform3D scale = CATransform3DIdentity;
    
    scale.m34 = -1.0f/disZ;
    
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);

}

CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{

    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));

}

#pragma mark ---关闭按钮点击响应事件

- (void)cancelClick
{
    //调用代理方法
    
    //先判断代理是否存在
    
    if (self.lxAlertViewDelegate && [self.lxAlertViewDelegate respondsToSelector:@selector(closeButtonAction)]) {
        
        [self.lxAlertViewDelegate closeButtonAction];
        
    }
    
    
    [self cancelAction];

}

#pragma mark ---关闭动画

- (void)cancelAction
{
    
    [UIView animateWithDuration:0.3f animations:^{
       
        [_cancelButton setFrame:CGRectMake(_cancelButton.frame.origin.x, CGRectGetHeight(self.view.frame) + 160 , _cancelButton.frame.size.width, _cancelButton.frame.size.height)];
        
        [self.titleView setFrame:CGRectMake(self.titleView.frame.origin.x, CGRectGetHeight(self.view.frame) , self.titleView.frame.size.width, self.titleView.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
        //将本视图从父视图中移除 移除父控制器
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
    
    }];

}

#pragma mark ---否定按钮动画

- (void)nagetiveAction:(UIGestureRecognizer*) gesture
{
    CGPoint touchPoint = [gesture locationInView:self.titleView];
    
    if ([_negativeView.layer.presentationLayer hitTest:touchPoint])
    {
        
        //调用代理方法
        
        //先判断代理是否存在
        
        if (self.lxAlertViewDelegate && [self.lxAlertViewDelegate respondsToSelector:@selector(negativeButtonAction)]) {
            
            [self.lxAlertViewDelegate negativeButtonAction];
            
        }

        //NSLog(@"nagetiveAction");
        
        [self cancelAction];
    
    }
    else if([_positiveView.layer.presentationLayer hitTest:touchPoint])
    {
    
        //调用代理方法
        
        //先判断代理是否存在
        
        if (self.lxAlertViewDelegate && [self.lxAlertViewDelegate respondsToSelector:@selector(positiveButtonAction:)]) {
            
            [self.lxAlertViewDelegate positiveButtonAction:_isYes];
            
        }
    
        
        if (self.titleView.layer.animationKeys.count>1)
        {
        
            CATransform3D transFrom = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200);
            
            CATransform3D trans = CATransform3DIdentity ;
            
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            
            [animation setDelegate:self];
            
            animation.keyPath = @"transform";
            
            animation.fromValue = [NSValue valueWithCATransform3D:transFrom];
            
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            
            animation.duration = 0.25;
            
            animation.removedOnCompletion = NO;
            
            animation.fillMode = kCAFillModeForwards;
            
            [_positiveView.layer addAnimation:animation forKey:@"close"];
        
        }
        else
        {
            
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 0, 1, 0), CGPointMake(0, 0), 200) ;
            
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            
            [animation setDelegate:self];
            
            animation.keyPath = @"transform";
            
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            
            animation.duration = 0.5;
            
            animation.removedOnCompletion = NO;
            
            [self.titleView.layer addAnimation:animation forKey:@"rotate"];
        
        }
    
    }

}











@end
