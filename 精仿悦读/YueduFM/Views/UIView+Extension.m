//
//  UIView+Extension.m
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.size.height+self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.size.height = bottom-self.frame.origin.y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.size.width+self.frame.origin.x;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.size.width = right-self.frame.origin.x;
    self.frame = frame;
}

+ (instancetype)viewWithNibName:(NSString* )nibName {
    if (!nibName) return nil;
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [array firstObject];
}

@end
