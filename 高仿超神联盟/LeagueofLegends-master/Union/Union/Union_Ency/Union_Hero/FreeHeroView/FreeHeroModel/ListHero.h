//
//  FreeHero.h
//  Union
//
//  Created by 李响 on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeHero : NSObject


@property (nonatomic , copy ) NSString *enName;//英文名字

@property (nonatomic , copy ) NSString *cnName;//中文名字

@property (nonatomic , copy ) NSString *title;//英雄标题

@property (nonatomic , copy ) NSString *tags;//职业类型

@property (nonatomic , copy ) NSString *rating;//评级(攻.防.法.难度)

@property (nonatomic , copy ) NSString *location;//位置

@property (nonatomic , copy ) NSString *price;//价格

@end
