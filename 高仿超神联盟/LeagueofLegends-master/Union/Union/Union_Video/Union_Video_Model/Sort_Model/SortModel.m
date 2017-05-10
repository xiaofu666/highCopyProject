//
//  SortModel.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SortModel.h"

@implementation SortModel

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

-(void)dealloc{

    [_dailyUpdate release];
    
    [_icon release];
    
    [_name release];
    
    [_tag release];
    
    [super dealloc];

}

@end
