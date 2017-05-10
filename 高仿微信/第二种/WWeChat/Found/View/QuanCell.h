//
//  QuanCell.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/17.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuanModel.h"
@interface QuanCell : UITableViewCell

@property(nonatomic,strong)QuanModel * model;

- (void)setModel:(QuanModel *)model;

@end
