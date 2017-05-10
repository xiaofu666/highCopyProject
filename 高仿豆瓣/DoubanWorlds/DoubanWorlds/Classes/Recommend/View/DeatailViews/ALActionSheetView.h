//
//  ALActionSheetView.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//  自定义actionsheet

#import <UIKit/UIKit.h>

@class ALActionSheetView;

typedef void (^ALActionSheetViewDidSelectButtonBlock)(ALActionSheetView *actionSheetView, NSInteger buttonIndex);

@interface ALActionSheetView : UIView

+ (ALActionSheetView *)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(ALActionSheetViewDidSelectButtonBlock)block;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(ALActionSheetViewDidSelectButtonBlock)block;

- (void)show;
- (void)dismiss;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com