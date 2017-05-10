//
//  WSBuddyGroupModel.m
//  QQ
//
//  Created by weida on 16/1/26.
//  Copyright © 2016年 weida. All rights reserved.
//

#import "WSBuddyGroupModel.h"
#import "WSBuddyModel.h"
#import "NSObject+CoreDataHelper.h"

@implementation WSBuddyGroupModel

+(NSString *)entityName
{
    return @"BuddyGroup";//相当于数据库表名
}

+(WSBuddyGroupModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    return   [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+(WSBuddyGroupModel *)selectObjectInManagedObjectContext:(NSManagedObjectContext *)context withGroupName:(NSString *)groupName
{
    if (![groupName isKindOfClass:[NSString class]] || !groupName.length)
    {
        return nil;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"groupName = %@",groupName];
    NSEntityDescription *entity = [self entityInManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *ret = [context executeFetchRequest:fetchRequest error:nil];
    
    if (ret.count)
    {
        return ret[0];
    }
    
    return nil;
}

@end
