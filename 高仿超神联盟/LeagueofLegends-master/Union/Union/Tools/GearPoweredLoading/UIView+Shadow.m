//
//  UIView+Shadow.m
//  
//
//  Created by HarrisHan on 15/7/14.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // 创建更好的性能的阴影路径
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRect(path, NULL, self.bounds);
    
    self.layer.shadowPath = path;
    
    CGPathCloseSubpath(path);
    
    CGPathRelease(path);
    
    
    self.layer.shadowColor = color.CGColor;
    
    self.layer.shadowOffset = offset;
    
    self.layer.shadowRadius = radius;
    
    self.layer.shadowOpacity = opacity;
    
    
    // 默认 clipsToBounds 为 YES, 会把阴影部分剪掉, 所以设置NO.
    
    self.clipsToBounds = NO;
    
}

@end
