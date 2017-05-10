//
//  UIImage+ZLPhotoLib.h
//  MLCamera
//
//  Created by 张磊 on 15/4/25.
//  Copyright (c) 2015年 www.weibo.com/makezl All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZLPhotoLib)
+ (instancetype)ml_imageFromBundleNamed:(NSString *)name;
- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)imageScaleAspectFillFromTop:(CGSize)frameSize;
-(UIImage*)subImageInRect:(CGRect)rect;
- (UIImage *)imageFillSize:(CGSize)viewsize;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com