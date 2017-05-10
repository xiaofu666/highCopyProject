//
//  NSString+WS.m
//  网易新闻
//
//  Created by WackoSix on 15/12/29.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "NSString+WS.h"

@implementation NSString (WS)

- (CGSize)sizeOfFont:(UIFont *)font textMaxSize:(CGSize)maxSize{
    
   return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com