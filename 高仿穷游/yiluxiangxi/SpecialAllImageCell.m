//
//  SpecialAllImageCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SpecialAllImageCell.h"
#import "AppDelegate.h"

@implementation SpecialAllImageCell
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
    self.speImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:357 andHeight:250]];
    //self.speImageView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.speImageView];
}
@end
