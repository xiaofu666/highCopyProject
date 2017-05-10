//
//  YiRefreshFooter.h
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//
//YiRefresh is a simple way to use pull-to-refresh.下拉刷新，大道至简，最简单的网络刷新控件
//项目地址在：https://github.com/coderyi/YiRefresh
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);

@interface YiRefreshFooter : NSObject
@property(nonatomic,strong) UIScrollView *scrollView;

/**
 *  callback when refreshing
 */
@property(nonatomic,copy) BeginRefreshingBlock beginRefreshingBlock;

/**
 *  footer's init
 */
-(void)footer;

/**
 *  begin refresh
 */
-(void)beginRefreshing;

/**
 *  end refresh
 */
-(void)endRefreshing;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com