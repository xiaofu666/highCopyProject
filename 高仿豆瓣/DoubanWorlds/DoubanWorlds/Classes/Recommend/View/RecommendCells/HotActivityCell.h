//
//  HotActivityCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//  热门活动cell

#import <UIKit/UIKit.h>
@class RecommendModel;

@interface HotActivityCell : UITableViewCell

+(CGFloat)getCellHeight:(RecommendModel *)model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) RecommendModel *model;


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com