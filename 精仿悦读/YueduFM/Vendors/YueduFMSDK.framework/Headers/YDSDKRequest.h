//
//  YDSDKRequest.h
//  YueduFMSDK
//
//  Created by StarNet on 9/16/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDSDKRequest;
@class YDSDKError;
@class YDSDKConfigModel;

/**
 * 定义请求完成的Block
 *
 * @param request 当前请求项
 * @param successed 请求成功还是失败，当successed=YES表示成功，返回的参数位于request中，当successed=NO表示请求失败，失败原因位于_error中，详见ICError
 *
 */
typedef void(^YDSDKCompletion)(YDSDKRequest* request, YDSDKError* error);

/**
 * 请求基类，所有业务请求都将继承此
 */
@interface YDSDKRequest : NSObject

/** 配置信息，@see YDSDKConfigModel */
@property (nonatomic, strong) YDSDKConfigModel* config;

/** 请求session */
@property (nonatomic, strong) NSURLSession* session;

/** 请求结束回调 */
@property (nonatomic, copy) YDSDKCompletion completion;

/** 请求类方法 */
+ (instancetype)request;

/** 开始请求 */
- (void)start;

/** 取消请求 */
- (void)cancel;

/** 是否需要使用配置（需要在子类实现） */
- (BOOL)shouldUseConfig;

/** 请求的uri（需要在子类实现） */
- (NSString* )uri;

/**
 * 处理返回的数据
 *
 * @param data 返回的数据部分
 */
- (void)processResponseData:(NSDictionary* )data;

@end
