//
//  LocationManager.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/28.
//  Copyright © 2015年 LYoung. All rights reserved.
//  当前位置管理

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationBlock)(CLLocation *currentLocation,NSString *cityName);

@interface LocationManager : NSObject

+ (LocationManager *)sharedFOLClient;

/**
 *  获取地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) currentLocation:(LocationBlock)locationBlock;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com