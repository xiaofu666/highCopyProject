//
//  SmartbiAdaFind.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaFind.h"

@implementation SmartbiAdaFind

+(SmartbiAdaFind *)initWithDictionry:(NSDictionary *)dict{
    SmartbiAdaFind *find=[[SmartbiAdaFind alloc]init];

    find.icon=dict[@"icon"];
    find.name=dict[@"name"];
    find.intro=dict[@"intro"];
    find.subscribe_count=dict[@"subscribe_count"];
    find.total_updates=dict[@"total_updates"];
    find.category_id=dict[@"id"];//category_id
    
    return find;
}
+(SmartbiAdaFind *)bannerInitWithDictionry:(NSDictionary *)dict{
    SmartbiAdaFind *find=[[SmartbiAdaFind alloc]init];
   
    find.banner_url=dict[@"banner_url"][@"url_list"][0][@"url"];
//    NSLog(@"%@",find.banner_url);
    find.banner_title=dict[@"banner_url"][@"title"];
    find.banner_height=dict[@"banner_url"][@"height"];
    
    return find;

}
- (NSString *)description
{
    return [NSString stringWithFormat:@"self.name==%@  self.intro==%@", self.name,self.intro];
}
@end
