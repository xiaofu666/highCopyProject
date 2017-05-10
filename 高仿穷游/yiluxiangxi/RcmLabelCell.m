//
//  RcmLabelCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "RcmLabelCell.h"
#import "AppDelegate.h"

@implementation RcmLabelCell
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
    self.recImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:7 andY:0 andWidth:169 andHeight:100]];
    //self.recImageView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.recImageView];
    
    self.recTitlelabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:7 andY:100 andWidth:169 andHeight:30]];
    //self.recTitlelabel.backgroundColor=[UIColor blueColor];
    self.recTitlelabel.font=[UIFont systemFontOfSize:12];
    self.recTitlelabel.numberOfLines=2;
    [self.contentView addSubview:self.recTitlelabel];
    
    self.recDiscountLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:7 andY:130 andWidth:40 andHeight:30]];
    //self.recDiscountLabel.backgroundColor=[UIColor orangeColor];
    self.recDiscountLabel.font=[UIFont systemFontOfSize:11];
    self.recDiscountLabel.textAlignment=NSTextAlignmentCenter;
    self.recDiscountLabel.textColor=[UIColor orangeColor];
    [self.contentView addSubview:self.recDiscountLabel];
    
    self.recPriceLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:169+7-90 andY:130 andWidth:60 andHeight:30]];
    self.recPriceLabel.font=[UIFont systemFontOfSize:11];
    //self.recPriceLabel.backgroundColor=[UIColor yellowColor];
    self.recPriceLabel.font=[UIFont systemFontOfSize:17];
    self.recPriceLabel.textColor=[UIColor redColor];
    [self.contentView addSubview:self.recPriceLabel];
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    UILabel* label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:169+7-30 andY:133 andWidth:30 andHeight:25]];
    label.text=@"元起";
    label.font=[UIFont systemFontOfSize:10];
    [self.contentView addSubview:label];
    
}
@end
