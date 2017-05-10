//
//  CityIndexCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/25.
//  Copyright © 2015年 LYoung. All rights reserved.
//  城市cell

#import <UIKit/UIKit.h>

@interface CityIndexCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)getCellHeight;


@property (nonatomic ,strong) NSString *cityName;


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com