//
//  UIColor+ToImg.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "UIColor+ToImg.h"

@implementation UIColor (ToImg)

- (UIImage*)toImg
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
