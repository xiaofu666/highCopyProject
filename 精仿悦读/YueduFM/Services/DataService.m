//
//  DataService.m
//  YueduFM
//
//  Created by StarNet on 9/17/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "DataService.h"

@implementation BaseService (DataService)

- (PPSqliteORMManager* )dataManager {
    return [SRV(DataService) manager];
}

@end

@implementation DataService

+ (ServiceLevel)level {
    return ServiceLevelHighest;
}

- (id)initWithServiceCenter:(ServiceCenter*)serviceCenter
{
    self = [super initWithServiceCenter:serviceCenter];
    if (self) {
        _manager = [[PPSqliteORMManager alloc] initWithDBFilename:@"db.sqlite"];
    }
    return self;
}

- (void)writeData:(id)data completion:(void(^)())completion {
    [_manager writeObject:data complete:^(BOOL successed, id result) {
        if (completion) {
            completion();
        }
    }];
}

- (void)writeDataFromArray:(NSArray* )array completion:(void(^)())completion {
    [_manager writeObjects:array complete:^(BOOL successed, id result) {
        if (completion) {
            completion();
        }
    }];
}


@end
