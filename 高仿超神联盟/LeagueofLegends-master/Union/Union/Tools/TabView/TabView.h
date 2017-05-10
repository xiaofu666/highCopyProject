//
//  TabView.h
//  
//
//  Created by HarrisHan on 15/6/30.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Block)(NSInteger selectIndex);

@interface TabView : UIView

@property (nonatomic , retain)NSArray *dataArray;//数据源数组

@property (nonatomic , retain)UIScrollView *scrollView;//滑动视图

@property (nonatomic , retain)UIView *lineView; //下划线视图

@property (nonatomic , assign)NSInteger selectIndex;//选中按钮下标

@property (nonatomic , copy)Block returnIndex;//返回选中的下标

@end
