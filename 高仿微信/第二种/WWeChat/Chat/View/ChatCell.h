//
//  ChatCell.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/31.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@interface ChatCell : UITableViewCell

/**
 *  头像imgView
 */
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;

/**
 *  名字Label
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  信息Label
 */
@property (weak, nonatomic) IBOutlet UILabel *messagelabel;

/**
 *  时间Label
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 *  model
 */
@property (nonatomic,strong)ChatModel * model;

/**
 *  avaterImgView高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avaterImgViewHeight;

/**
 *  avaterImgView宽度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avaterImgViewWidth;

- (void)setModel:(ChatModel *)model;
@end
