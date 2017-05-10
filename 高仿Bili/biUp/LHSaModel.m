//
//  LHSaModel.m
//  biUp
//
//  Created by snowimba on 15/12/7.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import "LHSaModel.h"

@implementation LHSaModel
+ (instancetype)saCellWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com