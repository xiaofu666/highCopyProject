//
//  WSBuddyGroupModel+CoreDataProperties.h
//  QQ
//
//  Created by weida on 16/1/26.
//  Copyright © 2016年 weida. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WSBuddyGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WSBuddyGroupModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *groupName;
@property (nullable, nonatomic, retain) NSNumber *hide;
@property (nullable, nonatomic, retain) NSNumber *onLineCount;
@property (nullable, nonatomic, retain) NSNumber *totalCount;
@property (nullable, nonatomic, retain) NSSet<WSBuddyModel *> *buddys;

@end

@interface WSBuddyGroupModel (CoreDataGeneratedAccessors)

- (void)addBuddysObject:(WSBuddyModel *)value;
- (void)removeBuddysObject:(WSBuddyModel *)value;
- (void)addBuddys:(NSSet<WSBuddyModel *> *)values;
- (void)removeBuddys:(NSSet<WSBuddyModel *> *)values;

@end

NS_ASSUME_NONNULL_END
