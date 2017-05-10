//
//  BLRColorComponents.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//  毛玻璃效果封装

#import <Foundation/Foundation.h>

@interface BLRColorComponents : NSObject

@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, assign) CGFloat saturationDeltaFactor;
@property(nonatomic, strong) UIImage *maskImage;

/**
 *  Light color effect.
 */
+ (BLRColorComponents *) lightEffect;

/**
 *  Dark color effect.
 */
+ (BLRColorComponents *) darkEffect;

/**
 *  Coral color effect.
 */
+ (BLRColorComponents *) coralEffect;

/**
 *  Neon color effect.
 */
+ (BLRColorComponents *) neonEffect;

/**
 *  Sky color effect.
 */
+ (BLRColorComponents *) skyEffect;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com