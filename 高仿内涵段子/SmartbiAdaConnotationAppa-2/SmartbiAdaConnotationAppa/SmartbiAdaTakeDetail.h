//
//  SmartbiAdaTakeDetail.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/25.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SmartbiAdaTakeDetail : NSObject

//user以下是用户的相关信息
@property (nonatomic,strong)NSString *avatar_url;//发帖用户名头像
@property (nonatomic,strong)NSString *name;//发帖用户名

//内容
@property (nonatomic,strong)NSString *text;//帖子的内容
@property (nonatomic,strong)NSString *share_url;
@property (nonatomic,strong)NSString *imageUrl;  //图像
@property (nonatomic,strong)NSString *videoUrl;  //视频url
@property (nonatomic,strong)NSString *cover; //视频封面图
//group  (Object)以下是内容的属性
@property (nonatomic,strong)NSString *digg_count;//digg_count 点赞
@property (nonatomic,strong)NSString *bury_count;//埋汰
@property (nonatomic,strong)NSString *share_count;
@property (nonatomic,strong)NSString *comment_count;//评论数


//cell的高度
@property (nonatomic) CGSize contentSize;//text
@property (nonatomic) CGFloat imageHeight;//picture
@property (nonatomic) CGFloat videoHeight;//video





+(SmartbiAdaTakeDetail *)initWithDictionry:(NSDictionary *)dict;

@end
