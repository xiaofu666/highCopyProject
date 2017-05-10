//
//  DataService.h
//  YueduFM
//
//  Created by StarNet on 9/17/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseService.h"
#import "PPSqliteORM.h"

@interface BaseService (DataService)

- (PPSqliteORMManager* )dataManager;

@end

@interface DataService : BaseService

@property (nonatomic, readonly) PPSqliteORMManager* manager;

- (void)writeData:(id)data completion:(void(^)())completion;

- (void)writeDataFromArray:(NSArray* )array completion:(void(^)())completion;

@end
