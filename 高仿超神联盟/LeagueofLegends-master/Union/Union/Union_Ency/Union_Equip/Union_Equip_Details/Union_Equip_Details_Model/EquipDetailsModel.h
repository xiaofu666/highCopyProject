//
//  EquipDetailsModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/5.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface EquipDetailsModel : NSObject

@property (nonatomic , assign ) NSInteger eid;

@property (nonatomic , copy ) NSString *name;//装备名称

@property (nonatomic , copy ) NSString *equipDescription;//装备描述

@property (nonatomic , copy ) NSString *need;//合成需求

@property (nonatomic , copy ) NSString *compose;//可合成

@property (nonatomic , assign ) NSInteger price;//合成价格

@property (nonatomic , assign ) NSInteger allPrice;//总价格

@property (nonatomic , assign ) NSInteger sellPrice;//出售价

@property (nonatomic , retain ) NSArray *extAttrs;//扩展属性

@property (nonatomic , retain ) NSArray *needArray;//合成需求数组

@property (nonatomic , retain ) NSArray *composeArray;//可合成数组

//"extAttrs": {
//    "FlatHPPoolMod": 400,
//    "FlatMagicDamageMod": 100
//}

@end
