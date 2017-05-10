//
//  EncyModel.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EncyModel.h"

@implementation EncyModel

-(void)dealloc{
    
    [_name release];
    
    [_iconName release];
    
    [super dealloc];
    
}

-(id)initWithName:(NSString *)name IconName:(NSString *)iconName{
    
    self = [super init];
    
    if (self) {
        
        _name = name;
        
        _iconName = iconName;
        
    }
    
    return self;
    
}

@end
