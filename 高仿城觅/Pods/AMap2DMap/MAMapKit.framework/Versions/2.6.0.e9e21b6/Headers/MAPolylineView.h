//
//  MAPolylineView.h
//  MAMapKitNew
//
//  Created by AutoNavi.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "MAOverlayPathView.h"
#import "MAPolyline.h"

/*!
 @brief 此类是MAPolyline的显示多段线View,可以通过MAOverlayPathView修改其fill和stroke attributes
 */
@interface MAPolylineView : MAOverlayPathView

/*!
 @brief 根据指定的MAPolyline生成一个多段线view
 @param polyline 指定MAPolyline
 @return 新生成的多段线view
 */
- (id)initWithPolyline:(MAPolyline *)polyline;

/*!
 @brief 关联的MAPolyline model
 */
@property (nonatomic, readonly) MAPolyline *polyline;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com