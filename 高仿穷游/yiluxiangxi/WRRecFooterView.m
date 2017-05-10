//
//  WRRecFooterView.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRRecFooterView.h"
#import "AppDelegate.h"
@implementation WRRecFooterView

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
    self.footBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.footBtn.frame=[delegate createFrimeWithX:0 andY:0 andWidth:355 andHeight:40];
    [self.footBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.footBtn setTitleColor:[UIColor colorWithRed:0.7 green:0.5 blue:0.3 alpha:1] forState:UIControlStateNormal];
    [self.footBtn addTarget:self action:@selector(pressBtnWithTitle:) forControlEvents:UIControlEventTouchUpInside];
    self.footBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:self.footBtn];
}

-(void)pressBtnWithTitle:(UIButton* )btn{
    
    if ([self.delegate respondsToSelector:@selector(sendBtnTitle:)]) {
        [self.delegate sendBtnTitle:btn];
    }else{
        NSLog(@"被动方没有实现协议方法");
    }
}

@end
