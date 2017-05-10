//
//  XHQZUIXINDatabase.m
//  AutoHome
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQZUIXINDatabase.h"

@implementation XHQZUIXINDatabase
+ (instancetype)sharedManager {
    
    static XHQZUIXINDatabase *_manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/XHQDatabase.db"];
        // 实例化
        _manager = [[XHQZUIXINDatabase alloc] initWithPath:path];
        // 打开数据库
        [_manager open];
        // 建表
        [_manager createTable];
    });
    
    return _manager;
}
// 建表
- (void)createTable {
    NSString *sql = @"create table if not exists XHQDatabase(count primary key, image, title,pubDate,url)";
    // 执行更新语句
    [self executeUpdate:sql];
}

// 增
- (void)addRecord:(XHQZuiXinModel *)model {
    NSString *sql = @"insert into XHQDatabase (count, image, title,pubDate,url) values (?, ?, ?,?,?)";
    
    [self executeUpdate:sql, model.count, model.image, model.title, model.pubDate,model.url];
}
// 删除
- (void)deleteRecord:(XHQZuiXinModel *)model {
    NSString *sql = @"delete from XHQDatabase where count= ?";
    
    [self executeUpdate:sql, model.count];
}


// 查询所有数据
- (NSArray *)findAll {
    NSString *sql = @"select * from XHQDatabase";
    
    FMResultSet *set = [self executeQuery:sql];
    
    // 实例化一个可变数组, 接收数据
    NSMutableArray *allData = [[NSMutableArray alloc] init];
    
    while (set.next) {
        XHQZuiXinModel *model = [[XHQZuiXinModel alloc]init];
        model.count =  [set objectForColumnName:@"count"];
        model.image = [set objectForColumnName:@"image"];
        model.title = [set objectForColumnIndex:2];
        model.pubDate = [set objectForColumnIndex:3];
        model.url = [set objectForColumnIndex:4];
        // 添加数据
        [allData addObject:model];
    }
    // 把所有结果返回
    return allData;
}
// 查询某条数据是否存在
- (BOOL)modelIsExists:(XHQZuiXinModel *)model {
    
    NSString *sql = @"select * from XHQDatabase where count = ?";
    
    FMResultSet *set = [self executeQuery:sql, model.count];
    
    return set.next;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com