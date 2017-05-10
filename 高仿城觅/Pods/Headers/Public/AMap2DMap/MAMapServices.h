//
//  MAMapServices.h
//  MapKit_static
//
//  Created by AutoNavi.
//  Copyright (c) 2013年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAMapServices : NSObject

+ (MAMapServices *)sharedServices;

/*!
 @brief API Key, 在创建MAMapView之前需要先绑定key.
 */
@property (nonatomic, copy) NSString *apiKey;

/*!
 @brief SDK 版本号.
 */
@property (nonatomic, readonly) NSString *SDKVersion;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com