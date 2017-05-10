//
//  NSArray+SQL.m
//  weiju-ios
//
//  Created by Diana on 8/25/15.
//  Copyright (c) 2015 evideo. All rights reserved.
//

#import "NSArray+SQL.h"
#import "NSObject+PPSqliteORM.h"
#import "JSONKit.h"

@implementation NSArray (SQL)
- (NSString* )sqlValue {
    return [[self JSONString] sqlValue];
}

+ (id)objectForSQL:(NSString* )sql {
    if (!sql) return nil;
    return [sql objectFromJSONString];
}
@end
