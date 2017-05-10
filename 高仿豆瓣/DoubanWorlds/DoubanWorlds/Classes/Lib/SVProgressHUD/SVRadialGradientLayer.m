//
//  SVRadialGradientLayer.m
//  SVProgressHUD, https://github.com/TransitApp/SVProgressHUD
//
//  Copyright (c) 2014 Tobias Tiemerding. All rights reserved.
//

#import "SVRadialGradientLayer.h"

@implementation SVRadialGradientLayer

- (void)drawInContext:(CGContextRef)context {
    size_t locationsCount = 2;
    CGFloat locations[2] = {0.0f, 1.0f};
    CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
    CGColorSpaceRelease(colorSpace);

    float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    CGContextDrawRadialGradient (context, gradient, self.gradientCenter, 0, self.gradientCenter, radius, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com