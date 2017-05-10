//
//  UIView+XHQView.m
//  AutoHome
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "UIView+XHQView.h"

@implementation UIView (XHQView)
- (void)setX:(CGFloat)x
{
    // 1. 先获取原来的frame
    CGRect frame = self.frame;
    
    // 2. 修改frame
    frame.origin.x = x;
    
    // 3. 将修改后的frame重新赋值给self
    self.frame = frame;
}

// 返回x
- (CGFloat)x {
    return self.frame.origin.x;
}


- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}


- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)midX {
    return self.width / 2.f;
}

- (CGFloat)midY {
    return self.height / 2.f;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com