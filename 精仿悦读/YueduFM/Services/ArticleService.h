//
//  ArticleService.h
//  YueduFM
//
//  Created by StarNet on 9/17/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseService.h"

@class YDSDKArticleModelEx;

@interface ArticleService : BaseService
@property (nonatomic, strong) YDSDKArticleModelEx* activeArticleModel;

- (void)fetchLatest:(void(^)(NSError* error))completion;

//最新的本地文章
- (void)latestLocalArticle:(void(^)(YDSDKArticleModelEx* model))completion;

//列表
- (void)list:(int)count
     channel:(int)channel
  completion:(void (^)(NSArray* array))completion;

//搜索
- (void)list:(int)count
      filter:(NSString* )filter
  completion:(void (^)(NSArray* array))completion;

//我的列表
- (void)listPreplay:(int)count
        completion:(void (^)(NSArray* array))completion;

- (void)nextPreplay:(YDSDKArticleModelEx* )model
         completion:(void (^)(YDSDKArticleModelEx* nextModel))completion;

- (void)deleteAllPreplay:(void (^)())completion;


//最近播放
- (void)listPlayed:(int)count
        completion:(void (^)(NSArray* array))completion;

- (void)deleteAllPlayed:(void (^)())completion;

//收藏
- (void)listFavored:(int)count
         completion:(void (^)(NSArray* array))completion;

- (void)deleteAllFavored:(void (^)())completion;

//下载
- (void)listAllDownloading:(void (^)(NSArray* array))completion;

- (void)listDownloaded:(int)count
            completion:(void (^)(NSArray* array))completion;

- (void)deleteDownloaded:(YDSDKArticleModelEx* )model
              completion:(void (^)(BOOL successed))completion;

- (void)deleteAllDownloaded:(void (^)())completion;

- (void)modelForAudioURLString:(NSString* )URLString
                    completion:(void(^)(YDSDKArticleModelEx* model))completion;

- (void)update:(YDSDKArticleModelEx* )model
    completion:(void(^)(YDSDKArticleModelEx* newModel))completion;

@end
