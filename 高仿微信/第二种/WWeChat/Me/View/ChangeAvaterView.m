//
//  ChangeAvaterView.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChangeAvaterView.h"

@implementation ChangeAvaterView
{
    CGFloat _height;
}
- (instancetype)initWithFrame:(CGRect)frame andBtnArr:(NSArray *)btnArr;
{
    if (self = [super initWithFrame:frame])
    {
        _thisTag = 50000;
        
        _height = 0;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        self.userInteractionEnabled = YES;
        
        UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [control addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
        [self createPopViewWithArr:btnArr];
    }
    return self;
}

- (void)createPopViewWithArr:(NSArray *)arr
{
    _height = WGiveHeight(48 * (arr.count + 1)) + WGiveHeight(5);
    
    _popView = ({
        
        UIView * popView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width,_height)];
        popView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:231/255.0 alpha:1];
        popView;
    });
    [self addSubview:self.popView];
    
    for (int i = 0 ; i < arr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i * WGiveHeight(48), self.frame.size.width, WGiveHeight(47));
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = _thisTag + i;
        [_popView addSubview:btn];
    }
    
    //取消按钮
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.frame = CGRectMake(0, _height - WGiveHeight(48), self.frame.size.width, WGiveHeight(48));
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:cancelBtn];
}

- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
       
        self.popView.frame = CGRectMake(0, self.frame.size.height - _height, self.frame.size.width, _height);
        
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _popView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, _height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
   
}


@end
