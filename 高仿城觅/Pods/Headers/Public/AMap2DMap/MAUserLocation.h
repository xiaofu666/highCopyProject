//
//  MAUserLocation.h
//  MAMapKit
//
//  Created by AutoNavi.
//  Copyright (c) 2012年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAAnnotation.h"

@class CLLocation;
@class CLHeading;

/*!
 @brief 定位信息类
 */
@interface MAUserLocation : NSObject<MAAnnotation>

/*!
 @brief 位置更新状态，如果正在更新位置信息，则该值为YES.
 */
@property (readonly, nonatomic, getter = isUpdating) BOOL updating;

/*!
 @brief 位置信息, 如果MAMapView的showsUserLocation为NO, 或者尚未定位成功, 则该值为nil.
 */
@property (readonly, nonatomic, retain) CLLocation *location;

/*!
 @brief heading信息.
 */
@property (readonly, nonatomic, retain) CLHeading *heading;

/*!
 @brief 定位标注点要显示的标题信息.
 */
@property (nonatomic, copy) NSString *title;

/*!
 @brief 定位标注点要显示的子标题信息.
 */
@property (nonatomic, copy) NSString *subtitle;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com