//
//  YDSDKConfigModel.h
//  YueduFMSDK
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YueduFMSDK.h>

/** 配置Model */
@interface YDSDKConfigModel : YDSDKModel

/** 网址 */
@property (nonatomic, strong) NSString* baseURL;

/** 段值 */
@property (nonatomic, assign) int section;

/** 最新文章id */
@property (nonatomic, assign) int latestArticleId;

/** api后缀 */
@property (nonatomic, strong) NSString* apiSuffix;

/** 频道api */
@property (nonatomic, strong) NSString* apiChannels;

/** 文章api */
@property (nonatomic, strong) NSString* apiArticles;

/** 允许下载 */
@property (nonatomic, assign) BOOL allowDownload;

@end
