//
//  WRCommunityHeaderView.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityHeaderView.h"
#import "AppDelegate.h"

@implementation WRCommunityHeaderView

{
    UILabel *headerLabel;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
        headerLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:20 andY:10 andWidth:335 andHeight:20]];
        
        headerLabel.textColor=[UIColor blackColor];
        
        
        [self addSubview:headerLabel];
        
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:20 andY:35 andWidth:160 andHeigth:2]];
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:20 andY:35 andWidth:160 andHeight:2]];
        
        imageView.backgroundColor=[UIColor grayColor];
        [self addSubview:imageView];


    }
    return  self;
}
-(void)setHeaderString:(NSString *)headerString{
    _headerString=headerString;
    headerLabel.text=_headerString;
}
@end
