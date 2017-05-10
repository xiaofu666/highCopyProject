//
//  AlarmTableViewCell.h
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmTableViewCell : UITableViewCell
@property (nonatomic, strong) AlarmModel *alarmModel;
//@property (nonatomic, strong) NSDictionary <#*name#>;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *event;
@property (nonatomic, strong) UILabel *notes;

@end
