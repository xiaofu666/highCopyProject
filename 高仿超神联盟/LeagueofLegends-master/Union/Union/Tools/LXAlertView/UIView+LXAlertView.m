//
//  UIView+LXAlertView.m
//  LXAlertView
//
//  Created by HarrisHan on 2/16/15.
//  Copyright (c) 2015 Persource. All rights reserved.
//

#import "UIView+LXAlertView.h"

#import "AppDelegate.h"

#import <QuartzCore/QuartzCore.h>

#import "PCH.h"

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define NOTIFIER_LABEL_FONT ([UIFont fontWithName:@"HelveticaNeue-Light" size:18])

#define NOTIFIER_CANCEL_FONT ([UIFont fontWithName:@"HelveticaNeue" size:13])

static const NSInteger kTagLXAlertView = 19940;

static const NSInteger xPadding = 18.0;

static const CGFloat kLabelHeight = 45.0f;

static const CGFloat kCancelButtonHeight = 30.0f;

static const CGFloat kSeparatorHeight = 1.0f;

static const CGFloat kHeightFromBottom = 70.f;

static const CGFloat kMaxWidth = 290.0f;



@implementation UIView (LXAlertView)

+ (void) addLXNotifierWithText : (NSString* ) text dismissAutomatically : (BOOL) shouldDismiss {
    
    //获得屏幕区域
   
    CGRect screenBounds = APPDELEGATE.window.bounds;

    //获取文本的宽度
   
    NSDictionary *attributeDict = @{NSFontAttributeName : NOTIFIER_LABEL_FONT};
    CGFloat height = kLabelHeight;
    CGFloat width = CGFLOAT_MAX;
    CGRect notifierRect = [text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:NULL];
    
    //获取通知视图xoffset
    
    CGFloat notifierWidth = MIN(CGRectGetWidth(notifierRect) + 2*xPadding, kMaxWidth);
   
    CGFloat xOffset = (CGRectGetWidth(screenBounds) - notifierWidth)/2;

    //通知视图添加高度  如果没有自动退出 添加取消按钮
  
    NSInteger notifierHeight = kLabelHeight;
    if(!shouldDismiss) {
        notifierHeight += (kCancelButtonHeight+kSeparatorHeight);
    }

    //获取通知视图yOffset
    
    CGFloat yOffset = CGRectGetHeight(screenBounds) - notifierHeight - kHeightFromBottom;
    
    CGRect finalFrame = CGRectMake(xOffset, yOffset, notifierWidth, notifierHeight);

    UIView* notifierView = [self checkIfNotifierExistsAlready];
  
    
    //判断通知视图是否为空
    
    if(notifierView) {
        
        //更新现有通知
        
        [self updateNotifierWithAnimation:notifierView withText:text completion:^(BOOL finished) {
        
            CGRect atLastFrame = finalFrame;
            
            atLastFrame.origin.y = finalFrame.origin.y + 8;
            
            notifierView.frame = atLastFrame;

        
            //获取标签并更新其文本和帧
        
            UILabel* textLabel = nil;
            
            for (UIView* subview in notifierView.subviews) {
            
                if([subview isKindOfClass:[UILabel class]]) {
                
                    textLabel = (UILabel* ) subview;
                
                }
                
                //还清除分离器和“取消”按钮。如果需要，我们可以添加它
                
                if([subview isKindOfClass:[UIImageView class]] || [subview isKindOfClass:[UIButton class]]) {
                
                    [subview removeFromSuperview];
                
                }
           
            }
            
            textLabel.text = text;
            
            textLabel.frame = CGRectMake(xPadding, 0.0, notifierWidth - 2*xPadding, kLabelHeight);
            
            //如果不退出
            
            if(!shouldDismiss) {
                
                //首先显示一个分隔图片
                
                UIImageView* separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(textLabel.frame), CGRectGetWidth(notifierView.frame), kSeparatorHeight)];
                
                [separatorImageView setBackgroundColor:UIColorFromRGB(0xF94137)];
                
                [notifierView addSubview:separatorImageView];
                
                
                //添加取消按钮
                
                UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
                
                buttonCancel.frame = CGRectMake(0.0, CGRectGetMaxY(separatorImageView.frame), CGRectGetWidth(notifierView.frame), kCancelButtonHeight);
                
                [buttonCancel setBackgroundColor:UIColorFromRGB(0x000000)];
                [buttonCancel addTarget:self action:@selector(buttonCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
                [buttonCancel setTitle:@"确认" forState:UIControlStateNormal];
                buttonCancel.titleLabel.font = NOTIFIER_CANCEL_FONT;
               
                [notifierView addSubview:buttonCancel];

            }

            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                notifierView.alpha = 1;
                notifierView.frame = finalFrame;
            } completion:^(BOOL finished) {
            
            }];
        
        }];

        if(shouldDismiss) {
        
            [self performSelector:@selector(dismissLXNotifier) withObject:nil afterDelay:2.0];
        
        }
    }
    else {
        
        //创建通知视图
        
        notifierView = [[UIView alloc] initWithFrame:CGRectMake(xOffset, CGRectGetHeight(screenBounds), notifierWidth, notifierHeight)];
        notifierView.backgroundColor = UIColorFromRGB(0xF94137);
        notifierView.tag = kTagLXAlertView;
        notifierView.clipsToBounds = YES;
        notifierView.layer.cornerRadius = 5.0;
        [APPDELEGATE.window addSubview:notifierView];
        [APPDELEGATE.window bringSubviewToFront:notifierView];
        
        //添加点击手势
        
        UITapGestureRecognizer *notifierViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(notifierViewTapAction:)];
        
        [notifierView addGestureRecognizer:notifierViewTap];
       
        
        //创建内容标签
       
        UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, 0.0, notifierWidth - 2*xPadding, kLabelHeight)];
        textLabel.adjustsFontSizeToFitWidth = YES;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = UIColorFromRGB(0xFFFFFF);
        textLabel.font = NOTIFIER_LABEL_FONT;
        textLabel.minimumScaleFactor = 0.7;
        textLabel.text = text;
        [notifierView addSubview:textLabel];
        
        if(shouldDismiss) {
            
            [self performSelector:@selector(dismissLXNotifier) withObject:nil afterDelay:2.0];
        }
        else {
            
            //不dismissng自动…显示“取消”按钮以解除该警报
            
            //首先显示一个分隔图片
           
            UIImageView* separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(textLabel.frame), notifierWidth, kSeparatorHeight)];
            [separatorImageView setBackgroundColor:UIColorFromRGB(0xF94137)];
            [notifierView addSubview:separatorImageView];
            
            //添加取消按钮
           
            UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonCancel.frame = CGRectMake(0.0, CGRectGetMaxY(separatorImageView.frame), notifierWidth, kCancelButtonHeight);
            [buttonCancel setBackgroundColor:UIColorFromRGB(0x000000)];
            [buttonCancel addTarget:self action:@selector(buttonCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttonCancel setTitle:@"确认" forState:UIControlStateNormal];
            buttonCancel.titleLabel.font = NOTIFIER_CANCEL_FONT;
            [notifierView addSubview:buttonCancel];
        
        }
        
        [self startEntryAnimation:notifierView withFinalFrame:finalFrame];
    
    }

}

+ (UIView* ) checkIfNotifierExistsAlready {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissLXNotifier) object:nil];
    
    UIView* notifier = nil;
  
    for (UIView* subview in [APPDELEGATE.window subviews]) {
    
        if(subview.tag == kTagLXAlertView && [subview isKindOfClass:[UIView class]]) {
        
            notifier = subview;
        
        }
    
    }

    return notifier;
}

+ (void) dismissLXNotifier {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissLXNotifier) object:nil];

    UIView* notifier = nil;
    
    for (UIView* subview in [APPDELEGATE.window subviews]) {
        
        if(subview.tag == kTagLXAlertView && [subview isKindOfClass:[UIView class]]) {
        
            notifier = subview;
        
        }
    
    }
    
    [self startExitAnimation:notifier];
    
}

+ (void) buttonCancelClicked : (id) sender {
    
    [self dismissLXNotifier];

}

+ (void) notifierViewTapAction:(UITapGestureRecognizer *)tap{
    
    [self dismissLXNotifier];
    
}



#pragma mark - Animation 动画部分

+ (void) updateNotifierWithAnimation : (UIView* ) notifierView withText : (NSString* ) text completion:(void (^)(BOOL finished))completion {
   
    CGRect finalFrame = notifierView.frame;
    
    finalFrame.origin.y = finalFrame.origin.y + 8;
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        notifierView.alpha = 0;
        notifierView.frame = finalFrame;
    } completion:^(BOOL finished) {
        completion(finished);
    }];

}

+ (void) startEntryAnimation : (UIView* ) notifierView withFinalFrame : (CGRect) finalFrame {
    
    CGFloat finalYOffset = finalFrame.origin.y;
    
    finalFrame.origin.y = finalFrame.origin.y - 15;
    
    CATransform3D transform = [self transformWithXAxisValue:-0.1 andAngle:45];
    
    notifierView.layer.zPosition = 400;
    
    notifierView.layer.transform = transform;

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        notifierView.frame = finalFrame;
        
        CATransform3D transform = [self transformWithXAxisValue:0.1 andAngle:15];
        
        notifierView.layer.zPosition = 400;
        
        notifierView.layer.transform = transform;

    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
            CGRect atLastFrame = finalFrame;
            
            atLastFrame.origin.y = finalYOffset;
            
            notifierView.frame = atLastFrame;
            
            
            CATransform3D transform = [self transformWithXAxisValue:0.0 andAngle:90];
            
            notifierView.layer.zPosition = 400;
            
            notifierView.layer.transform = transform;

        } completion:^(BOOL finished) {
            
        }];
    }];
}

+ (void) startExitAnimation : (UIView* ) notifierView {
    
    //获得屏幕区域
   
    CGRect screenBounds = APPDELEGATE.window.bounds;

    CGRect notifierFrame = notifierView.frame;
   
    CGFloat finalYOffset = notifierFrame.origin.y - 12;
    
    notifierFrame.origin.y = finalYOffset;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        notifierView.frame = notifierFrame;
        
        CATransform3D transform = [self transformWithXAxisValue:0.1 andAngle:30];
        
        notifierView.layer.zPosition = 400;
        
        notifierView.layer.transform = transform;

    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect atLastFrame = notifierView.frame;
        
            atLastFrame.origin.y = CGRectGetHeight(screenBounds);
            
            notifierView.frame = atLastFrame;
            
            CATransform3D transform = [self transformWithXAxisValue:-1 andAngle:90];
            
            notifierView.layer.zPosition = 400;
            
            notifierView.layer.transform = transform;

        } completion:^(BOOL finished) {
            
            [notifierView removeFromSuperview];
            
            [self removeNotifierView:notifierView];
            
        }];
        
    }];
    
}

+ (void)removeNotifierView:(UIView *)notifierView{
    
    notifierView = nil;
    
}

+ (CATransform3D) transformWithXAxisValue : (CGFloat) xValue  andAngle : (CGFloat) valueOfAngle {
   
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = 1.0 / -1000;
    
    //将旋转对象在x = 0轴，y = 1，z = -0.3f
    
    transform = CATransform3DRotate(transform, valueOfAngle * M_PI / 180.0f, xValue, 0.0, 0.);
    
    return transform;

}

@end