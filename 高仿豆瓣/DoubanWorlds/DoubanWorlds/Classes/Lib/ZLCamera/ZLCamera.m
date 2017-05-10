//
//  ZLCamera.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15-1-23.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "ZLCamera.h"

@implementation ZLCamera

- (UIImage *)photoImage{
    return [UIImage imageWithContentsOfFile:self.imagePath];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com