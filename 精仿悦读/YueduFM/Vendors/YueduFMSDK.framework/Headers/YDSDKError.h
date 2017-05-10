//
//  YDSDKError.h
//  YueduFMSDK
//
//  Created by StarNet on 9/17/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 错误码 */
typedef NS_ENUM(NSUInteger, YDSDKErrorCode) {
    /** 未配置 */
    YDSDKErrorCodeNotConfiged = 10000,
};

/** SDK错误类 */
@interface YDSDKError : NSError

+ (instancetype)errorWithCode:(YDSDKErrorCode)code;

@end
