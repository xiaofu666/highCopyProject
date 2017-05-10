//
//  WRRecHeaderView.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRRecHeaderView.h"
#import "AppDelegate.h"
@implementation WRRecHeaderView

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
    self.titleLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:9 andY:0 andWidth:356 andHeight:40]];
    //self.titleLabel.backgroundColor=[UIColor yellowColor];
    self.titleLabel.font=[UIFont systemFontOfSize:13];
    self.titleLabel.textColor=[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
    self.titleLabel.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [self addSubview:self.titleLabel];
}

@end
