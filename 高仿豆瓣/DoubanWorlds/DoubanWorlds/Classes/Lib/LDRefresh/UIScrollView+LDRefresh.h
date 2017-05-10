//
//  UIScrollView+LDRefresh.h
//  LDRefresh
//
//  Created by lidi on 10/6/15.
//  Copyright © 2015 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDRefreshHeaderView;
@class LDRefreshFooterView;

typedef void(^LDRefreshedHandler)(void);
@interface UIScrollView (LDRefresh)

//header
@property (strong, nonatomic) LDRefreshHeaderView *refreshHeader;
- (LDRefreshHeaderView *)addRefreshHeaderWithHandler:(LDRefreshedHandler)refreshHandler;
//For header Extend
- (LDRefreshHeaderView *)addRefreshHeader:(LDRefreshHeaderView *)refreshHeaderView handler:(LDRefreshedHandler)refreshHandler;

//footer
@property (strong, nonatomic) LDRefreshFooterView *refreshFooter;
- (LDRefreshFooterView *)addRefreshFooterWithHandler:(LDRefreshedHandler)refreshHandler;
//For footer Extend
- (LDRefreshFooterView *)addRefreshFooter:(LDRefreshFooterView *)refreshFooterView handler:(LDRefreshedHandler)refreshHandler;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com