//
//  Hero_Details_SkillModel.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_SkillModel.h"

@implementation Hero_Details_SkillModel

-(void)dealloc{
    
    [_sid release];
    
    [_key release];
    
    [_name release];
    
    [_cooldown release];
    
    [_cost release];
    
    [_skillDescription release];
    
    [_range release];
    
    [_effect release];
    
    [super dealloc];
    
}

-(void)setEffect:(NSString *)effect{
    
    if (_effect != effect) {
        
        [_effect release];
        
        //判断是否以\N开头 如果是 截取掉
        
        if ([effect hasPrefix:@"\n"]) {
            
            _effect = [[effect substringFromIndex:1] retain];
            
        } else {
            
            _effect = [effect retain];
            
        }
        
        
        
    }
    
}

@end
