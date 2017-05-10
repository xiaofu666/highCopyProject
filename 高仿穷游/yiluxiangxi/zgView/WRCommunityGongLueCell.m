//
//  WRCommunityGongLueCell.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityGongLueCell.h"
#import "AppDelegate.h"

@implementation WRCommunityGongLueCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
        self.titleLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:15 andWidth:345 andHeight:40 ]];
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines=0;
        [self.contentView addSubview:self.titleLabel];
        
        self.dataLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:15 andY:70 andWidth:150 andHeight:20]];
        self.dataLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dataLabel];
        
        self.readImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:220 andY:70 andWidth:20 andHeight:20]];
        self.readImageView.image=[UIImage imageNamed:@"在线拍卖图标-70.png"];
        [self.contentView addSubview:self.readImageView];
        
        self.commentImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:300 andY:70 andWidth:20 andHeight:20]];
        self.commentImageView.image=[UIImage imageNamed:@"在线拍卖图标_画板 189.png"];
        [self.contentView addSubview:self.commentImageView];
        
        self.readLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:250 andY:70 andWidth:50 andHeight:20]];
        self.readLabel.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.readLabel];
        
        self.commenLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:330 andY:70 andWidth:30 andHeight:20]];
        self.commenLabel.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.commenLabel];
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
