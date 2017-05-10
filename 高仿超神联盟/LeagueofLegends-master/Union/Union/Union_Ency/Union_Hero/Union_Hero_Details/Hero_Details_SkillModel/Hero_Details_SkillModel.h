//
//  Hero_Details_SkillModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero_Details_SkillModel : NSObject

@property (nonatomic , copy ) NSString *sid;//技能ID

@property (nonatomic , copy ) NSString *key;//技能Key

@property (nonatomic , copy ) NSString *name;//技能名称

@property (nonatomic , copy ) NSString *cost;//技能消耗

@property (nonatomic , copy ) NSString *cooldown;//技能冷却时间

@property (nonatomic , copy ) NSString *skillDescription;//技能描述

@property (nonatomic , copy ) NSString *range;//技能范围

@property (nonatomic , copy ) NSString *effect;//技能效果


@end
