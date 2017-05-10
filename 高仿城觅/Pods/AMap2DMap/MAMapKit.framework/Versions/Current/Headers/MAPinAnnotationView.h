//
//  MAPinAnnotationView.h
//  MAMapKit
//
//  Created by AutoNavi.
//  Copyright (c) 2013年 AutoNavi. All rights reserved.
//

#import "MAAnnotationView.h"

typedef NS_ENUM(NSInteger, MAPinAnnotationColor) {
    MAPinAnnotationColorRed = 0,
    MAPinAnnotationColorGreen,
    MAPinAnnotationColorPurple
};

/*!
 @brief 提供类似大头针效果的annotation view
 */
@interface MAPinAnnotationView : MAAnnotationView

/*!
 @brief 大头针的颜色，有MAPinAnnotationColorRed, MAPinAnnotationColorGreen, MAPinAnnotationColorPurple三种
 */
@property (nonatomic) MAPinAnnotationColor pinColor;

/*!
 @brief 动画效果
 */
@property (nonatomic) BOOL animatesDrop;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com