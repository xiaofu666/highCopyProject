//
//  YDSDKArticleModel.h
//  YueduFMSDK
//
//  Created by StarNet on 9/16/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YueduFMSDK.h>

/** 文章Model */
@interface YDSDKArticleModel : YDSDKModel

/** 频道 */
@property (nonatomic, assign) int channel;

/** 文章url */
@property (nonatomic, strong) NSString* url;

/** 文章标题 */
@property (nonatomic, strong) NSString* title;

/** 文章作者 */
@property (nonatomic, strong) NSString* author;

/** 播音员 */
@property (nonatomic, strong) NSString* speaker;

/** 时长 */
@property (nonatomic, assign) int duration;

/** 播放次数 */
@property (nonatomic, assign) int playCount;

/** 图片 */
@property (nonatomic, strong) NSString* pictureURL;

/** 声音url */
@property (nonatomic, strong) NSString* audioURL;

/** 摘要 */
@property (nonatomic, strong) NSString* abstract;

@end
