//
//  YDSDKArticleRequest.h
//  YueduFMSDK
//
//  Created by StarNet on 9/16/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YDSDKRequest.h>

@class YDSDKArticleModel;

@interface YDSDKArticleRequest : YDSDKRequest

@property (nonatomic, assign) NSInteger articleId;

@property (nonatomic, readonly) YDSDKArticleModel* model;

@end

