//
//  FreeHero.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListHero : NSObject


@property (nonatomic , copy ) NSString *enName;//英文名字

@property (nonatomic , copy ) NSString *cnName;//中文名字

@property (nonatomic , copy ) NSString *title;//英雄标题

@property (nonatomic , copy ) NSString *tags;//职业类型

@property (nonatomic , copy ) NSString *rating;//评级(攻.防.法.难度)

@property (nonatomic , copy ) NSString *ratingA;//评级(攻)

@property (nonatomic , copy ) NSString *ratingB;//评级(防)

@property (nonatomic , copy ) NSString *ratingC;//评级(法)

@property (nonatomic , copy ) NSString *ratingD;//评级(难度)

@property (nonatomic , copy ) NSString *location;//位置

@property (nonatomic , copy ) NSString *price;//价格

@property (nonatomic , copy ) NSString *goldPrice;//金币价格

@property (nonatomic , copy ) NSString *couponsPrice;//点劵价格

@property (nonatomic , copy ) NSString *presentTimes;//最近使用场次

@end
