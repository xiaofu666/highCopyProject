//
//  XHQButton.m
//  XHQSimCombine
//
//  Created by qianfeng on 16/1/22.
//  Copyright (c) 2016年 HaiQuan. All rights reserved.
//

#import "XHQButton.h"

@implementation XHQButton

#pragma mark 设置button 内部图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width * 0.8;
    CGFloat imageH = contentRect.size.height * 0.5 ;
    return CGRectMake(5, 0 , imageW, imageH);
}

#pragma mark 设置button 内部文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = (contentRect.size.height * 0.7) - 8 ;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * 0.3;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
