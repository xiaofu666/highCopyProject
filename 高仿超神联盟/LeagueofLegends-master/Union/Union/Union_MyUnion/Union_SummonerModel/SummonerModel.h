//
//  SummonerModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummonerModel : NSObject

@property (nonatomic , assign ) NSInteger sID;//召唤师ID

@property (nonatomic , copy ) NSString *serverName;//服务器名称

@property (nonatomic , copy ) NSString *serverFullName;//服务器全名

@property (nonatomic , copy ) NSString *summonerName;//召唤师名字

@property (nonatomic , copy ) NSString *level;//等级

@property (nonatomic , copy ) NSString *icon;//图标编号

@property (nonatomic , assign ) NSInteger zdl;//战斗力

@property (nonatomic , assign ) NSInteger tier;//段位段级 (无段位为0 青铜为1 白银为2 以此类推)<0 - 7>

@property (nonatomic , assign ) NSInteger rank;//段位层级 (例: 白银1为0 白银2为1 白银5为4) <0 - 4>

@property (nonatomic , copy ) NSString *tierDesc;//段位描述

@property (nonatomic , assign ) NSInteger leaguePoints;//胜点




@end
