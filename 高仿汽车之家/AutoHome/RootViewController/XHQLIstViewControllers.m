//
//  XHQLIstViewControllers.m
//  AutoHome
//
//  Created by qianfeng on 16/3/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQLIstViewControllers.h"
#import "XHQSearchViewController.h"
@interface XHQLIstViewControllers ()

@end

@implementation XHQLIstViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatNavigationItem];
}

- (void)creatNavigationItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector( Actionsearch )];
}
- (void)Actionsearch
{
    XHQSearchViewController *search = [[XHQSearchViewController alloc]init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com