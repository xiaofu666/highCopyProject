//
//  OnlineModel.m
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "OnlineModel.h"

@implementation OnlineModel

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self=[super init]) {
        
        self.nickname=dictionary[@"nickname"];
        self.online=dictionary[@"online"];
        self.room_src=dictionary[@"room_src"];
        self.game_url=dictionary[@"game_url"];
        
        self.room_id=dictionary[@"room_id"];
        self.cate_id=dictionary[@"cate_id"];
        self.room_name=dictionary[@"room_name"];
        self.show_status=dictionary[@"show_status"];
        
        self.show_time=dictionary[@"show_time"];
        self.owner_uid=dictionary[@"owner_uid"];
        self.url=dictionary[@"url"];
        self.game_name=dictionary[@"game_name"];
        
        self.fans=dictionary[@"fans"];
        self.online=dictionary[@"online"];
        
    }
    
    return self;
}


@end
