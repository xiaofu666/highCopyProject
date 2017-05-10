//
//  YDSDKArticleModelEx.h
//  YueduFM
//
//  Created by StarNet on 9/22/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <YueduFMSDK/YueduFMSDK.h>

@interface YDSDKArticleModel (YDSDKArticleModelEx)

@end

typedef NS_ENUM(int, DownloadState) {
    DownloadStateNormal = 0,
    DownloadStateDoing,
    DownloadStateSuccessed,
    DownloadStateFailed,
    DownloadStateCanceled,
};

@interface YDSDKArticleModelEx : YDSDKArticleModel

@property (nonatomic, assign) YDSDKModelState state;

@property (nonatomic, assign) BOOL isFavored;
@property (nonatomic, assign) DownloadState downloadState;
@property (nonatomic, strong) NSString* downloadURLString;
@property (nonatomic, strong) NSDate* downloadDate;
@property (nonatomic, strong) NSDate* playedDate;
@property (nonatomic, strong) NSDate* preplayDate;

@end
