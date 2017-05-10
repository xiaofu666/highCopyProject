//
//  YDSDKManager.h
//  YueduFMSDK
//
//  Created by StarNet on 9/16/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YueduFMSDK/YDSDKRequest.h>

@class YDSDKConfigModel;

/** SDK管理器 */
@interface YDSDKManager : NSObject

+ (instancetype)defaultManager;

/** 获取YDSDKConfigModel后必须设置，否则后续业务无法执行 */
@property (nonatomic, strong) YDSDKConfigModel* config;

/**
 * 异步发送请求
 *
 * @param request 待发送的请求
 * @param completion 请求完成的回调函数（详见ICCompletion定义）
 *
 */
- (YDSDKRequest* )request:(YDSDKRequest* )request completion:(YDSDKCompletion)completion;

/**
 * 取消请求
 *
 * @param request 要取消的请求，由request:completion返回
 */
- (void)cancelRequest:(YDSDKRequest* )request;

/**
 * 取消所有请求
 */
- (void)cancelAllRequest;

@end
