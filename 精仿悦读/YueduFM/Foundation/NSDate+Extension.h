//
//  NSDate+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/22/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSString* )format:(NSString* )format;

- (BOOL)isSameDay:(NSDate* )date;

@end
