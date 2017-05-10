//
//  SmartbiAdaHome.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaHome.h"

@implementation SmartbiAdaHome
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commentsArray=[[NSMutableArray alloc]init];
//        SmartbiAdaComments *com=[[SmartbiAdaComments alloc]initWithDictionry:nil];
    }
    return self;
}
+(SmartbiAdaHome *)initWithDictionry:(NSDictionary *)dict{
   
    SmartbiAdaHome *homeModel=[[SmartbiAdaHome alloc]init];
        for (NSDictionary *dataCom in dict[@"comments"]) {
             SmartbiAdaComments *com=[SmartbiAdaComments initWithDictionry:dataCom];
            [homeModel.commentsArray addObject:com];
        }
    
        homeModel.digg_count=dict[@"group"][@"digg_count"];
        homeModel.bury_count=dict[@"group"][@"bury_count"];
        homeModel.text=dict[@"group"][@"text"];
        homeModel.comment_count=dict[@"group"][@"comment_count"];
    
    homeModel.share_count=dict[@"group"][@"share_count"];
    homeModel.share_url=dict[@"group"][@"share_url"];
    homeModel.category_name=dict[@"group"][@"category_name"];
    
    
    //用户赋值
    homeModel.avatar_url=dict[@"group"][@"user"][@"avatar_url"];
    homeModel.name=dict[@"group"][@"user"][@"name"];
    homeModel.followers=dict[@"group"][@"user"][@"followers"];
    homeModel.followings=dict[@"group"][@"user"][@"followings"];
    
    homeModel.contentSize = [NSString stringWithFormat:@"%f",[homeModel.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size.height];
    



    if ([dict[@"group"][@"large_image"][@"url_list"][0][@"url"] length]>0)
    {
        
        homeModel.url_list=dict[@"group"][@"large_image"][@"url_list"][0][@"url"];
        if([dict[@"group"][@"large_image"][@"r_height"] floatValue]>0)
        {
        homeModel.pictureSize=[NSString stringWithFormat:@"%f",[dict[@"group"][@"large_image"][@"r_height"] floatValue]];
        }
        else
        {
         homeModel.pictureSize=[NSString stringWithFormat:@"%f",[dict[@"group"][@"large_image"][@"height"] floatValue]];
        }
        if ([dict[@"group"][@"large_image"][@"r_width"] floatValue] >0) {
               homeModel.pictureWidth=[NSString stringWithFormat:@"%f",[dict[@"group"][@"large_image"][@"r_width"] floatValue]];
        }
        else
        {
           homeModel.pictureWidth=[NSString stringWithFormat:@"%f",[dict[@"group"][@"large_image"][@"width"] floatValue]];
        }
     
    }
   else if ([dict[@"group"][@"large_image_list"][0][@"url"] length] >0)
   {
        homeModel.url_list=dict[@"group"][@"large_image_list"][0][@"url"];
        homeModel.pictureSize=[NSString stringWithFormat:@"%f",[dict[@"group"][@"large_image_list"][0][@"height"] floatValue]];
        homeModel.pictureWidth=[NSString stringWithFormat:@"%f",[dict[@"group"][@"large_image_list"][0][@"width"] floatValue]];
   }
    else  if ([dict[@"group"][@"thumb_image_list"][0][@"url"] length]>0)
    {
        homeModel.url_list=dict[@"group"][@"thumb_image_list"][0][@"url"];
        homeModel.pictureSize= [NSString stringWithFormat:@"%f",[dict[@"group"][@"thumb_image_list"][0][@"height"] floatValue]];
         homeModel.pictureWidth= [NSString stringWithFormat:@"%f",[dict[@"group"][@"thumb_image_list"][0][@"width"] floatValue]];
        
          NSLog(@"thumb_image_list.height==%@",[NSString stringWithFormat:@"%f",[dict[@"group"][@"thumb_image_list"][0][@"r_height"] floatValue]]);
         NSLog(@"thumb_image_list.width==%@",[NSString stringWithFormat:@"%f",[dict[@"group"][@"thumb_image_list"][0][@"width"] floatValue]]);
    }
    else
    {
        homeModel.url_list=homeModel.avatar_url;
        homeModel.pictureSize=[NSString stringWithFormat:@"%d",280];
        homeModel.pictureWidth=[NSString stringWithFormat:@"%d",280];
    }
    if ([homeModel.pictureSize floatValue] <1) {
        NSLog(@"上=homeModel.pictureSize==%f %@",[homeModel.pictureSize floatValue],homeModel.url_list);
    }
    
    
    
    //视频的封面和内容
    if ([dict[@"group"][@"large_cover"][@"url_list"][0][@"url"] length]>0) {
        
        
        homeModel.large_cover=dict[@"group"][@"large_cover"][@"url_list"][0][@"url"];
        homeModel.mp4_url= dict[@"group"][@"mp4_url"];
        homeModel.video_height=dict[@"group"][@"video_height"];
        homeModel.video_width=dict[@"group"][@"video_width"];
    }
    if ([homeModel.pictureSize floatValue] <1) {
         NSLog(@"下=homeModel.pictureSize==%f",[homeModel.pictureSize floatValue]);
    }
   
    
    return homeModel;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"self.pictureSize==%f..self.name%@..",[self.pictureSize floatValue],self.name];
}
@end
