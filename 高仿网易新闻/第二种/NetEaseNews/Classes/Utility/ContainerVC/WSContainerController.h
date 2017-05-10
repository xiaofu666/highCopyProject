//
//  WSContainerController.h
//  WSContainViewController
//
//  Created by WackoSix on 16/1/6.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSContainerController : UIViewController

@property (strong, nonatomic) UIViewController *parentController;

@property (strong, nonatomic) UIColor *navigationBarBackgrourdColor;

+ (instancetype) containerControllerWithSubControlers:(NSArray<UIViewController *> *)viewControllers parentController:(UIViewController *)vc;


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com