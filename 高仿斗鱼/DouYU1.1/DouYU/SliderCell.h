//
//  SliderCell.h
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *Small;

@property (strong, nonatomic) IBOutlet UIImageView *Big;

@property (strong, nonatomic) IBOutlet UISlider *Silder;


+(instancetype)GetCellWithTableView:(UITableView *)tableView;
@end
