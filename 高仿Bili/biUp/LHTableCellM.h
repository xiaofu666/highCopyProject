//
//  LHTableCellM.h
//  biUp
//
//  Created by snowimba on 15/12/13.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHTaCellM;
@interface LHTableCellM : UITableViewCell
@property (nonatomic,strong) LHTaCellM *cellM;
+ (instancetype)cellWithTableV:(UITableView *)table;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com