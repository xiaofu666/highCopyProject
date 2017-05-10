//
//  WSChatModel.m
//  QQ
//
//  Created by weida on 15/12/21.
//  Copyright © 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatModel.h"
#import "NSObject+CoreDataHelper.h"

@implementation WSChatModel

+(NSString *)entityName
{
    return @"MsgHistory";
}

+(WSChatModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    return   [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+(NSUInteger)count
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self entityInManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];    
    
    return [self.managedObjectContext countForFetchRequest:fetchRequest error:nil];
}

@end
