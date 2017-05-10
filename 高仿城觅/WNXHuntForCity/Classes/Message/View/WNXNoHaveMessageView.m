//
//  WNXNoHaveMessageView.m
//  WNXHuntForCity
//  github:    https://github.com/ZhongTaoTian/WNXHuntForCity
//  项目讲解博客:http://www.jianshu.com/p/8b0d694d1c69
//  Created by MacBook on 15/7/15.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  没有消息时候显示的view

#import "WNXNoHaveMessageView.h"

@implementation WNXNoHaveMessageView

- (void)awakeFromNib
{
    self.backgroundColor = WNXColor(239, 239, 244);
}

+ (instancetype)noHaveMessageView
{
    WNXNoHaveMessageView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    view.frame = CGRectMake((WNXAppWidth - 200) / 2, 150, 200, 210);
    return view;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com