//
//  YDSDKListRequest.h
//  YueduFMSDK
//
//  Created by StarNet on 9/18/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YDSDKRequest.h>
#import <YueduFMSDK/YDSDKModel.h>

/**
 * 列表请求基类
 */
@interface YDSDKListRequest : YDSDKRequest

/** 返回的列表数据 */
@property (nonatomic, readonly) NSArray* modelArray;

/** 下一个节点 */
@property (nonatomic, readonly) int next;

// 列表中数据的类型
- (Class)modelClass;


@end
