//
//  UIImage+DPTransparent.m
//  CustomizedNavigationBarDemo
//
//  Created by DancewithPeng on 15/12/3.
//  Copyright © 2015年 dancewithpeng@gmail.com. All rights reserved.
//

#import "UIImage+DPTransparent.h"

@implementation UIImage (DPTransparent)

+ (instancetype)transparentImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)transparentImage
{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    return [self transparentImageWithSize:CGSizeMake(1.0f/screenScale, 1.0f/screenScale)];
}

@end
