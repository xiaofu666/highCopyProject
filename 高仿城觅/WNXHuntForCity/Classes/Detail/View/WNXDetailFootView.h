//
//  WNXDetailFootView.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/11.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  详情页底部显示的收藏的用户

#import <UIKit/UIKit.h>
@class WNXDetailFootView;

@protocol WNXDetailFootViewDelegate <NSObject>

@optional
//点击事件
- (void)detailFootViewDidClick:(WNXDetailFootView *)footView index:(NSInteger)index;

@end

@interface WNXDetailFootView : UIView

@property(nonatomic, assign) id <WNXDetailFootViewDelegate> delegate;

+ (instancetype)detailFootView;//应该传入模型的

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com