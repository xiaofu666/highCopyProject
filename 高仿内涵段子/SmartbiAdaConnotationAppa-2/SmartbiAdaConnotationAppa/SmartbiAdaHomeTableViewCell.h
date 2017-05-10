//
//  SmartbiAdaHomeTableViewCell.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartbiAdaHome.h"
#import "UIImageView+WebCache.h"
#import "config__api.h"


@interface SmartbiAdaHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *categoryFirst;//标签图


@property (weak, nonatomic) IBOutlet UIImageView *userAvatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TEXTLabel;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIImageView *IMAGEView;


@property (weak, nonatomic) IBOutlet UILabel *digg_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *bury_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *comment_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *share_countLabel;


//笑话文字约束的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TEXTHeight;
//笑话图片约束的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageViewHeight;
-(void)refreshUI:(SmartbiAdaHome *)HomeModel;


@end
