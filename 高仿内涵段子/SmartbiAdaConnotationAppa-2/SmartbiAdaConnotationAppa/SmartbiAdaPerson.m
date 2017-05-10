//
//  SmartbiAdaPerson.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/28.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//
/*
 access_token=*************&
 oauth_consumer_key=12345&
 openid=****************
 
 */
#import "SmartbiAdaPerson.h"

@implementation SmartbiAdaPerson
+(SmartbiAdaPerson *)initWithDictionry:(NSDictionary *)dict WithOnLine:(NSDictionary *)dictOnLine
{
    SmartbiAdaPerson *person=[[SmartbiAdaPerson alloc]init];
    
    person.nickname=dict[@"nickname"];
    person.figureurl_qq_1=dict[@"figureurl_qq_1"];
    person.gender=dict[@"gender"];
    person.access_token=dictOnLine[@"access_token"];
    person.oauth_consumer_key=dictOnLine[@"oauth_consumer_key"];
    person.openid=dictOnLine[@"openid"];
    
    return person;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"nickname=%@figureurl_qq_1=%@gender=%@access_token=%@oauth_consumer_key=%@openid=%@",self.nickname, self.figureurl_qq_1, self.gender, self.access_token, self.oauth_consumer_key, self.openid];
}
@end
