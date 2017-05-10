//
//  NSString+GetWidthHeight.m
//  
//
//  Created by HarrisHan on 15/6/9.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "NSString+GetWidthHeight.h"

@implementation NSString (GetWidthHeight)

#pragma mark+++自定义方法 用来获取字符串显示的高度

+(CGFloat)getHeightWithstring:(NSString *)string Width:(CGFloat)width FontSize:(CGFloat)fontsize{
    //获取字符串显示高度
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    
    CGRect rect=[string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    
    return rect.size.height;
}

#pragma mark+++自定义方法 用来获取字符串显示的宽度

+(CGFloat)getWidthWithstring:(NSString *)string Width:(CGFloat)width FontSize:(CGFloat)fontsize{
    //获取字符串显示高度
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    
    CGRect rect=[string boundingRectWithSize:CGSizeMake(width, 1000000000) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    
    return rect.size.width;
}

@end
