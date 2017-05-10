//
//  SmartbiAdaTakeDetail.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/25.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaTakeDetail.h"

@implementation SmartbiAdaTakeDetail
+(SmartbiAdaTakeDetail *)initWithDictionry:(NSDictionary *)dict{
    SmartbiAdaTakeDetail *takeDetail=[[SmartbiAdaTakeDetail alloc]init];
    
    //用户赋值
    takeDetail.avatar_url=dict[@"group"][@"user"][@"avatar_url"];
    takeDetail.name=dict[@"group"][@"user"][@"name"];
    
    takeDetail.text=dict[@"group"][@"text"];
    takeDetail.share_url=dict[@"group"][@"share_url"];
    
    if ([dict[@"group"][@"url_list"][0][@"url"] length]>0) {
        takeDetail.imageUrl=dict[@"group"][@"url_list"][0][@"url"];
        //            NSLog(@"==%@",dict[@"group"][@"url_list"][0][@"url"]);
    }
    if ([dict[@"group"][@"large_image_list"][0][@"url"] length] >0) {
        takeDetail.imageUrl=dict[@"group"][@"large_image_list"][0][@"url"];
        takeDetail.imageHeight=[dict[@"group"][@"large_image_list"][0][@"height"] floatValue];
    }
    if ([dict[@"group"][@"large_image"][@"url_list"][0][@"url"] length]>0) {
        takeDetail.imageUrl=dict[@"group"][@"large_image"][@"url_list"][0][@"url"];
        takeDetail.imageHeight=[dict[@"group"][@"large_image"][@"height"] floatValue];
    }
    if ([dict[@"group"][@"thumb_image_list"][0][@"url"] length]>0) {
        takeDetail.imageUrl=dict[@"group"][@"thumb_image_list"][0][@"url"];
        takeDetail.imageHeight= [dict[@"group"][@"thumb_image_list"][0][@"height"] floatValue];
    }
    
    takeDetail.videoUrl=dict[@"group"][@"origin_video"][@"url_list"][0][@"url"];
    takeDetail.videoHeight=[dict[@"group"][@"origin_video"][@"height"] floatValue];
    //    NSLog(@"videoHeight==%f",takeDetail.videoHeight);
    //视频的封面和内容
    if ([dict[@"group"][@"large_cover"][@"url_list"][0][@"url"] length]>0) {
        takeDetail.cover=dict[@"group"][@"large_cover"][@"url_list"][0][@"url"];
    }
    
    takeDetail.digg_count=dict[@"group"][@"digg_count"];
    takeDetail.bury_count=dict[@"group"][@"bury_count"];
    takeDetail.comment_count=dict[@"group"][@"comment_count"];
    takeDetail.share_count=dict[@"group"][@"share_count"];
    
    //一下是cell
    takeDetail.contentSize = [takeDetail.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;
    
    
    
    return takeDetail;
    
}
@end
