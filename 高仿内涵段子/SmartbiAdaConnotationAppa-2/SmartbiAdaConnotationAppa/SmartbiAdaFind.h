//
//  SmartbiAdaFind.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartbiAdaFind : NSObject

@property (nonatomic,strong)NSString *banner_url;
@property (nonatomic,strong)NSString *banner_title; //循环滚动图height
@property (nonatomic,strong)NSString *banner_height;

@property (nonatomic,strong)NSString *icon;     //头像
@property (nonatomic,strong)NSString *name;    //
@property (nonatomic,strong)NSString *intro;      //介绍
@property (nonatomic,strong)NSString *subscribe_count;   //订阅数
@property (nonatomic,strong)NSString *total_updates;     //总帖数
@property (nonatomic,strong)NSString *category_id;//分类id

+(SmartbiAdaFind *)initWithDictionry:(NSDictionary *)dict;
+(SmartbiAdaFind *)bannerInitWithDictionry:(NSDictionary *)dict;
@end
