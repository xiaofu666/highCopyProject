//
//  ConfigService.h
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseService.h"
#import "YDSDKConfigModelEx.h"

@interface ConfigService : BaseService

@property (nonatomic, strong) YDSDKConfigModelEx* config;

@property (nonatomic, assign) BOOL isConfiged;

- (void)fetch:(void(^)(NSError* error))completion;

@end
