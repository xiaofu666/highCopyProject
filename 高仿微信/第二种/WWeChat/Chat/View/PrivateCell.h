//
//  PrivateCell.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface PrivateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *AiConView;
@property (weak, nonatomic) IBOutlet UIImageView *BiConView;


@property (nonatomic,strong)MessageModel * model;

- (void)setModel:(MessageModel *)model;
@end
