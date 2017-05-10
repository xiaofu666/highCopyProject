//
//  ChannelService.h
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseService.h"

@interface ChannelService : BaseService

@property (nonatomic, strong) NSArray* channels;

- (void)fetch:(void(^)(NSError* error))completion;

@end
