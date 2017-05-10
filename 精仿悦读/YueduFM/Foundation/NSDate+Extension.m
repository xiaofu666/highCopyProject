//
//  NSDate+Extension.m
//  YueduFM
//
//  Created by StarNet on 9/22/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
- (NSString* )format:(NSString* )format {
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    return [fmt stringFromDate:self];
}

- (BOOL)isSameDay:(NSDate* )date {
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    return ((int)(([self timeIntervalSince1970] + timezoneFix)/(24*3600)) -
            (int)(([date timeIntervalSince1970] + timezoneFix)/(24*3600))
            == 0);
}

@end
