//
//  SmartbiAdaComments.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartbiAdaComments : NSObject


//comments （Array）以下是评论的属性
@property (nonatomic,strong)NSString *commentDigg_count;//digg_count 点赞
@property (nonatomic,strong)NSString *commentText;//text 评论内容
@property (nonatomic,strong)NSString *commentUser_name;//user_name评论者名字
@property (nonatomic,strong)NSString *commentUser_profile_image_url;//评论者头像user_profile_image_url
@property (nonatomic,strong)NSString *commentAvatar_url;//avatar_url头像


//@property (nonatomic,strong)NSString *commentBury_count;//bury_count埋汰
//@property (nonatomic,strong)NSString *commentCreate_time;
//create_time到现在的秒数
//@property (nonatomic,strong)NSString *commentDescription;//description
//@property (nonatomic,strong)NSString *commentPlatform;//platform

+(SmartbiAdaComments *)initWithDictionry:(NSDictionary *)dict;
@end
