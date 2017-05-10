//
//  ZLPhotoPickerBrowserPhotoScrollView.h
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-14.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZLPhotoPickerBrowserPhotoImageView.h"
#import "ZLPhotoPickerBrowserPhotoView.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhoto.h"

typedef void(^callBackBlock)(id obj);
@class ZLPhotoPickerBrowserPhotoScrollView;

@protocol ZLPhotoPickerPhotoScrollViewDelegate <NSObject>
@optional
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(ZLPhotoPickerBrowserPhotoScrollView *)photoScrollView;
@end

@interface ZLPhotoPickerBrowserPhotoScrollView : UIScrollView <UIScrollViewDelegate, ZLPhotoPickerBrowserPhotoImageViewDelegate,ZLPhotoPickerBrowserPhotoViewDelegate>

@property (nonatomic,strong) ZLPhotoPickerBrowserPhoto *photo;
@property (strong,nonatomic) ZLPhotoPickerBrowserPhotoImageView *photoImageView;
@property (nonatomic, weak) id <ZLPhotoPickerPhotoScrollViewDelegate> photoScrollViewDelegate;
// 长按图片的操作，可以外面传入
@property (strong,nonatomic) UIActionSheet *sheet;
// 单击销毁的block
@property (copy,nonatomic) callBackBlock callback;
- (void)setMaxMinZoomScalesForCurrentBounds;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com