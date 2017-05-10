//
//  TranslucentNavbar.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/7.
//  Copyright © 2016年 LYoung. All rights reserved.
//  自定义透明的导航栏

#import <UIKit/UIKit.h>

@interface TranslucentNavbar : UIView

@property (nonatomic ,assign) BOOL barHidden;

@property (nonatomic ,strong) NSString *title;//主标题

@property (nonatomic ,strong) NSString *orgTitle;//原始标题

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com