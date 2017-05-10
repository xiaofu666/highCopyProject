//
//  WRCommunityShaiXuanMuDiDiCell.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/7.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityShaiXuanMuDiDiCell.h"
#import "AppDelegate.h"

@implementation WRCommunityShaiXuanMuDiDiCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
        self.chineseLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:0 andY:5 andWidth:100 andHeight:20]];
        self.chineseLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.chineseLabel];
        self.englishLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:0 andY:25 andWidth:100 andHeight:20]];
        self.englishLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.englishLabel];
        
        self.rightImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:300 andY:10 andWidth:30 andHeight:35]];
        [self.contentView addSubview:self.rightImageView];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
