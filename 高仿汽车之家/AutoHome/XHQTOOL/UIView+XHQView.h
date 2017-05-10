//
//  UIView+XHQView.h
//  AutoHome
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XHQView)

/**
 *  x
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  y
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  width
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  height
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  水平方向最大值
 */
@property (nonatomic, assign, readonly) CGFloat maxX;

/**
 *  垂直方向最大值
 */
@property (nonatomic, assign, readonly) CGFloat maxY;

/**
 *  水平中间点
 */
@property (nonatomic, assign, readonly) CGFloat midX;

/**
 *  垂直中间点
 */
@property (nonatomic, assign, readonly) CGFloat midY;




@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com