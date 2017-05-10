//
//  ReachabilityService.h
//  YueduFM
//
//  Created by StarNet on 9/27/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseService.h"
#import "Reachability.h"

@interface ReachabilityService : BaseService

@property (nonatomic, assign) NetworkStatus status;

- (NSString* )statusString;

@end
