//
//  YDSDKConfigRequest.h
//  YueduFMSDK
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YueduFMSDK.h>

@class YDSDKConfigModel;

/** 配置请求，需要最先获取，以便完成其他业务 */
@interface YDSDKConfigRequest : YDSDKRequest

/** 返回的配置信息 */
@property (nonatomic, readonly) YDSDKConfigModel* model;

@end
