//
//  SumAbilityModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/15.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SumAbilityModel : NSObject

@property (nonatomic , copy ) NSString *name;//召唤师技能名称

@property (nonatomic , copy ) NSString *sid;//召唤师技能ID

@property (nonatomic , copy ) NSString *level;//技能等级

@property (nonatomic , copy ) NSString *cooldown;//冷却时间

@property (nonatomic , copy ) NSString *des;//描述

@property (nonatomic , copy ) NSString *tips;//提示

@property (nonatomic , copy ) NSString *strong;//强化


@end
