//
//  WNXPromptView.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/12.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  提醒用的View

#import <UIKit/UIKit.h>

@interface WNXPromptView : UIView

- (void)showPromptViewToView:(UIView *)superView;

- (void)hidePromptViewToView;

+ (instancetype)promptView;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com