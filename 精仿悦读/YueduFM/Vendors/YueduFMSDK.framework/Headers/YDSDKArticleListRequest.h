//
//  YDSDKArticleListRequest.h
//  YueduFMSDK
//
//  Created by StarNet on 9/18/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YDSDKListRequest.h>

/** 获取文章列表 */
@interface YDSDKArticleListRequest : YDSDKListRequest

/** 获取的起点位置 */
@property (nonatomic, assign) int articleId;

@end
