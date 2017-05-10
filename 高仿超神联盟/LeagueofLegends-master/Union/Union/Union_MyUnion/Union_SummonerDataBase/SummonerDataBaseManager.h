//
//  SummonerDataBaseManager.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDB.h>

#import "SummonerModel.h"

@interface SummonerDataBaseManager : NSObject


@property (nonatomic ,retain )FMDatabase *db;

+(SummonerDataBaseManager *)shareSummonerDataBaseManager;


//获取documents路径

- (NSString *)documentsPath;

//创建数据库对象

- (void)createDB;

//创建召唤师表

- (void)createSummoner;

//查询召唤师表所有召唤师

- (NSMutableArray *)selectSummoner;

//根据召唤师ID查询

- (SummonerModel *)selectSummonerWithSID:(NSInteger)sID;

//根据召唤师名字和服务器名查询

- (SummonerModel *)selectSummonerWithSummonerName:(NSString *)SummonerName ServerName:(NSString *)serverName;

//添加召唤师

- (BOOL)insertSummoner:(SummonerModel *)summonerModel;

//删除召唤师

- (BOOL)deleteSummoner:(NSInteger)sID;

//删除全部

- (BOOL)deleteSummoner;


//根据召唤师ID更新

- (BOOL)updateSummonerWithSID:(SummonerModel *)summonerModel;


@end
