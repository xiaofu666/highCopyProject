//
//  SumAbilityModel.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/15.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SumAbilityModel.h"

@implementation SumAbilityModel

-(void)dealloc{
    
    [_name release];
    
    [_sid release];
    
    [_level release];
    
    [_cooldown release];
    
    [_des release];
    
    [_tips release];
    
    [_strong release];
    
    [super dealloc];
    
}

@end
