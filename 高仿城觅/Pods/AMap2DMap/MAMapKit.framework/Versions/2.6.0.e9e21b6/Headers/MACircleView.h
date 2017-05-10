//
//  MACircleView.h
//  MAMapKitNew
//
//  Created by AutoNavi.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "MAOverlayPathView.h"
#import "MACircle.h"

/*!
 @brief 该类是MACircle的显示圆View,可以通过MAOverlayPathView修改其fill和stroke attributes
 */
@interface MACircleView : MAOverlayPathView

/*!
 @brief 根据指定圆生成对应的View
 @param circle 指定的MACircle model
 @return 生成的View
 */
- (id)initWithCircle:(MACircle *)circle;

/*!
 @brief 关联的MAcirlce model
 */
@property (nonatomic, readonly) MACircle *circle;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com