//
//  SmartbiAdaHome+SmartbiAdaDatabaseOperationVideo.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaHome+SmartbiAdaDatabaseOperationVideo.h"
#import "SmartbiAdaDatabaseManager.h"


@implementation SmartbiAdaHome (SmartbiAdaDatabaseOperationVideo)



- (void)saveToDatabaseVideoComplection:(void (^)(BOOL ret))complection
{
    FMDatabaseQueue *databaseQueue = [[SmartbiAdaDatabaseManager shareManager] databaseQueue];
    
    // 把保存的操作放到异步线程中执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // sqlite数据库的REPLACE关键字，以主键为依据，如果数据有对应主键，就更新这一行数据，如果没有就插入
        NSString *saveSQL = @"REPLACE INTO t_home_video(avatar_url,name,text,category_name,url_list,digg_count,bury_count,comment_count,share_count,contentSize,pictureSize,large_cover,video_height,mp4_url,share_url,video_width) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        __block BOOL ret = NO;
        
        [databaseQueue inDatabase:^(FMDatabase *db) {
            
            ret =
            [db executeUpdate:saveSQL,
             self.avatar_url,
             self.name,
             self.text,
             self.category_name,
             self.url_list,
             self.digg_count,
             self.bury_count,
             self.comment_count,
             self.share_count,
             self.contentSize,
             self.pictureSize,
             self.large_cover,
             self.video_height,
             self.mp4_url,
             self.share_url,
             self.video_width
             ];
        }];
        
        // 在主线程回调
        dispatch_async(dispatch_get_main_queue(), ^{
            complection(ret);
        });
    });
}

+ (void)fetchApplicationsFromDatabaseVideoComplection:(void (^)(NSArray *results))complection
{
    NSString *querySQL = @"SELECT * FROM t_home_video";
    
    FMDatabaseQueue *databaseQueue = [[SmartbiAdaDatabaseManager shareManager] databaseQueue];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *filedKeyStr = @"avatar_url, name, text, category_name, url_list, digg_count, bury_count, comment_count, share_count, contentSize, pictureSize, large_cover, video_height, mp4_url, share_url, video_width";
        
        NSArray *filedKeys = [filedKeyStr componentsSeparatedByString:@", "];
        NSMutableArray *results = [[NSMutableArray alloc] init];
        
        [databaseQueue inDatabase:^(FMDatabase *db) {
            // 根据sourceURL来查询对应的界面的数据
            FMResultSet *rs = [db executeQuery:querySQL];
            while ([rs next]) {
                SmartbiAdaHome *home=[[SmartbiAdaHome alloc]init];
                
                // 通过KVC的方式把数据填到模型中
                for (NSString *key in filedKeys) {
                    id value = [rs stringForColumn:key];
                    [home setValue:value forKey:key];
                }
                
                [results addObject:home];
            }
        }];
        
        // 结果在主线程中返回
        dispatch_async(dispatch_get_main_queue(), ^{
            complection(results);
        });
    });
}
/*
 删除表内的所有数据
 */
+(void)deleteAllVideoComplection:(void (^)(BOOL results))complection
{
    
    NSString *deleteSql=@"delete from t_home_video where 1 = 1";
    FMDatabaseQueue *databaseQueue = [[SmartbiAdaDatabaseManager shareManager] databaseQueue];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block  BOOL ret =YES;
        [databaseQueue inDatabase:^(FMDatabase *db) {
            
            //            FMResultSet *rs = [db executeQuery:deleteSql];
            ret  = [db executeUpdate:deleteSql];
            
        }];
        // 结果在主线程中返回
        dispatch_async(dispatch_get_main_queue(), ^{
            complection(ret);
        });
    });
    
}

@end
