//
//  DownloadDynamicEffectView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//


#import "DownloadDynamicEffectView.h"

#import "VBFPopFlatButton.h"

#import <POP.h>

#import "AppDelegate.h"


#define MAINCOLOER [UIColor colorWithRed:105/255.0 green:149/255.0 blue:246/255.0 alpha:1]

@interface DownloadDynamicEffectView ()<UIDynamicAnimatorDelegate>

@property (nonatomic , retain ) UIDynamicAnimator *animator;//物理仿真动画

@property (nonatomic , retain ) UIView *backgroundView;//背景视图

@property (nonatomic , retain ) VBFPopFlatButton *downloadButton;

@property (nonatomic , retain ) UIView *downloadButtonView;

@property (nonatomic , retain ) UIImageView *downloadingImageView;

@property (nonatomic , retain ) UIButton *BDItemButton;//标清按钮

@property (nonatomic , retain ) UIButton *HDItemButton;//高清按钮

@property (nonatomic , retain ) UIButton *FHDItemButton;//超清按钮

@property (nonatomic , retain ) NSMutableArray *ItemButtonArray;//清晰度选项按钮数组

@property (nonatomic , retain ) UIColor *selectedButtonColor;//选中按钮颜色

@property (nonatomic , retain ) UILabel *downloadPromptLabel;//下载提示Label


@property (nonatomic , assign ) BOOL isTouches;//是否允许拦截响应者链


@end

@implementation DownloadDynamicEffectView

-(void)dealloc{
    
    [_animator release];
    
    [_backgroundView release];
    
    [_downloadButton release];
    
    [_downloadingImageView release];
    
    [_downloadButtonView release];
    
    [_BDItemButton release];
    
    [_HDItemButton release];
    
    [_FHDItemButton release];
    
    [_ItemButtonArray release];
    
    [_selectedButtonColor release];
    
    [_downloadPromptLabel release];
    
    
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.userInteractionEnabled = YES;
        
        //初始化背景视图
        
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _backgroundView.backgroundColor = [UIColor clearColor];
        
        _backgroundView.clipsToBounds = YES;
        
        _backgroundView.userInteractionEnabled = YES;
        
        [self addSubview:_backgroundView];
        
        //初始化下载按钮视图
        
        UITapGestureRecognizer *downloadButtonViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(downloadButtonViewTapAction:)];
        
        _downloadButtonView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_backgroundView.frame) - 60 , 0 , 44, 44)];
        
        _downloadButtonView.center = CGPointMake(_downloadButtonView.center.x , CGRectGetHeight(_backgroundView.frame) / 2 );
        
        _downloadButtonView.clipsToBounds = YES;
        
        _downloadButtonView.layer.cornerRadius = 22;
        
        _downloadButtonView.backgroundColor = [UIColor clearColor];
        
        [_downloadButtonView addGestureRecognizer:downloadButtonViewTap];
        
        [_backgroundView addSubview:_downloadButtonView];
        
        //初始化下载中图片视图
        
        _downloadingImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"downloadedimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        _downloadingImageView.frame = CGRectMake(0 , 0 , CGRectGetWidth(_downloadButtonView.frame) , CGRectGetHeight(_downloadButtonView.frame));
        
        _downloadingImageView.backgroundColor = [UIColor clearColor];
        
        _downloadingImageView.tintColor = MAINCOLOER;
        
        [_downloadButtonView addSubview:_downloadingImageView];
        
        
        //初始化下载按钮
        
        _downloadButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(0 , 0 , 22, 22)
                                                            buttonType:buttonDownloadType
                                                           buttonStyle:buttonPlainStyle];
        
        _downloadButton.center = CGPointMake(CGRectGetWidth(_downloadButtonView.frame) / 2 , CGRectGetHeight(_downloadButtonView.frame) / 2 );
        
        _downloadButton.roundBackgroundColor = [UIColor whiteColor];
        
        _downloadButton.lineThickness = 2;
        
        _downloadButton.linesColor = MAINCOLOER;
        
        [_downloadButton addTarget:self
                            action:@selector(downloadButtonPressedAction:)
                         forControlEvents:UIControlEventTouchUpInside];
        
        [_downloadButtonView addSubview:_downloadButton];
        
        
        //初始化清晰度选项按钮
        
        [self initItemButton];
        
        //初始化下载提示Label
        
        _downloadPromptLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 , 0 , CGRectGetWidth(_backgroundView.frame) , CGRectGetHeight(_backgroundView.frame))];
        
        _downloadPromptLabel.text = @"已添加至缓存中心";
        
        _downloadPromptLabel.textColor = [UIColor whiteColor];
        
        _downloadPromptLabel.font = [UIFont systemFontOfSize:20.0f];
        
        _downloadPromptLabel.hidden = YES;//默认隐藏
        
        [_backgroundView addSubview:_downloadPromptLabel];
        
        
        
        
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

#pragma mark ---初始化清晰度选项按钮

- (void)initItemButton{
    
    //初始化清晰度选项按钮数组
    
    _ItemButtonArray = [[NSMutableArray alloc]init];
    
    CGFloat buttonSize = 54;
    
    //初始化超清选项视图
    
    _FHDItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_FHDItemButton setTitle:@"超清" forState:UIControlStateNormal];
    
    [_FHDItemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_FHDItemButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [_FHDItemButton setBackgroundImage:[UIImage imageNamed:@"FHDItemImage"] forState:UIControlStateNormal];
    
    [_FHDItemButton setBackgroundColor:[UIColor clearColor]];
    
    [_FHDItemButton setFrame:CGRectMake(CGRectGetWidth(_backgroundView.frame) - 60 , 0 , buttonSize, buttonSize)];
    
    [_FHDItemButton setCenter:CGPointMake(_FHDItemButton.center.x , CGRectGetHeight(_backgroundView.frame) / 2 )];
    
    [_FHDItemButton addTarget:self action:@selector(itemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backgroundView addSubview:_FHDItemButton];
    
    _FHDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);//默认缩放比例
    
    
    //初始化高清选项视图
    
    _HDItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_HDItemButton setTitle:@"高清" forState:UIControlStateNormal];
    
    [_HDItemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_HDItemButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [_HDItemButton setBackgroundImage:[UIImage imageNamed:@"HDItemImage"] forState:UIControlStateNormal];
    
    [_HDItemButton setBackgroundColor:[UIColor clearColor]];
    
    [_HDItemButton setFrame:CGRectMake(CGRectGetWidth(_backgroundView.frame) - 60 , 0 , buttonSize, buttonSize)];
    
    [_HDItemButton setCenter:CGPointMake(_HDItemButton.center.x , CGRectGetHeight(_backgroundView.frame) / 2 )];
    
    [_HDItemButton addTarget:self action:@selector(itemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backgroundView addSubview:_HDItemButton];
    
    _HDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);//默认缩放比例
    
    
    //初始化标清选项视图
    
    _BDItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_BDItemButton setTitle:@"标清" forState:UIControlStateNormal];
    
    [_BDItemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_BDItemButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [_BDItemButton setBackgroundImage:[UIImage imageNamed:@"BDItemImage"] forState:UIControlStateNormal];
    
    [_BDItemButton setBackgroundColor:[UIColor clearColor]];
    
    [_BDItemButton setFrame:CGRectMake(CGRectGetWidth(_backgroundView.frame) - 60 , 0 , buttonSize, buttonSize)];
    
    [_BDItemButton setCenter:CGPointMake(_BDItemButton.center.x , CGRectGetHeight(_backgroundView.frame) / 2 )];
    
    [_BDItemButton addTarget:self action:@selector(itemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backgroundView addSubview:_BDItemButton];
    
    _BDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);//默认缩放比例
    
    //添加数组
    
    [_ItemButtonArray addObject:_BDItemButton];
    
    [_ItemButtonArray addObject:_HDItemButton];
    
    [_ItemButtonArray addObject:_FHDItemButton];
    
    
    //下载按钮设为最顶层
    
    [_backgroundView bringSubviewToFront:_downloadButtonView];
    
}



#pragma mark ---视图点击事件

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //判断是否拦截响应者链
    
    if (_isTouches == NO) {
        
        [super touchesBegan:touches withEvent:event];
        
    }
    
}

#pragma mark ---下载按钮视图点击事件

- (void)downloadButtonViewTapAction:(UITapGestureRecognizer *)tap{
    
    //调用下载按钮点击事件
    
    [self downloadButtonPressedAction:_downloadButton];
    
}

#pragma mark ---清晰度选项按钮点击事件

- (void)itemButtonAction:(UIButton *)sender{
    
    //获取选中按钮颜色
    
    switch ([self.ItemButtonArray indexOfObject:sender]) {
        case 0:
            
            self.selectedButtonColor = [UIColor colorWithRed:85/255.0 green:232/255.0 blue:163/255.0 alpha:1];
            
            break;
            
        case 1:
            
            self.selectedButtonColor = [UIColor colorWithRed:106/255.0 green:205/255.0 blue:245/255.0 alpha:1];
            
            break;
            
        case 2:
            
            self.selectedButtonColor = [UIColor colorWithRed:239/255.0 green:85/255.0 blue:88/255.0 alpha:1];
            
            break;
            
            
        default:
            break;
    }
    
    //循环遍历按钮
    
    for (UIButton *item in self.ItemButtonArray) {
        
        //根据选项按钮下标进行相应操作
        
        switch ([self.ItemButtonArray indexOfObject:item]) {
            
            case 0:
                
                if (item != sender) {
                    
                    [self itemButtonActionAnimations:item SelectedButton:sender ];
                    
                }
                
                break;
                
            case 1:
                
                if (item != sender) {
                    
                    [self itemButtonActionAnimations:item SelectedButton:sender ];
                    
                }
                
                break;
                
            case 2:
                
                if (item != sender) {
                    
                    [self itemButtonActionAnimations:item SelectedButton:sender ];
                    
                }
                
                break;
                
            default:
                break;
        }
        
    }
    
}

#pragma mark ---清晰度选项按钮点击动画

- (void)itemButtonActionAnimations:(UIButton *)item SelectedButton:(UIButton *)sender{
    
    //目标point (选中的按钮center)
    
    __block CGPoint targetPoint = sender.center;
    
    __block typeof(self) Self = self;
    
    //设置动画
    
    [UIView animateWithDuration:0.2f animations:^{
        
        item.center = targetPoint;
        
        sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2f, 1.2f);
        
    } completion:^(BOOL finished) {
        
        //还原缩放比例 将其他选项按钮隐藏
        
        sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        
        item.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);
        
        sender.titleLabel.hidden = YES;//隐藏按钮标题
        
        [UIView animateWithDuration:0.5f animations:^{
            
            //选中按钮方法20倍占满整个背景视图
            
            sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 20.0f, 20.0f);
            
        } completion:^(BOOL finished) {
            
            //隐藏选中按钮 设置背景视图的背景颜色与选中按钮颜色一致
            
            sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);
            
            sender.titleLabel.hidden = NO;//显示按钮标题
            
            Self.backgroundView.backgroundColor = Self.selectedButtonColor;
            
            //显示下载提示Label
            
            Self.downloadPromptLabel.hidden = NO;
            
            //禁用下载按钮
            
            _downloadButton.enabled = NO;
            
            dispatch_after
            (dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //隐藏下载提示Label
                
                Self.downloadPromptLabel.hidden = YES;
                
                //启用下载按钮
                
                _downloadButton.enabled = YES;
                
                _downloadButton.selected = YES;
                
                [self downloadButtonPressedAction:_downloadButton];
                
            });
            
            
        }];
        
    }];
    
    
    
}

#pragma mark ---下载按钮点击事件

- (void)downloadButtonPressedAction:(UIButton *)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
        
        //设置是否拦截响应者链
        
        _isTouches = NO;
        
        //设置下载按钮样式
        
        [_downloadButton animateToType:buttonDownloadType];
        
        //设置背景视图颜色
        
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    
        //设置下载按钮颜色
        
        _downloadButton.linesColor = [UIColor colorWithRed:105/255.0 green:149/255.0 blue:246/255.0 alpha:1];
        
        //设置下载按钮图片的渲染颜色
        
        _downloadingImageView.tintColor = MAINCOLOER;
        
        //停止加载中动画
        
        [self stopLoadingAnimations];
        
        //收回清晰度选项按钮动画
        
        [self takeBackItemButtonAnimations];
        
        
    } else {
        
        sender.selected = YES;
        
        //设置是否拦截响应者链
        
        _isTouches = YES;
        
        //设置下载按钮样式
        
        [_downloadButton animateToType:buttonCloseType];
        
        //设置背景视图颜色
        
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        
        //设置下载按钮颜色
        
        _downloadButton.linesColor = [UIColor whiteColor];
        
        //设置下载按钮视图颜色
        
        _downloadButtonView.backgroundColor = [UIColor clearColor];
        
        //加载中动画
        
        [self LoadingAnimations];
        
        
        
        
        __block typeof(self) Self = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [Self LoadEndedAnimations];
            
        });

    }
    
    
}


#pragma mark ---加载中动画

- (void)LoadingAnimations{
    
    //设置下载按钮图片
    
    _downloadingImageView.image = [[UIImage imageNamed:@"downloadingimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    _downloadingImageView.tintColor = [UIColor whiteColor];
    
    //设置加载图片旋转动画
    
    [_downloadingImageView.layer addAnimation:[self rotationGear:M_PI * 6.0f] forKey:@"Rotation"];
    
}

#pragma mark ---停止加载中动画

- (void)stopLoadingAnimations{
    
    //设置下载按钮图片
    
    _downloadingImageView.image = [[UIImage imageNamed:@"downloadedimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    //移除加载图片旋转动画
    
    [_downloadingImageView.layer removeAnimationForKey:@"Rotation"];
    
}

#pragma mark ---加载结束动画

- (void)LoadEndedAnimations{
    
    //设置下载按钮图片
    
    _downloadingImageView.image = [[UIImage imageNamed:@"downloadedimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    //移除加载图片旋转动画
    
    [_downloadingImageView.layer removeAnimationForKey:@"Rotation"];
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:0.1f animations:^{
        
        Self.downloadButtonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5f, 0.5f);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1f animations:^{
            
            Self.downloadButtonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2f, 1.2f);
            
        } completion:^(BOOL finished) {
            
            Self.downloadButtonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
            
            //显示清晰度选项按钮动画
            
            [Self showItemButtonAnimations];
            
        }];
        
    }];
    
    
}


#pragma mark ---显示清晰度选项按钮动画

- (void)showItemButtonAnimations{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        //标清按钮动画
        
        Self.BDItemButton.center = CGPointMake(CGRectGetWidth(Self.backgroundView.frame) - 120 , Self.BDItemButton.center.y);
        
        Self.BDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2f, 1.2f);
        
        Self.HDItemButton.center = CGPointMake(Self.BDItemButton.center.x , Self.HDItemButton.center.y);
        
        Self.FHDItemButton.center = CGPointMake(Self.BDItemButton.center.x , Self.FHDItemButton.center.y);
        
    } completion:^(BOOL finished) {
        
        Self.BDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        
        [UIView animateWithDuration:0.15f animations:^{
            
            //高清按钮动画
            
            Self.HDItemButton.center = CGPointMake(CGRectGetWidth(Self.backgroundView.frame) - 190 , Self.HDItemButton.center.y);
            
            Self.HDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2f, 1.2f);
            
            Self.FHDItemButton.center = CGPointMake(Self.HDItemButton.center.x , Self.FHDItemButton.center.y);
            
        } completion:^(BOOL finished) {
            
            Self.HDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
            
            [UIView animateWithDuration:0.1f animations:^{
                
                //超清按钮动画
                
                Self.FHDItemButton.center = CGPointMake(CGRectGetWidth(Self.backgroundView.frame) - 260 , Self.FHDItemButton.center.y);
                
                Self.FHDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
                
            } completion:^(BOOL finished) {
                
                
            }];
            
        }];
        
    }];
    
    
}

#pragma mark ---收回清晰度选项按钮动画

- (void)takeBackItemButtonAnimations{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        //标清按钮动画
        
        Self.BDItemButton.center = CGPointMake(Self.downloadButtonView.center.x , Self.BDItemButton.center.y);
        
        Self.BDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01f, 0.01f);
        
    } completion:^(BOOL finished) {
        
        Self.BDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);
        
        [UIView animateWithDuration:0.15f animations:^{
            
            //高清按钮动画
            
            Self.HDItemButton.center = CGPointMake(Self.downloadButtonView.center.x , Self.HDItemButton.center.y);
            
            Self.HDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01f, 0.01f);
            
        } completion:^(BOOL finished) {
            
            Self.HDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);
            
            [UIView animateWithDuration:0.1f animations:^{
                
                //超清按钮动画
                
                Self.FHDItemButton.center = CGPointMake(Self.downloadButtonView.center.x , Self.FHDItemButton.center.y);
                
                Self.FHDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01f, 0.01f);
                
            } completion:^(BOOL finished) {
                
                Self.FHDItemButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0f, 0.0f);
                
            }];
            
            
        }];
        
        
    }];


    
    
}





#pragma mark ---设置引力物理仿真行为动画

- (void)setDynamicAnimationWith:(UIView *)item TargetPoint:(CGPoint)targetPoint{
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:targetPoint];
    
    [attachmentBehavior setLength:0];
    
    [attachmentBehavior setDamping:0.1f];
    
    [attachmentBehavior setFrequency:2];
    
    [self.animator addBehavior:attachmentBehavior];
    
    [attachmentBehavior release];
    
}

#pragma mark ---旋转动画

- (CABasicAnimation *)rotationGear:(float)degree{
    
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


#pragma mark ---LazyLoading

- (UIDynamicAnimator *)animator
{
    
    if (!_animator) {
        
        // 创建物理仿真器(ReferenceView : 仿真范围)
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_backgroundView];
        
        //设置代理
        
        _animator.delegate = self;
        
    }
    
    return _animator;
    
}



@end
