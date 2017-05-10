//
//  SmartbiAdaHomeTableViewCell.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartbiAdaTakeDetail.h"

@interface SmartbiAdaTakeDetailTableViewCell : UITableViewCell
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
@property (weak, nonatomic) IBOutlet UIView  *videoView;


@property (weak, nonatomic) IBOutlet UIView *backView;
//video的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoHeight;
@property (weak, nonatomic) IBOutlet UIButton *statVideo;
- (IBAction)startVideoClick:(id)sender;


@property (weak, nonatomic) IBOutlet UISlider *Sli;
- (IBAction)sliValue:(id)sender;


//笑话文字约束的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TEXTHeight;
//笑话图片约束的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageViewHeight;


-(void)refreshUI:(SmartbiAdaTakeDetail *)TakeDetail;


@end
