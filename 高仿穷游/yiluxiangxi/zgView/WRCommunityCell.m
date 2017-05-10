//
//  WRCommunityCell.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityCell.h"
#import "AppDelegate.h"

@implementation WRCommunityCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //self.contentView.backgroundColor=[UIColor redColor];
        UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
        self.imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:15 andWidth:40 andHeight:40]];
        self.imageView.backgroundColor=[UIColor greenColor];
        [self.contentView addSubview:self.imageView];
        
        self.nameLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:50 andY:10 andWidth:100 andHeight:20]];
        self.nameLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.nameLabel];
        
        self.invitationLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:50 andY:40 andWidth:100 andHeight:20]];
        self.invitationLabel.font=[UIFont systemFontOfSize:11];
        self.invitationLabel.textColor = [UIColor lightGrayColor];
        self.invitationLabel.alpha = 0.7;
        [self.contentView addSubview:self.invitationLabel];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:60 andWidth:160 andHeight:2]];
        imageView.backgroundColor=[UIColor grayColor];
        imageView.alpha=0.3;
        [self.contentView addSubview:imageView];
    }
    return self;
}

@end
