//
//  SettingsService.h
//  YueduFM
//
//  Created by StarNet on 9/27/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseService.h"

@interface SettingsService : BaseService

@property (nonatomic, assign) BOOL flowProtection; //流量保护

@property (nonatomic, readonly) NSArray* autoCloseTimes; //分钟
@property (nonatomic, assign) NSInteger autoCloseLevel;
@property (nonatomic, assign) int autoCloseRestTime; //秒

@end
