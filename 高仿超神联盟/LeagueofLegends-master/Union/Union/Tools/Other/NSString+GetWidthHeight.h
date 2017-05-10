//
//  NSString+GetWidthHeight.h
//  
//
//  Created by HarrisHan on 15/6/9.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (GetWidthHeight)

//自定义方法 用来获取字符串显示的高度

+(CGFloat)getHeightWithstring:(NSString *)string Width:(CGFloat)width FontSize:(CGFloat)fontsize;


//自定义方法 用来获取字符串显示的宽度

+(CGFloat)getWidthWithstring:(NSString *)string Width:(CGFloat)width FontSize:(CGFloat)fontsize;

@end
