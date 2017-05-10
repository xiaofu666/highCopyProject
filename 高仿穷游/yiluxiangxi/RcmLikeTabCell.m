//
//  RcmLikeTabCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "RcmLikeTabCell.h"
#import "AppDelegate.h"
@implementation RcmLikeTabCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    UIApplication* application=[UIApplication sharedApplication];
    AppDelegate* delegate=application.delegate;
    self.recImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:7 andY:5 andWidth:90 andHeight:70]];
    //self.recImageView.backgroundColor=[UIColor cyanColor];
    [self.contentView addSubview:self.recImageView];
    
    self.recDetailLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:104 andY:5 andWidth:357-90-7-20 andHeight:30]];
    //self.recDetailLabel.backgroundColor=[UIColor redColor];
    self.recDetailLabel.font=[UIFont systemFontOfSize:12];
    self.recDetailLabel.numberOfLines=2;
    [self.contentView addSubview:self.recDetailLabel];
    
    self.recUserNameLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:104 andY:35 andWidth:80 andHeight:20]];
    //self.recUserNameLabel.backgroundColor=[UIColor grayColor];
    self.recUserNameLabel.textColor=[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
    self.recUserNameLabel.font=[UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.recUserNameLabel];
    
    self.recLiftLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:104 andY:55 andWidth:80 andHeight:20]];
    //self.recLiftLabel.backgroundColor=[UIColor yellowColor];
    self.recLiftLabel.font=[UIFont systemFontOfSize:10];
    self.recLiftLabel.textColor=[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
    [self.contentView addSubview:self.recLiftLabel];
    
    self.recRightLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:184 andY:55 andWidth:80 andHeight:20]];
    //self.recRightLabel.backgroundColor=[UIColor lightGrayColor];
    self.recRightLabel.font=[UIFont systemFontOfSize:10];
    self.recRightLabel.textColor=[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
    [self.contentView addSubview:self.recRightLabel];
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
}
@end
