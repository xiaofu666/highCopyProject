//
//  Hero_Details_DataModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero_Details_DataModel : NSObject

@property (nonatomic , copy ) NSString *range;//攻击距离

@property (nonatomic , copy ) NSString *moveSpeed;//移动速度

@property (nonatomic , copy ) NSString *armorBase;//基础护甲

@property (nonatomic , copy ) NSString *armorLevel;//每级护甲

@property (nonatomic , copy ) NSString *manaBase;//基础魔法值

@property (nonatomic , copy ) NSString *manaLevel;//每级魔法值

@property (nonatomic , copy ) NSString *criticalChanceBase;//基础暴击概率

@property (nonatomic , copy ) NSString *criticalChanceLevel;//每级暴击概率

@property (nonatomic , copy ) NSString *manaRegenBase;//基础魔法回复

@property (nonatomic , copy ) NSString *manaRegenLevel;//每级魔法回复

@property (nonatomic , copy ) NSString *healthRegenBase;//基础生命回复

@property (nonatomic , copy ) NSString *healthRegenLevel;//每级生命回复

@property (nonatomic , copy ) NSString *magicResistBase;//基础魔法抗性

@property (nonatomic , copy ) NSString *magicResistLevel;//每级魔法抗性

@property (nonatomic , copy ) NSString *healthBase;//基础生命值

@property (nonatomic , copy ) NSString *healthLevel;//每级生命值

@property (nonatomic , copy ) NSString *attackBase;//基础攻击

@property (nonatomic , copy ) NSString *attackLevel;//每级攻击


@end
