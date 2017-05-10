//
//  SmartbiAdaFind+SmartbiAdaDatabaseOperation.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaFind+SmartbiAdaDatabaseOperation.h"
#import "SmartbiAdaDatabaseManager.h"


@implementation SmartbiAdaFind (SmartbiAdaDatabaseOperation)

- (void)saveToDatabaseComplection:(void (^)(BOOL ret))complection
{
    FMDatabaseQueue *databaseQueue = [[SmartbiAdaDatabaseManager shareManager] databaseQueue];
    
    // 把保存的操作放到异步线程中执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // sqlite数据库的REPLACE关键字，以主键为依据，如果数据有对应主键，就更新这一行数据，如果没有就插入
        NSString *saveSQL = @"REPLACE INTO t_find(name,icon,intro,subscribe_count,total_updates,category_id) VALUES(?, ?, ?, ?, ?, ?)";
        
        __block BOOL ret = NO;
        
        [databaseQueue inDatabase:^(FMDatabase *db) {
            
            ret =
            [db executeUpdate:saveSQL,
             self.name,
             self.icon,
             self.intro,
             self.subscribe_count,
             self.total_updates,
             self.category_id
             ];
        }];
        
        // 在主线程回调
        dispatch_async(dispatch_get_main_queue(), ^{
            complection(ret);
        });
    });
}

+ (void)fetchApplicationsFromDatabaseComplection:(void (^)(NSArray *results))complection
{
    NSString *querySQL = @"SELECT * FROM t_find";
    
    FMDatabaseQueue *databaseQueue = [[SmartbiAdaDatabaseManager shareManager] databaseQueue];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *filedKeyStr = @"name, icon, intro, subscribe_count, total_updates, category_id";
        
        NSArray *filedKeys = [filedKeyStr componentsSeparatedByString:@", "];
        NSMutableArray *results = [[NSMutableArray alloc] init];
        
        [databaseQueue inDatabase:^(FMDatabase *db) {
            // 根据sourceURL来查询对应的界面的数据
            FMResultSet *rs = [db executeQuery:querySQL];
            while ([rs next]) {
                SmartbiAdaFind *find=[[SmartbiAdaFind alloc]init];
              
                // 通过KVC的方式把数据填到模型中
                for (NSString *key in filedKeys) {
                    id value = [rs stringForColumn:key];
                    [find setValue:value forKey:key];
                }
                
                [results addObject:find];
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
+(void)deleteAllComplection:(void (^)(BOOL results))complection
{
    
    NSString *deleteSql=@"delete from t_find where 1 = 1";
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
