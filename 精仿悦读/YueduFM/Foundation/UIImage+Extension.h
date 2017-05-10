//
//  UIImage+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage*)imageWithColor:(UIColor* )color;

+ (UIImage* )imageForView:(UIView* )view;

- (UIImage *)blurImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

@end
