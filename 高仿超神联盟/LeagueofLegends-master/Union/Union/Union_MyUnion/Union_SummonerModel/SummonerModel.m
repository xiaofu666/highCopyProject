//
//  SummonerModel.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SummonerModel.h"

@implementation SummonerModel


-(void)dealloc{
    
    [_serverName release];
    
    [_serverFullName release];
    
    [_summonerName release];
    
    [_level release];
    
    [_icon release];
    
    [_tierDesc release];
    
    [super dealloc];
    
}

@end
