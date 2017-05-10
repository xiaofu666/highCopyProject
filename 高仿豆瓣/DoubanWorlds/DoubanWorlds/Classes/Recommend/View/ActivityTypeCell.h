//
//  ActivityTypeCell.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/31.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTypeCell : UITableViewCell

+(CGFloat)getCellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *imageName;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com