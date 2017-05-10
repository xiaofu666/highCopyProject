//
//  LHSortAV.m
//  biUp
//
//  Created by snowimba on 16/1/11.
//  Copyright © 2016年 snowimba. All rights reserved.
//

#import "LHSortAV.h"

@implementation LHSortAV
+ (instancetype)sortAVWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com