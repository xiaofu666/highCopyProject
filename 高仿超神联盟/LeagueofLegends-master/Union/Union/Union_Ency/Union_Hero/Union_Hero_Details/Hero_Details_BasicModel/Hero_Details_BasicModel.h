//
//  Hero_Details_BasicModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero_Details_BasicModel : NSObject

@property (nonatomic ,copy ) NSString *hid;//英雄ID

@property (nonatomic , copy ) NSString *tags;//英雄定位(战士)

@property (nonatomic , copy ) NSString *name;//英雄英文名

@property (nonatomic , copy ) NSString *title;//英雄中文名

@property (nonatomic , copy ) NSString *displayName;//英雄标题

@property (nonatomic , copy ) NSString *price;//英雄价格

@property (nonatomic , copy ) NSString *ratingAttack;//评级(攻)

@property (nonatomic , copy ) NSString *ratingDefense;//评级(防)

@property (nonatomic , copy ) NSString *ratingMagic;//评级(法)

@property (nonatomic , copy ) NSString *ratingDifficulty;//评级(难)

@property (nonatomic , copy ) NSString *heroDescription;//英雄背景故事

@property (nonatomic , copy ) NSString *tips;//使用技巧

@property (nonatomic , copy ) NSString *opponentTips;//应对技巧

@end
