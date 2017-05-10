//
//  WSDayNewsCell.h
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSNews;

@interface WSDayNewsCell : UITableViewCell

@property (strong, nonatomic) WSNews *news;

+ (instancetype)dayNewsCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


+ (CGFloat)rowHeightWithIndexPath:(NSIndexPath *)indexPath;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com