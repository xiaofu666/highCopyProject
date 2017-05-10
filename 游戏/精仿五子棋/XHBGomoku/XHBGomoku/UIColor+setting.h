//
//  UIColor+setting.h
//  wq
//
//  Created by weqia on 13-7-29.
//  Copyright (c) 2013年 Weqia. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BACKGROUND_COLOR 0xF8F8F8


@interface UIColor (setting)
+ (UIColor *)colorWithIntegerValue:(NSUInteger)value alpha:(CGFloat)alpha;
@end
