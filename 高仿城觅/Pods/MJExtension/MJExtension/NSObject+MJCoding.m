//
//  NSObject+MJCoding.m
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "NSObject+MJCoding.h"
#import "NSObject+MJProperty.h"
#import "MJProperty.h"

@implementation NSObject (MJCoding)

- (void)encode:(NSCoder *)encoder
{
    Class aClass = [self class];
    
    NSArray *allowedCodingPropertyNames = [aClass totalAllowedCodingPropertyNames];
    NSArray *ignoredCodingPropertyNames = [aClass totalIgnoredCodingPropertyNames];
    
    [aClass enumerateProperties:^(MJProperty *property, BOOL *stop) {
        if (allowedCodingPropertyNames.count && ![allowedCodingPropertyNames containsObject:property.name]) return;
        // 检测是否被忽略
        if ([ignoredCodingPropertyNames containsObject:property.name]) return;
        
        id value = [property valueForObject:self];
        if (value == nil) return;
        [encoder encodeObject:value forKey:property.name];
    }];
}

- (void)decode:(NSCoder *)decoder
{
    Class aClass = [self class];
    
    NSArray *allowedCodingPropertyNames = [aClass totalAllowedCodingPropertyNames];
    NSArray *ignoredCodingPropertyNames = [aClass totalIgnoredCodingPropertyNames];
    
    [aClass enumerateProperties:^(MJProperty *property, BOOL *stop) {
        if (allowedCodingPropertyNames.count && ![allowedCodingPropertyNames containsObject:property.name]) return;
        // 检测是否被忽略
        if ([ignoredCodingPropertyNames containsObject:property.name]) return;
        
        id value = [decoder decodeObjectForKey:property.name];
        if (value == nil) return;
        [property setValue:value forObject:self];
    }];
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com