//
//  ChatCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/31.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatCell.h"
#import "WWeChatApi.h"
#import "UIImageView+WebCache.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//更改约束
- (void)changeConstraints
{
    _avaterImgViewHeight.constant = WGiveHeight(45);
    _avaterImgViewWidth.constant = WGiveHeight(45);
}

- (void)setModel:(ChatModel *)model
{
    [self changeConstraints];
    
    self.nameLabel.text = model.name;
    
    self.messagelabel.text = model.message;
    
    self.timeLabel.text = model.time;
    
    [self.avaterImgView setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"avater.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
    
    if (model.noReadNum > 0)
    {
        NSString * noReadNumStr = [NSString stringWithFormat:@"%d",model.noReadNum];
        CGFloat strWidth = [self giveMeWidthWithStr:noReadNumStr];
        if (strWidth < WGiveHeight(15))
        {
            strWidth = WGiveHeight(15);
        }
        UIView * redPoint = [[UIView alloc]initWithFrame:CGRectMake(WGiveHeight(45) - strWidth/2.0, - WGiveHeight(5), strWidth, WGiveHeight(15))];
        redPoint.layer.cornerRadius  = redPoint.frame.size.height/2.0;
        redPoint.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
        UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, redPoint.frame.size.width, redPoint.frame.size.height)];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.font = [UIFont systemFontOfSize:10];
        numLabel.text = noReadNumStr;
        numLabel.textAlignment = NSTextAlignmentCenter;
        [redPoint addSubview:numLabel];
        
        [self.avaterImgView addSubview:redPoint];
    }
}

- (CGFloat)giveMeWidthWithStr:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:10];

    CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, WGiveHeight(20)) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    
    return tmpRect.size.width;
}
@end
