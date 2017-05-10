//
//  LHShop.m
//  12-自习瀑布流UP2.0
//
//  Created by snowimba on 15/11/26.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import "LHShop.h"

@implementation LHShop

+ (instancetype)shopWithDict:(NSDictionary*)dict
{

    return [[self alloc] initWithDict:dict];

    //    return obj;
}

- (instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {

        [self setValuesForKeysWithDictionary:dict];
        self.isNew = (Boolean)[dict valueForKey:@"new"];
        
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString*)key
{
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com