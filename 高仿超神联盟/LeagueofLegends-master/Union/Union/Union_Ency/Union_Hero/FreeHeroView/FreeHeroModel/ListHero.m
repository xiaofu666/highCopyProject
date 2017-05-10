//
//  FreeHero.m
//  Union
//
//  Created by 李响 on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FreeHero.h"

@implementation FreeHero

- (void)setLocation:(NSString *)location{
    
    if (_location != location) {
        
        [_location release];
        
        _location = [location retain];
        
    }
    
    //判断是否存在多个位置
    
    NSRange range = [location rangeOfString:@","];
    
    if (range.length > 0) {
        
        //处理数据格式
        
        NSMutableString *mStr = [[NSMutableString alloc]init];
        
        NSArray *tempArray = [location componentsSeparatedByString:@","];
        
        for (int i = 0 ; i < tempArray.count ; i++) {
            
            //循环拼接字符串
            
            [mStr appendFormat:@"/%@" , tempArray[i] ];
            
        }
        
        _location = [[mStr substringFromIndex:1] retain];//截取掉第一个/
        
    }
    
}


-(void)dealloc {
    
    [_location release];
    
    [_tags release];
    
    [_title release];
    
    [_enName release];
    
    [_cnName release];
    
    [_price release];
    
    [_rating release];
    
    [super dealloc];
    
}

@end
