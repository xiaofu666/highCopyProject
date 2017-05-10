//
//  LDRefreshFooterView.h
//  LDRefresh
//
//  Created by lidi on 10/6/15.
//  Copyright © 2015 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat LDRefreshFooterHeight;

@interface LDRefreshFooterView : UIView
@property (nonatomic, assign) BOOL autoLoadMore;//default YES
@property (nonatomic, assign) BOOL loadMoreEnabled; //default YES
@property (nonatomic, assign) CGFloat dragHeight;

- (void)endRefresh;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com