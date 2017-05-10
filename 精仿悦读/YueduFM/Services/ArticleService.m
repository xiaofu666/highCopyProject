//
//  ArticleService.m
//  YueduFM
//
//  Created by StarNet on 9/17/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ArticleService.h"
#import "YDSDKArticleModelEx.h"

@interface ArticleService () {
}

@end

@implementation ArticleService

+ (ServiceLevel)level {
    return ServiceLevelMiddle;
}

- (id)initWithServiceCenter:(ServiceCenter*)serviceCenter
{
    self = [super initWithServiceCenter:serviceCenter];
    if (self) {
        [self.dataManager registerClass:[YDSDKArticleModelEx class] complete:nil];
    }
    return self;
}


- (void)start {
    [self autoFetch:nil];
    [self updateActiveArticleModel];
}

- (void)autoFetch:(void(^)())completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"state=%d ORDER BY aid DESC LIMIT 0,1", YDSDKModelStateIncomplete] complete:^(BOOL successed, id result) {
        if (successed && [result count]) {
            YDSDKArticleModelEx* model = [result firstObject];
            [self fetch:model.aid completion:^(NSArray* array, NSError *error) {
                if (completion) completion();
                [self autoFetch:nil];
            }];
        } else {
            if (completion) completion();
        }
    }];
}

- (void)latestLocalArticle:(void(^)(YDSDKArticleModelEx* model))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"state=%d ORDER BY aid DESC LIMIT 0,1", YDSDKModelStateNormal] complete:^(BOOL successed, id result) {
        if (completion) {
            completion(successed?[result firstObject]:nil);
        }
    }];
}

- (void)updateActiveArticleModel {
    if (!self.activeArticleModel) {
        [self listPreplay:1 completion:^(NSArray *array) {
            if ([array firstObject]) {
                self.activeArticleModel = [array firstObject];
            }
        }];
    }
}

- (void)checkout:(int)count
         channel:(int)channel
      completion:(void(^)(NSArray* array))completion {
    if (channel) {
        [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"state=%d and channel=%d ORDER BY aid DESC LIMIT 0, %d", YDSDKModelStateNormal, channel, count] complete:^(BOOL successed, id result) {
            if (completion) completion(successed?result:nil);
        }];
    } else {
        [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"state=%d ORDER BY aid DESC LIMIT 0, %d", YDSDKModelStateNormal, count] complete:^(BOOL successed, id result) {
            if (completion) completion(successed?result:nil);
        }];
    }
}

- (void)modelForAudioURLString:(NSString* )URLString completion:(void(^)(YDSDKArticleModelEx* model))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"audioURL='%@' LIMIT 0, 1", URLString] complete:^(BOOL successed, id result) {
        if (completion) {
            completion(successed?[result firstObject]:nil);
        }
    }];
    
}

- (void)fetchLatest:(void(^)(NSError* error))completion {
    [self.dataManager count:[YDSDKArticleModelEx class] condition:nil complete:^(BOOL successed, id result) {
        BOOL none = successed && ![result intValue];
        [self fetch:0 completion:^(NSArray* array, NSError *error) {
            if (!error) {
                if (!self.activeArticleModel) {
                    self.activeArticleModel = [YDSDKArticleModelEx objectFromSuperObject:[array firstObject]];
                }
                //为了防止第一次数据不够，多加载一次
                if (none) {
                    [self autoFetch:^{
                        if (completion) completion(error);
                    }];
                } else {
                    [self autoFetch:nil];
                    if (completion) completion(error);
                }
            } else {
                if (completion) completion(error);
            }
        }];
        
    }];
}

- (void)listPreplay:(int)count
         completion:(void (^)(NSArray* array))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"preplayDate > 0 ORDER BY preplayDate LIMIT 0, %d", count] complete:^(BOOL successed, id result) {
        if (completion) {
            completion(successed?result:nil);
        }
    }];
}

- (void)nextPreplay:(YDSDKArticleModelEx* )model
         completion:(void (^)(YDSDKArticleModelEx* nextModel))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"preplayDate > %f ORDER BY preplayDate LIMIT 0, 1", model.preplayDate.timeIntervalSince1970] complete:^(BOOL successed, id result) {
        if (completion) {
            completion(successed?[result firstObject]:nil);
        }
    }];
}


- (void)deleteAllPreplay:(void (^)())completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:@"preplayDate>0" complete:^(BOOL successed, id result) {
        if (successed) {
            NSMutableArray* array = [NSMutableArray array];
            [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                YDSDKArticleModelEx* model = obj;
                model.preplayDate = [NSDate dateWithTimeIntervalSince1970:0];
                [array addObject:model];
            }];
            
            [self.dataManager writeObjects:array complete:^(BOOL successed, id result) {
                if (completion) completion();
            }];
        } else {
            if (completion) completion();
        }
    }];
}

- (void)listPlayed:(int)count completion:(void (^)(NSArray* array))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"playedDate > 0 ORDER BY playedDate DESC LIMIT 0, %d", count] complete:^(BOOL successed, id result) {
        if (completion) {
            completion(successed?result:nil);
        }
    }];
}

- (void)deleteAllPlayed:(void (^)())completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:@"playedDate>0" complete:^(BOOL successed, id result) {
        if (successed) {
            NSMutableArray* array = [NSMutableArray array];
            [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                YDSDKArticleModelEx* model = obj;
                model.playedDate = [NSDate dateWithTimeIntervalSince1970:0];
                [array addObject:model];
            }];
            
            [self.dataManager writeObjects:array complete:^(BOOL successed, id result) {
                if (completion) completion();
            }];
        } else {
            if (completion) completion();
        }
    }];
}

- (void)list:(int)count
     channel:(int)channel
  completion:(void (^)(NSArray* array))completion {
    [self checkout:count channel:channel completion:completion];
}

- (void)list:(int)count
      filter:(NSString* )filter
  completion:(void (^)(NSArray* array))completion {
    if (filter.length == 0) {
        if (completion) completion(nil);
    } else {
        [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"title LIKE '%%%@%%' OR author LIKE '%%%@%%' OR speaker LIKE '%%%@%%'  LIMIT 0, %d", filter, filter, filter, count] complete:^(BOOL successed, id result) {
            if (completion) completion(successed?result:nil);
        }];
    }
}

- (void)listFavored:(int)count completion:(void (^)(NSArray* array))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"isFavored=1 ORDER BY aid DESC LIMIT 0, %d", count] complete:^(BOOL successed, id result) {
        if (completion) completion(successed?result:nil);
    }];
}

- (void)update:(YDSDKArticleModelEx* )model completion:(void(^)(YDSDKArticleModelEx* newModel))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"aid=%d", model.aid] complete:^(BOOL successed, id result) {
        YDSDKArticleModelEx* newModel = successed?[result firstObject]:nil;
        [model updateForObject:newModel];

        if (completion) {
            completion(model);
        }
    }];
}

- (void)listAllDownloading:(void (^)(NSArray* array))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"downloadState=%d ORDER BY downloadDate DESC", DownloadStateDoing] complete:^(BOOL successed, id result) {
        if (completion) completion(successed?result:nil);
    }];
}

- (void)listDownloaded:(int)count completion:(void (^)(NSArray* array))completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"downloadState=%d ORDER BY downloadDate DESC LIMIT 0, %d", DownloadStateSuccessed, count] complete:^(BOOL successed, id result) {
        if (completion) completion(successed?result:nil);
    }];
}

- (void)deleteDownloaded:(YDSDKArticleModelEx* )model completion:(void (^)(BOOL successed))completion {
    model.downloadState = DownloadStateNormal;
    NSError* error;
    [[NSFileManager defaultManager] removeItemAtPath:model.downloadURLString error:&error];
    
    [self.dataManager writeObject:model complete:^(BOOL successed, id result) {
        if (completion) completion(successed);
    }];
}

- (void)deleteAllDownloaded:(void (^)())completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:[NSString stringWithFormat:@"downloadState=%d", DownloadStateSuccessed] complete:^(BOOL successed, id result) {
        if (successed) {
            NSMutableArray* array = [NSMutableArray array];
            [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                YDSDKArticleModelEx* model = obj;
                model.downloadState = DownloadStateNormal;
                [array addObject:model];
            }];
            
            [self.dataManager writeObjects:array complete:^(BOOL successed, id result) {
                if (completion) completion();
            }];
        } else {
            if (completion) completion();
        }
        
        [SRV(DownloadService) deleteAllDownloadedFiles];
    }];
}

- (void)deleteAllFavored:(void (^)())completion {
    [self.dataManager read:[YDSDKArticleModelEx class] condition:@"isFavored=1" complete:^(BOOL successed, id result) {
        if (successed) {
            NSMutableArray* array = [NSMutableArray array];
            [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                YDSDKArticleModelEx* model = obj;
                model.isFavored = NO;
                [array addObject:model];
            }];
            
            [self.dataManager writeObjects:array complete:^(BOOL successed, id result) {
                if (completion) completion();
            }];
        } else {
            if (completion) completion();
        }
    }];
}


- (void)fetch:(int)articleId completion:(void(^)(NSArray* array, NSError* error))completion {
    [SRV(ConfigService) fetch:^(NSError *error) {
        YDSDKArticleListRequest* req = [YDSDKArticleListRequest request];
        req.articleId = articleId;
        [self.netManager request:req completion:^(YDSDKRequest *request, YDSDKError *error) {
            if (!error) {
                YDSDKArticleModel* cursorModel = [[YDSDKArticleModel alloc] init];
                cursorModel.aid = articleId;
                
                NSMutableArray* data = [NSMutableArray arrayWithArray:req.modelArray];
                [self.dataManager deleteObject:cursorModel complete:^(BOOL successed, id result) {
                    void(^writeBlock)(NSArray* array) = ^(NSArray* array){
                        [self.dataManager writeObjects:array complete:^(BOOL successed, id result) {
                            if (completion) completion(array, nil);
                        }];
                    };
                    
                    if (req.next) {
                        YDSDKArticleModelEx* nextModel = [[YDSDKArticleModelEx alloc] init];
                        nextModel.aid = req.next;
                        nextModel.state = YDSDKModelStateIncomplete;
                        [self.dataManager isExist:nextModel complete:^(BOOL successed, id result) {
                            if (!successed) [data addObject:nextModel];
                            writeBlock(data);
                        }];
                    } else {
                        writeBlock(data);
                    }
                }];
            } else {
                if (completion) completion(nil, error);
            }
        }];        
    }];
}

@end
