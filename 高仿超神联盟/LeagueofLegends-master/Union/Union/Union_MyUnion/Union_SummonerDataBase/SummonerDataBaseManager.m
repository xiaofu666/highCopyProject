//
//  SummonerDataBaseManager.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SummonerDataBaseManager.h"

@implementation SummonerDataBaseManager



+(SummonerDataBaseManager *)shareSummonerDataBaseManager{
    
    static SummonerDataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (manager == nil) {
            
            manager = [[SummonerDataBaseManager alloc]init];
            
        }
        
    });
    
    return manager;
    
}


//获取documents路径

- (NSString *)documentsPath{
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return array.firstObject;
    
}

//创建数据库对象

- (void)createDB{
    
    NSString *dbPath = [[self documentsPath] stringByAppendingPathComponent:@"SummonerDB.sqlite"];
    
    self.db = [FMDatabase databaseWithPath:dbPath];
    
//    NSLog(@"数据库地址 %@",dbPath);
    
}

//创建召唤师表

- (void)createSummoner{
    
    //打开数据库
    
    if ([self.db open]) {
        
        //创建表
        
        [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS 't_summoner' ( 'sid' INTEGER NOT NULL , 'serverName' TEXT , 'serverFullName' TEXT, 'summonerName' TEXT,'level' TEXT,'icon' TEXT,'zdl' INTEGER,'tier' INTEGER,'rank' INTEGER,'tierDesc' TEXT,'leaguePoints' INTEGER ,PRIMARY KEY('sid'));"];
        
    }
    
}

//查询召唤师表所有召唤师

- (NSMutableArray *)selectSummoner{
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    //打开数据库
    
    if ([self.db open]) {
        
        //得到结果集
        
        FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_summoner  ORDER BY sid DESC ;"];
        
        while (set.next) {
            
            //创建对象赋值
            
            SummonerModel *item = [[SummonerModel alloc]init];
            
            item.sID = [[set stringForColumn:@"sid"] integerValue];
            
            item.serverName = [set stringForColumn:@"serverName"];
            
            item.serverFullName = [set stringForColumn:@"serverFullName"];
            
            item.summonerName = [set stringForColumn:@"summonerName"];
            
            item.level = [set stringForColumn:@"level"];
            
            item.icon = [set stringForColumn:@"icon"];
            
            item.zdl = [[set stringForColumn:@"zdl"] integerValue];
            
            item.tier = [[set stringForColumn:@"tier"] integerValue];
            
            item.rank = [[set stringForColumn:@"rank"] integerValue];
            
            item.tierDesc = [set stringForColumn:@"tierDesc"];
            
            item.leaguePoints = [[set stringForColumn:@"leaguePoints"] integerValue];
            
            [dataArray addObject:item];
            
        }
        
//        NSLog(@" 数据库查询 : %@",dataArray);
        
    }
    
    
    return dataArray;

}

//根据召唤师ID查询

- (SummonerModel *)selectSummonerWithSID:(NSInteger)sID{
    
    //创建对象赋值
    
    SummonerModel *item = nil;
    
    //打开数据库
    
    if ([self.db open]) {
        
        //得到结果集
        
        FMResultSet *set = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM t_summoner  WHERE sid = %ld ;", (long)sID]];
        
        while (set.next) {
            
            //创建对象赋值
            
            item = [[SummonerModel alloc]init];
            
            item.sID = [[set stringForColumn:@"sid"] integerValue];
            
            item.serverName = [set stringForColumn:@"serverName"];
            
            item.serverFullName = [set stringForColumn:@"serverFullName"];
            
            item.summonerName = [set stringForColumn:@"summonerName"];
            
            item.level = [set stringForColumn:@"level"];
            
            item.icon = [set stringForColumn:@"icon"];
            
            item.zdl = [[set stringForColumn:@"zdl"] integerValue];
            
            item.tier = [[set stringForColumn:@"tier"] integerValue];
            
            item.rank = [[set stringForColumn:@"rank"] integerValue];
            
            item.tierDesc = [set stringForColumn:@"tierDesc"];
            
            item.leaguePoints = [[set stringForColumn:@"leaguePoints"] integerValue];
            
            
        }
        
    }
    
    return item;

    
}

//根据召唤师名字查询

- (SummonerModel *)selectSummonerWithSummonerName:(NSString *)SummonerName ServerName:(NSString *)serverName{
    
    //创建对象赋值
    
    SummonerModel *item = nil;
    
    //打开数据库
    
    if ([self.db open]) {
        
        //得到结果集
        
        FMResultSet *set = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM t_summoner  WHERE  summonerName = '%@' AND serverName = '%@' ;", SummonerName , serverName]];
        
        while (set.next) {
            
            //创建对象赋值
            
            item = [[SummonerModel alloc]init];
            
            item.sID = [[set stringForColumn:@"sid"] integerValue];
            
            item.serverName = [set stringForColumn:@"serverName"];
            
            item.serverFullName = [set stringForColumn:@"serverFullName"];
            
            item.summonerName = [set stringForColumn:@"summonerName"];
            
            item.level = [set stringForColumn:@"level"];
            
            item.icon = [set stringForColumn:@"icon"];
            
            item.zdl = [[set stringForColumn:@"zdl"] integerValue];
            
            item.tier = [[set stringForColumn:@"tier"] integerValue];
            
            item.rank = [[set stringForColumn:@"rank"] integerValue];
            
            item.tierDesc = [set stringForColumn:@"tierDesc"];
            
            item.leaguePoints = [[set stringForColumn:@"leaguePoints"] integerValue];
            
        }
        
    }
    
    return item;
    
}

//添加召唤师

- (BOOL)insertSummoner:(SummonerModel *)summonerModel{
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO 't_summoner' ( 'serverName' , 'serverFullName' , 'summonerName' , 'level' , 'icon' , 'zdl' , 'tier' , 'rank' , 'tierDesc', 'leaguePoints') VALUES ( '%@' , '%@' , '%@' , '%@' , '%@' , %ld , %ld , %ld , '%@' , %ld );", summonerModel.serverName , summonerModel.serverFullName , summonerModel.summonerName , summonerModel.level , summonerModel.icon , (long)summonerModel.zdl , (long)summonerModel.tier , (long)summonerModel.rank , summonerModel.tierDesc , (long)summonerModel.leaguePoints];
    
    return [self.db executeUpdate:sqlStr];
    
}

//删除召唤师

- (BOOL)deleteSummoner:(NSInteger)sID{
    
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM 't_summoner' WHERE sid = %ld ;" , (long)sID];
    
    return [self.db executeUpdate:sqlStr];
    
}

//删除全部

- (BOOL)deleteSummoner{
    
    return [self.db executeUpdate:@"DELETE FROM 't_summoner';"];
    
}


//根据召唤师ID更新

- (BOOL)updateSummonerWithSID:(SummonerModel *)summonerModel{
    
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE 't_summoner' SET 'level' = '%@' , 'icon' = '%@' ,'zdl' = %ld , 'tier' = %ld ,'rank' = %ld , 'tierDesc' = '%@' , 'leaguePoints' = %ld  WHERE 'sid' = %ld;" , summonerModel.level , summonerModel.icon , (long)summonerModel.zdl , (long)summonerModel.tier , (long)summonerModel.rank , summonerModel.tierDesc , (long)summonerModel.leaguePoints , (long)summonerModel.sID];
    
    return [self.db executeUpdate:sqlStr];
    

}


@end
