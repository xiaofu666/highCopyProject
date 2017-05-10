//
//  XHQTabBarViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQTabBarViewController.h"

@interface XHQTabBarViewController ()

@end

@implementation XHQTabBarViewController

//初始化
-(instancetype)init{
    if (self=[super init]) {
        _controllers = [[NSMutableArray alloc] init];
    }
    return self;
}

//创建tabbaritem
-(void) addItem:(NSString*)title normalImage:(UIImage*)normal highLightImage:(UIImage*)highLight controller:(NSString*)controllerName {
    
    //创建tabBarItem
    normal = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    highLight = [highLight imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:title image:normal selectedImage:highLight];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName: [UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    
    //得到控制器类
    Class controllerClass = NSClassFromString(controllerName);
    
    //创建控制器
    UIViewController *  controller = [[controllerClass alloc] init];
    controller.navigationItem.title = title;//设置导航栏标题
    
    //创建导航栏
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    //设置item
    controller.tabBarItem = item;
    //    controller.tabBarController.tabBar.barTintColor = ;
    self.tabBar.barTintColor =[UIColor colorWithRed:121.0/255 green:200.0/255 blue:231.0/255 alpha:1];
    
    //将控制器加入数组
    [_controllers addObject:navigationController];
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com