//
//  FreeHero.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ListHero.h"

@implementation ListHero


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
        
        [mStr release];
        
    }
    
}


- (void)setPrice:(NSString *)price{
    
    if (_price != price) {
        
        [_price release];
        
        _price = [price retain];
        
    }
    
    //数据处理 分离金币价格和点劵价格
    
    NSArray *tempArray = [price componentsSeparatedByString:@","];
    
    _goldPrice = [tempArray[0] retain];
    
    _couponsPrice = [tempArray[1] retain];
    
}


- (void)setRating:(NSString *)rating{
    
    if (_rating != rating) {
        
        [_rating release];
        
        _rating = [rating retain];
        
    }
    
    //处理评级 为攻防法难度评级赋值
    
    NSArray *ratingArray = [rating componentsSeparatedByString:@","];
    
    _ratingA = [ratingArray[0] retain];
    
    _ratingB = [ratingArray[1] retain];
   
    _ratingC = [ratingArray[2] retain];

    _ratingD = [ratingArray[3] retain];
    
}

-(void)dealloc {
    
    [_location release];
    
    [_tags release];
    
    [_title release];
    
    [_enName release];
    
    [_cnName release];
    
    [_price release];
    
    [_rating release];
    
    [_ratingA release];
    
    [_ratingB release];
    
    [_ratingC release];
    
    [_ratingD release];
    
    [_goldPrice release];
    
    [_couponsPrice release];
    
    [_presentTimes release];
    
    [super dealloc];
    
}

@end
