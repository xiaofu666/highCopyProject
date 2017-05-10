//
//  FilterView.h
//  筛选栏封装
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewDelegate <NSObject>

//传递选中筛选条件 和 筛选类型

- (void)selectedScreeningConditions:(NSString *)condition Type:(NSString *)type;

@end

@interface FilterView : UIView

//数据源数组数据结构 :
//
//
//

@property (nonatomic , retain ) NSArray *dataArray;// 数据源数组

@property (nonatomic , assign ) id<FilterViewDelegate> delegate;//代理对象

@end
