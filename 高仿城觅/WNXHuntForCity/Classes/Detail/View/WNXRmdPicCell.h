//
//  WNXRmdPicCell.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/11.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  详情页推荐tableview的图片cell

#import <UIKit/UIKit.h>
#import "WNXRmdCellModel.h"

@interface WNXRmdPicCell : UITableViewCell

@property (nonatomic, strong) WNXRmdCellModel *model;

+ (instancetype)cellWithTabelView:(UITableView *)tableView  rmdPicModel:(WNXRmdCellModel *)model;


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com