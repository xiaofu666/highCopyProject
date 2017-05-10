//
//  WRCommunityZuiXinCell.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityZuiXinCell.h"
#import "AppDelegate.h"
@implementation WRCommunityZuiXinCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
        self.headImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:15 andY:15 andWidth:40 andHeight:40]];
        //self.headImageView.backgroundColor=[UIColor greenColor];
        [self.contentView addSubview:self.headImageView];
        
        self.nameLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:65 andY:10 andWidth:100 andHeight:20]];
        self.nameLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.nameLabel];
        
        self.detailLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:65 andY:35 andWidth:235 andHeight:40]];
        self.detailLabel.font=[UIFont systemFontOfSize:13];
        self.detailLabel.numberOfLines=0;
        [self.contentView addSubview:self.detailLabel];
        
        self.dataLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:65 andY:80 andWidth:150 andHeight:20]];
        self.dataLabel.textColor = [UIColor lightGrayColor];
        self.dataLabel.alpha = 0.7;
        self.dataLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.dataLabel];
        
        self.numLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:325 andY:80 andWidth:25 andHeight:20]];
        self.numLabel.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.numLabel];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:290 andY:80 andWidth:25 andHeight:20]];
        //imageView.backgroundColor=[UIColor greenColor];
        imageView.image=[UIImage imageNamed:@"评论按钮@2x.png"];
        [self.contentView addSubview:imageView];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:310 andY:20 andWidth:15 andHeight:15]];
        label1.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
        label1.text=@"顶";
        label1.textAlignment=NSTextAlignmentCenter;
        label1.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:label1];
        
        UILabel *label2=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:330 andY:20 andWidth:15 andHeight:15]];
        label2.backgroundColor=[UIColor colorWithRed:0.4 green:0.7 blue:0.8 alpha:1];
        label2.text=@"精";
        label2.textAlignment=NSTextAlignmentCenter;
        label2.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:label2];
        
        
        
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
