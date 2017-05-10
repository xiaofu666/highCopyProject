//
//  UIView+FillWithView.m
//  ContextMenu
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "UIView+LXConstraints.h"

@implementation UIView (LXConstraints)

- (void)addSubViewiew:(UIView *)view withSidesConstrainsInsets:(UIEdgeInsets)insets {
    
    NSParameterAssert(view);
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:view];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:insets.top]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:insets.left]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:insets.bottom]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:insets.right]];
}

@end
