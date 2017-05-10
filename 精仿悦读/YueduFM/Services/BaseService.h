//
//  BaseService.h
//  IntelliCommunity
//
//  Created by Diana on 12/15/14.
//  Copyright (c) 2014 evideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceCenter.h"

typedef NS_ENUM(NSUInteger, ServiceLevel) {
    ServiceLevelLow = 0,
    ServiceLevelMiddle,
    ServiceLevelHigh,
    ServiceLevelHighest,
};

@interface BaseService : NSObject

@property(nonatomic, strong) ServiceCenter*  serviceCenter;

+ (NSArray *) allSubclasses;

+ (ServiceLevel)level;

- (id)initWithServiceCenter:(ServiceCenter*)serviceCenter;

- (void)start;

- (void)stop;

//不带参数app跳转
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url;

//带参数的app跳转for微信
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;
@end
