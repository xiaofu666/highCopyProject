//
//  AnalyticsService.h
//  YueduFM
//
//  Created by StarNet on 1/4/16.
//  Copyright © 2016 StarNet. All rights reserved.
//

#import "BaseService.h"

typedef NS_ENUM(NSUInteger, AnalyticsEventId) {
    AnalyticsEventIdNone = 0,
    AnalyticsEventIdDownload,
    AnalyticsEventIdFavor,
};

@interface AnalyticsService : BaseService

- (void)sendWithEventId:(AnalyticsEventId)eventId;

@end
