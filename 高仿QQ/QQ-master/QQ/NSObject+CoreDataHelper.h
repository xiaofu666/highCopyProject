//
//  NSObject+CoreDataHelper.h
//  QQ
//
//  Created by weida on 15/12/31.
//  Copyright © 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NSObject (CoreDataHelper)


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@end
