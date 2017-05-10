//
//  WSBuddyModel.h
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WSBuddyGroupModel;

NS_ASSUME_NONNULL_BEGIN

@interface WSBuddyModel : NSManagedObject

+(NSString*)entityName;

+(WSBuddyModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *) context;

+(NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)context;

@end

NS_ASSUME_NONNULL_END

#import "WSBuddyModel+CoreDataProperties.h"
