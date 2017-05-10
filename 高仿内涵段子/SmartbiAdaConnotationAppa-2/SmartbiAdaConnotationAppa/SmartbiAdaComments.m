//
//  SmartbiAdaComments.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaComments.h"

@implementation SmartbiAdaComments
+(SmartbiAdaComments *)initWithDictionry:(NSDictionary *)dict{
    SmartbiAdaComments *comment=[[SmartbiAdaComments alloc]init];
    comment.commentDigg_count=dict[@"digg_count"];
    comment.commentText=dict[@"text"];
    comment.commentUser_name=dict[@"user_name"];
    comment.commentUser_profile_image_url=dict[@"user_profile_image_url"];
    comment.commentAvatar_url=dict[@"avatar_url"];
    
    return comment;
}
@end
