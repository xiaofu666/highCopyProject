//
//  SmartbiAdaHomeTableViewCell.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaHomeTableViewCell.h"



@implementation SmartbiAdaHomeTableViewCell
-(void)refreshUI:(SmartbiAdaHome *)HomeModel{
//    HomeModel.avatar_url
    [self.userAvatarView sd_setImageWithURL:[NSURL URLWithString:HomeModel.avatar_url] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.userAvatarView.layer.cornerRadius=20.0f;
    self.nameLabel.text=HomeModel.name;
    self.TEXTLabel.text=HomeModel.text;
    self.TEXTLabel.numberOfLines=0;
    [self.categoryButton setTitle:HomeModel.category_name forState:UIControlStateNormal];
    
    if ([HomeModel.url_list length] >0) {
        [self.IMAGEView sd_setImageWithURL:[NSURL URLWithString:HomeModel.url_list] placeholderImage:[UIImage imageNamed:@"photo"]];
    }
    self.digg_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.digg_count];
    
    
    self.bury_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.bury_count];
    self.comment_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.comment_count];
    self.share_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.share_count];
    
    //设置cell中笑话的高度
    self.TEXTHeight.constant =[HomeModel.contentSize floatValue];
    if ([HomeModel.pictureWidth floatValue]>0) {
        self.UIImageViewHeight.constant=([HomeModel.pictureSize floatValue]/([HomeModel.pictureWidth floatValue]/(kScreenWidth-40)));
    }
    else
    {
        self.UIImageViewHeight.constant=[HomeModel.pictureSize floatValue];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
