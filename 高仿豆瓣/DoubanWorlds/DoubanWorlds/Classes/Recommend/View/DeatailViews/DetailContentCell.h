//
//  DetailContentCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/30.
//  Copyright © 2015年 LYoung. All rights reserved.
//  活动详情页，内容详情

#import <UIKit/UIKit.h>

@class RecommendModel;

@interface DetailContentCell : UITableViewCell

@property (nonatomic ,strong) RecommendModel *model;

+(CGFloat)getCellHeight:(RecommendModel *)model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com