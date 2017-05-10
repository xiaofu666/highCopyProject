//
//  ChannelService.m
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ChannelService.h"

@implementation ChannelService

- (id)initWithServiceCenter:(ServiceCenter*)serviceCenter
{
    self = [super initWithServiceCenter:serviceCenter];
    if (self) {
        [self.dataManager registerClass:[YDSDKChannelModel class] complete:nil];
        [self checkout:nil];
    }
    return self;
}

- (void)checkout:(void(^)(BOOL successed))completion {
    [self.dataManager read:[YDSDKChannelModel class] condition:nil complete:^(BOOL successed, id result) {
        self.channels = successed?result:nil;
        if (completion) completion(successed);
    }];
}

- (void)start {
    if (![self.channels count]) {
        [self fetch:nil];        
    }
}

- (void)fetch:(void(^)(NSError* error))completion {
    [SRV(ConfigService) fetch:^(NSError *error) {
        YDSDKChannelListRequest* req = [YDSDKChannelListRequest request];
        [self.netManager request:req completion:^(YDSDKRequest *request, YDSDKError *error) {
            if (!error) {
                [self.dataManager writeObjects:req.modelArray complete:^(BOOL successed, id result) {
                    [self checkout:^(BOOL successed) {
                        if (completion) completion(nil);
                    }];
                }];
            } else {
                if (completion) completion(nil);
            }
        }];
    }];
}

@end
