//
//  LHParam.m
//  biUp
//
//  Created by snowimba on 15/12/24.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import "LHParam.h"

@implementation LHParam
+ (instancetype)paramWithDict:(NSDictionary*)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        self.param = [dict valueForKey:@"av_id"];
        
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