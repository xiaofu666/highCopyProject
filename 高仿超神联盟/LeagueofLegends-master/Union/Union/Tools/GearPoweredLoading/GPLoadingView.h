//
//  GPLoadingView.h
//  
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidLoadAnimationBlock)();

@interface GPLoadingView : UIView

@property (nonatomic , assign )BOOL isAuxiliaryGear;//是否在加载时显示辅助齿轮

@property (nonatomic , copy )DidLoadAnimationBlock didLoadBlock;//加载动画结束Block

//即将开始加载视图

- (void)willLoadView;

//正在加载视图

- (void)loadingView;

//已加载完毕视图

- (void)didLoadView;

//错误加载视图

- (void)errorLoadView;

@end

