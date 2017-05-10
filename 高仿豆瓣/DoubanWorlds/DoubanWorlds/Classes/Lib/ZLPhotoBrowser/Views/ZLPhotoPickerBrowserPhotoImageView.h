//
//  ZLPhotoPickerBrowserPhotoImageView.h
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-14.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZLPhotoPickerBrowserPhotoImageViewDelegate;

@interface ZLPhotoPickerBrowserPhotoImageView : UIImageView {}

@property (nonatomic, weak) id <ZLPhotoPickerBrowserPhotoImageViewDelegate> tapDelegate;
@property (assign,nonatomic) CGFloat progress;

- (void)addScaleBigTap;
- (void)removeScaleBigTap;
@end

@protocol ZLPhotoPickerBrowserPhotoImageViewDelegate <NSObject>

@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com