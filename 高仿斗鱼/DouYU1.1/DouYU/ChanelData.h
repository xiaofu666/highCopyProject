//
//  ChanelData.h
//  DouYU
//
//  Created by Alesary on 15/11/6.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChanelData : NSObject

@property(nonatomic,strong)NSString *room_id;  //房间号

@property(nonatomic,strong)NSString *room_src;  //图片

@property(nonatomic,strong)NSString *cate_id;

@property(nonatomic,strong)NSString *room_name; //内容

@property(nonatomic,strong)NSString *show_status;

@property(nonatomic,strong)NSString *show_time;

@property(nonatomic,strong)NSString *owner_uid;

@property(nonatomic,strong)NSString *nickname;  //直播昵称

@property(nonatomic,strong)NSString *online;  //在线人数

@property(nonatomic,strong)NSString *url;

@property(nonatomic,strong)NSString *game_url;

@property(nonatomic,strong)NSString *game_name;

@property(nonatomic,strong)NSString *fans;

@property(nonatomic,assign)int sec_tag; //所在section


@end
