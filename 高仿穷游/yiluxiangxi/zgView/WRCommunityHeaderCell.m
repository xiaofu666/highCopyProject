//
//  WRCommunityHeaderCell.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityHeaderCell.h"
#import "AppDelegate.h"

@implementation WRCommunityHeaderCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //self.contentView.backgroundColor=[UIColor greenColor];
        self.contentView.layer.borderWidth=0.5;
        UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
        
        
        self.titleLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:20 andY:10 andWidth:50 andHeight:15]];
        self.titleLabel.adjustsFontSizeToFitWidth=YES;
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.alpha = 0.7;
        [self.contentView addSubview:self.titleLabel];
        
        self.detaillabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:20 andY:30 andWidth:120 andHeight:15]];
        self.detaillabel.textColor = [UIColor grayColor];
        self.detaillabel.alpha = 0.7;
        self.detaillabel.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:self.detaillabel];
        
    }
    return self;
}
@end
