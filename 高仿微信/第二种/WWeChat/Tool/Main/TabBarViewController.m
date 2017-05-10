//
//  TabBarViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "TabBarViewController.h"

#import "AddressBookViewController.h"
#import "FoundViewController.h"
#import "ChatViewController.h"
#import "MeViewController.h"

#import "WWeChatApi.h"
@interface TabBarViewController ()


@end

@implementation TabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChatViewController * chatVC = [[ChatViewController alloc]init];
    chatVC.tabBarItem.title = @"微信";
    chatVC.navigationItem.title = @"微信";
    
    AddressBookViewController * addbkVC = [[AddressBookViewController alloc]init];
    addbkVC.title = @"通讯录";
    
    FoundViewController * foundVC = [[FoundViewController alloc]init];
    foundVC.title = @"发现";
    
    MeViewController * meVC = [[MeViewController alloc]init];
    meVC.title = @"我";
    
    self.viewControllers = @[
                             [self giveMeNavWithVC:chatVC andImgName:@"tabbar_chat_no" andSelectImgName:@"tabbar_chat_yes"],
                             
                             [self giveMeNavWithVC:addbkVC andImgName:@"tabbar_book_no" andSelectImgName:@"tabbar_book_yes"],
                             
                             [self giveMeNavWithVC:foundVC andImgName:@"tabbar_found_no"andSelectImgName:@"tabbar_found_yes"],
                             
                             [self giveMeNavWithVC:meVC andImgName:@"tabbar_me_no"andSelectImgName:@"tabbar_me_yes"]
                             ];
    
    self.tabBar.tintColor = [UIColor colorWithRed:9/255.0 green:187/255.0 blue:7/255.0 alpha:1];
    
}

/**
 *  返回取消渲染的image
 */
- (UIImage *)removeRendering:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
   return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  快速创建Nav
 */
- (UINavigationController *)giveMeNavWithVC:(UIViewController *)VC andImgName:(NSString *)imgName andSelectImgName:(NSString *)selectImgName
{
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:VC.tabBarItem.title image:[self removeRendering:imgName] selectedImage:[self removeRendering:selectImgName]];
    
    return nav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
