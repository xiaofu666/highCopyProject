//
//  DiscountLabelCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/6.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "DiscountLabelCell.h"
#import "AppDelegate.h"
@implementation DiscountLabelCell
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
    self.disImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:7 andY:0 andWidth:169 andHeight:100]];
    //self.disImageView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.disImageView];
    
    self.disTitlelabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:7 andY:100 andWidth:169 andHeight:30]];
    //self.disTitlelabel.backgroundColor=[UIColor blueColor];
    self.disTitlelabel.font=[UIFont systemFontOfSize:12];
    self.disTitlelabel.numberOfLines=2;
    [self.contentView addSubview:self.disTitlelabel];
    
    self.disTimeImage=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:7 andY:137 andWidth:15 andHeight:15]];
    self.disTimeImage.image=[UIImage imageNamed:@"icon_time@2x.png"];
    [self.contentView addSubview:self.disTimeImage];
    
    self.disTimeLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:27 andY:130 andWidth:149 andHeight:30]];
    self.disTimeLabel.font=[UIFont systemFontOfSize:10];
    self.disTimeLabel.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    //self.disTimeLabel.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:self.disTimeLabel];
    
    UIView* view=[[UIView alloc]initWithFrame:[delegate createFrimeWithX:17 andY:160 andWidth:149 andHeight:1]];
    view.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:view];
    
    self.disDiscountLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:7 andY:160 andWidth:40 andHeight:30]];
    //self.disDiscountLabel.backgroundColor=[UIColor orangeColor];
    self.disDiscountLabel.font=[UIFont systemFontOfSize:11];
    self.disDiscountLabel.textAlignment=NSTextAlignmentCenter;
    self.disDiscountLabel.textColor=[UIColor orangeColor];
    [self.contentView addSubview:self.disDiscountLabel];
    
    self.disPriceLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:169+7-90 andY:160 andWidth:60 andHeight:30]];
    self.disPriceLabel.font=[UIFont systemFontOfSize:17];
    self.disPriceLabel.textColor=[UIColor redColor];
    //self.disPriceLabel.backgroundColor=[UIColor purpleColor];
    [self.contentView addSubview:self.disPriceLabel];
    
    UILabel* label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:169+7-30 andY:163 andWidth:30 andHeight:25]];
    label.text=@"元起";
    label.font=[UIFont systemFontOfSize:10];
    [self.contentView addSubview:label];
    //
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
}
@end









