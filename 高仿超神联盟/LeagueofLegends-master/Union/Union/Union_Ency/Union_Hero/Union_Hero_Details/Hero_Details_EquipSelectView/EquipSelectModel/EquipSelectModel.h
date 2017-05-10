//
//  EquipSelectModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipSelectModel : NSObject

@property (nonatomic , copy ) NSString *record_id;//记录ID

@property (nonatomic , copy ) NSString *title;//标题

@property (nonatomic , copy ) NSString *author;//作者

@property (nonatomic , copy ) NSString *skill;//技能顺序

@property (nonatomic , copy ) NSString *pre_cz;//前期出装

@property (nonatomic , copy ) NSString *pre_explain;//前期出装描述

@property (nonatomic , copy ) NSString *mid_cz;//中期出装

@property (nonatomic , copy ) NSString *mid_explain;//中期出装描述

@property (nonatomic , copy ) NSString *end_cz;//后期出装

@property (nonatomic , copy ) NSString *end_explain;//后期出装描述

@property (nonatomic , copy ) NSString *nf_cz;//逆风出装

@property (nonatomic , copy ) NSString *nf_explain;//逆风出装描述

@property (nonatomic , copy ) NSString *cost;//消耗

@property (nonatomic , copy ) NSString *game_type;//游戏类型

@property (nonatomic , copy ) NSString *user_name;//用户名称

@property (nonatomic , copy ) NSString *server;//服务器

@property (nonatomic , copy ) NSString *combat;//战斗力

@property (nonatomic , copy ) NSString *good;//赞

@property (nonatomic , copy ) NSString *bad;//不赞

@property (nonatomic , copy ) NSString *time;//日期

@property (nonatomic , copy ) NSString *en_name;//英雄英文名

@property (nonatomic , copy ) NSString *ch_name;//英雄中文名

@property (nonatomic , copy ) NSString *cost_nf;//逆风消耗

@property (nonatomic , copy ) NSString *ni_name;//ni名字(可能没用)

@property (nonatomic , copy ) NSString *tags;//定位(可能没用)

@property (nonatomic , copy ) NSString *sc;//不明 可能没用

@end
