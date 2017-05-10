//
//  RateService.m
//  YueduFM
//
//  Created by StarNet on 1/4/16.
//  Copyright © 2016 StarNet. All rights reserved.
//

#import "RateService.h"
#import "iRate.h"

@implementation RateService

- (instancetype)initWithServiceCenter:(ServiceCenter *)serviceCenter {
    self = [super initWithServiceCenter:serviceCenter];
    if (self) {
        [iRate sharedInstance].applicationBundleID = [[NSBundle mainBundle] bundleIdentifier];
        [iRate sharedInstance].promptForNewVersionIfUserRated = 1;
    }
    return self;
}

@end
