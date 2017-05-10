//
//  PersonCell.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/29.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface PersonCell : UITableViewCell

/**
 *  model
 */
@property(nonatomic,strong)PersonModel * model;

/**
 *  用户头像ImgView
 */
@property (nonatomic,strong)UIImageView * avaterImgView;

/**
 *  用户名Label
 */
@property (nonatomic,strong)UILabel * userNameLabel;

/**
 *  微信号Label
 */
@property (nonatomic,strong)UILabel * weIDLabel;

/**
 *  二维码ImgView
 */
@property (nonatomic,strong)UIImageView * wmImgView;
- (void)setModel:(PersonModel *)model;

@end
