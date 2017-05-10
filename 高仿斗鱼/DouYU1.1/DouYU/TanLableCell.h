//
//  TanLableCell.h
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Example;

+(instancetype)GetCellWithTableView:(UITableView *)tableView;
@end
