//
//  SwithCell.h
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwithCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UISwitch *cellSwith;

@property (strong, nonatomic) IBOutlet UILabel *Title;
+(instancetype)GetCellWithTableView:(UITableView *)tableView;
@end
