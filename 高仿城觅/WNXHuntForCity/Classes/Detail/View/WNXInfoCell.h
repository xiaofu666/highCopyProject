//
//  WNXInfoCell.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/19.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  信息简单的cell,实际比这个复杂的的多,根据数据判断是否可以点击,显示什么图片等等

#import <UIKit/UIKit.h>
#import "WNXInfoModel.h"

@interface WNXInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *corImageView;

@property (weak, nonatomic) IBOutlet UIView *lineView;

/** 数据模型 */
@property (nonatomic, strong) WNXInfoModel *model;

+ (instancetype)infoCellWithTableView:(UITableView *)tableView;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com