//
//  SmartbiAdaFindTableViewCell.m
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/20.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaFindTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SmartbiAdaFindTableViewCell
-(void)refreshUI:(SmartbiAdaFind *)FindModel{
 
    [self.icon sd_setImageWithURL:[NSURL URLWithString:FindModel.icon] placeholderImage:[UIImage imageNamed:@"phone"]];
    self.name.text=FindModel.name;
    self.intro.text=FindModel.intro;
    self.subscribe.text=[NSString stringWithFormat:@"%@ 订阅| 总帖数",FindModel.subscribe_count];
    NSString *str=[NSString stringWithFormat:@"%@",FindModel.total_updates];
//    NSMutableAttributedString *string=[[NSMutableAttributedString alloc]initWithString:str];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 10)];
    self.total.text=str;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
