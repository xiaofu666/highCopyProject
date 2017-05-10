//
//  WNXRenderBlurView.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  模糊的View

#import <UIKit/UIKit.h>

@class WNXRenderBlurView;
@protocol WNXRenderBlurViewDelegate <NSObject>
- (void)renderBlurView:(WNXRenderBlurView *)view didSelectedCellWithTitle:(NSString *)title;
- (void)renderBlurViewCancelBtnClick:(WNXRenderBlurView *)view;

@end

@interface WNXRenderBlurView : UIImageView

+ (instancetype)renderBlurViewWithImage:(UIImage *)image;

@property (nonatomic, weak) id <WNXRenderBlurViewDelegate> delegate;

- (void)hideBlurView;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com