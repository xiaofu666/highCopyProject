//
//  AppDelegate.h
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//手写代码创建UI适配方法
-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height;

@end

