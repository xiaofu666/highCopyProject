//
//  SleeveImageCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SleeveImageCell.h"
#import "AppDelegate.h"

@implementation SleeveImageCell
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
    self.recImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:120 andHeight:180]];
    //self.recImageView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.recImageView];
}
@end
