//
//  SmartbiAdaHomeTableViewCell.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaDiscoverTableViewCell.h"



@implementation SmartbiAdaDiscoverTableViewCell

- (IBAction)btnClick:(id)sender {
    // 通过代理的方式，把事件传给ViewController
    if ([self.delegate respondsToSelector:@selector(cell:buttonDidClicked:index:)]) {
        [self.delegate cell:self buttonDidClicked:sender index:123];
        //        [self.delegate cell:self buttonDidClicked:sender index:[sender tag]-100];
    }
//    NSLog(@"    我点击的事件");
}

-(void)refreshUI:(SmartbiAdaHome *)HomeModel{
    [self.userAvatarView sd_setImageWithURL:[NSURL URLWithString:HomeModel.avatar_url] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.userAvatarView.layer.cornerRadius=20.0f;
    self.nameLabel.text=HomeModel.name;

    self.TEXTLabel.text=HomeModel.text;
    self.TEXTLabel.numberOfLines=0;
    [self.categoryButton setTitle:HomeModel.category_name forState:UIControlStateNormal];

  
    
    if ([HomeModel.large_cover length] >0) {
        [self.IMAGEView sd_setImageWithURL:[NSURL URLWithString:HomeModel.large_cover] placeholderImage:[UIImage imageNamed:@"photo"]];
    }
    self.digg_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.digg_count];

    
    self.bury_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.bury_count];
    self.comment_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.comment_count];
    self.share_countLabel.text=[NSString stringWithFormat:@"%@",HomeModel.share_count];
    
    
    //设置cell中笑话的高度
    if ([HomeModel.video_width floatValue] > 0) {
        self.UIImageViewHeight.constant=[HomeModel.video_height floatValue]/ ([HomeModel.video_width floatValue]/(kScreenWidth-40));
       
    }
    else
    {
        self.UIImageViewHeight.constant=[HomeModel.video_height floatValue];
    }
    self.TEXTHeight.constant =[HomeModel.contentSize floatValue];
    
    self.IMAGEView.userInteractionEnabled=YES;
    self.mp4_url=HomeModel.mp4_url;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
