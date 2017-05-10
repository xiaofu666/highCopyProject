//
//  YDSDKModel+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YueduFMSDK.h>

/**
 * 数据模型项目类型
 *
 * YDSDKModelStateNormal 正常状态，默认状态
 * YDSDKModelStateIncomplete 不完整状态
 */

typedef NS_ENUM(int, YDSDKModelState) {
    YDSDKModelStateNormal = 0,
    YDSDKModelStateIncomplete,
};


@interface YDSDKModel (Extension)

@end
