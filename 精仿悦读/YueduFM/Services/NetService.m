//
//  NetService.m
//  YueduFM
//
//  Created by StarNet on 9/22/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "NetService.h"

@implementation BaseService (NetService)

- (YDSDKManager* )netManager {
    return [YDSDKManager defaultManager];
}

@end

@implementation NetService

+ (ServiceLevel)level {
    return ServiceLevelHighest;
}

@end
