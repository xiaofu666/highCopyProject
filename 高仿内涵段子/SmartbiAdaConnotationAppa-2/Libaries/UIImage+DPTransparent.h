//
//  UIImage+DPTransparent.h
//  CustomizedNavigationBarDemo
//
//  Created by DancewithPeng on 15/12/3.
//  Copyright © 2015年 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  创建透明图片的Image Category
 */
@interface UIImage (DPTransparent)

/**
 *  创建只有一个像素点的透明图片
 *
 *  @return 透明图片的Image对象
 */
+ (instancetype)transparentImage;


/**
 *  创建指定大小的透明图片
 *
 *  @param size 透明图片的尺寸
 *
 *  @return 透明图片的Image对象
 */
+ (instancetype)transparentImageWithSize:(CGSize)size;

@end
