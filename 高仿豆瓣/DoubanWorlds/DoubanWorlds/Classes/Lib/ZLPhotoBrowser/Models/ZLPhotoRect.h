//
//  ZLPhotoRect.h
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15/8/21.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPhotoRect : NSObject
+ (CGRect)setMaxMinZoomScalesForCurrentBoundWithImage:(UIImage *)image;
+ (CGRect)setMaxMinZoomScalesForCurrentBoundWithImageView:(UIImageView *)imageView;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com