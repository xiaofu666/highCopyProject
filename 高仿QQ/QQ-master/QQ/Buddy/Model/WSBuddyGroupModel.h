//
//  WSBuddyGroupModel.h
//  QQ
//
//  Created by weida on 16/1/26.
//  Copyright © 2016年 weida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "WSBuddyModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface WSBuddyGroupModel : NSManagedObject

+(NSString*)entityName;

+(WSBuddyGroupModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *) context;

+(NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)context;


+(WSBuddyGroupModel *)selectObjectInManagedObjectContext:(NSManagedObjectContext *) context withGroupName:(NSString*)groupName;

@end

NS_ASSUME_NONNULL_END

#import "WSBuddyGroupModel+CoreDataProperties.h"
