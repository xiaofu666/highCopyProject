//
//  SmartbiAdaHome.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartbiAdaComments.h"
#import <UIKit/UIKit.h>

@interface SmartbiAdaHome : NSObject

@property (nonatomic,strong)NSString *category_name;//标签

//user以下是用户的相关信息
@property (nonatomic,strong)NSString *avatar_url;//发帖用户名头像
@property (nonatomic,strong)NSString *name;//发帖用户名
@property (nonatomic,strong)NSString *text;//帖子的内容
@property (nonatomic,strong)NSString *status_desc;//帖子的标签



//group  (Object)以下是内容的属性
@property (nonatomic,strong)NSString *digg_count;//digg_count 点赞
@property (nonatomic,strong)NSString *bury_count;//埋汰
@property (nonatomic,strong)NSString *comment_count;//评论数
@property (nonatomic,strong)NSString *url_list;    //large_image    url_list[0]

@property (nonatomic,strong)NSString *share_count;
@property (nonatomic,strong)NSString *share_url;
@property (nonatomic,strong)NSString *large_imageUrl_list;//大图

@property (nonatomic,strong)NSString *followers;
@property (nonatomic,strong)NSString *followings;
@property (nonatomic,strong)NSMutableArray *commentsArray;

//cell的高度
//text
@property (nonatomic,strong) NSString * contentSize;
//picture
@property (nonatomic,strong) NSString * pictureSize, * pictureWidth;
//video
@property (nonatomic,strong) NSString * videoSize;


/*
 @property (nonatomic) CGSize contentSize;
 //picture
 @property (nonatomic) CGFloat pictureSize;
 //video
 @property (nonatomic) CGSize videoSize;
 
 */
//视频的封面和内容
@property (nonatomic,strong) NSString *large_cover;
@property (nonatomic,strong) NSString *mp4_url;
@property (nonatomic,strong) NSString *video_height,*video_width;


+(SmartbiAdaHome *)initWithDictionry:(NSDictionary *)dict;

@end
