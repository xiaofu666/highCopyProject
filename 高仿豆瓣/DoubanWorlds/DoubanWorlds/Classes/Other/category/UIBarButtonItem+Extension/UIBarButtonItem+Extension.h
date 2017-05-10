//
//  UIBarButtonItem+Extension.h
//  Finance
//
//  Created by xinbb on 15/7/13.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage;

+(UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)hilight target:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithImage:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithImage:(NSString *)image target:(id)target action:(SEL)action;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com