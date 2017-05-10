//
//  MoviePlayerViewController.h
//  Player
//
//  Created by dllo on 15/11/7.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePlayerViewController : UIViewController

@property (nonatomic,copy) NSString *url;

@property (copy, nonatomic) void (^playFinished)();

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com