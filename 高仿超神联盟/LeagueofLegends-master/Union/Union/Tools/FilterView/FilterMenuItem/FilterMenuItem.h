//
//  FilterMenuItem.h
//  筛选栏封装
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FilterMenuModel.h"

typedef void (^SelectedButtonBlock)(NSString *buttonTitle , NSString *type);

typedef void (^SelectedItemBlock)(NSInteger itemIndex);

@interface FilterMenuItem : UIView

@property (nonatomic , retain ) FilterMenuModel *fmModel;//数据模型

@property (nonatomic, assign ) NSInteger ItemIndex;//ItemIndex 下标

@property (nonatomic , retain ) UIColor *selectedColor;//选中颜色

@property (nonatomic , assign ) BOOL isSelected;//是否被选中

@property (nonatomic , copy ) SelectedItemBlock selectedItemBlock;//选中ItemBLock;

@property (nonatomic , copy ) SelectedButtonBlock selectedButtonBlock;//选中ButtonBLock;

@end
