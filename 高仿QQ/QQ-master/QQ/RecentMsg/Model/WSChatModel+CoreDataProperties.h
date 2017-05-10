//
//  WSChatModel+CoreDataProperties.h
//  QQ
//
//  Created by weida on 15/12/21.
//  Copyright © 2015年 weida. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//  https://github.com/weida-studio/QQ

#import "WSChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WSChatModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *timeStamp;
@property (nullable, nonatomic, retain) NSNumber *isSender;
@property (nullable, nonatomic, retain) NSNumber *chatCellType;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSString *headImageURL_sender;
@property (nullable, nonatomic, retain) NSNumber *secondVoice;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) id sendingImage;
@end

NS_ASSUME_NONNULL_END
