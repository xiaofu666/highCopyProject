//
//  WNXUserInfoView.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/15.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNXUserInfoView : UIView

//便利构造方法
+ (instancetype)userInfoView;

//传入userInfoViewY轴滚动的距离,内部计算顶部的头像位置
- (void)userInfViewScrollOffsetY:(CGFloat)offsetY;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com