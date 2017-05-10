//
//  StreamerService.h
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseService.h"

@interface StreamerService : BaseService

@property (nonatomic, strong) YDSDKArticleModelEx* playingModel;

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, assign, readonly) NSTimeInterval duration;

@property (nonatomic, assign) NSTimeInterval currentTime;

- (void)play:(YDSDKArticleModelEx* )model;
- (void)pause;
- (void)resume;
- (void)next;

- (void)remoteControlReceivedWithEvent:(UIEvent *)event;

@end
