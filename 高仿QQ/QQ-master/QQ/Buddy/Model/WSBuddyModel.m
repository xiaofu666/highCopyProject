//
//  WSBuddyModel.m
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSBuddyModel.h"

@implementation WSBuddyModel

+(NSString *)entityName
{
    return @"Buddy";//相当于数据库表名
}

+(WSBuddyModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    return   [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}


@end
