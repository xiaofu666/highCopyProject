
//  AppDelegate.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "AppDelegate.h"

//LeanCloud
#import <AVOSCloud/AVOSCloud.h>

//RongYun
#import <RongIMLib/RongIMLib.h>

#import "PreViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.bounds = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self changeNav];
    
    //注册LeanCloud
    [self initAVOSCloud];
    
    //注册融云
    [self initRongYun];
    
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    PreViewController * preVC = [storyBoard instantiateViewControllerWithIdentifier:@"PreViewController"];
    
    self.window.rootViewController = preVC;
    
    return YES;
}

/**
 *  全局改变Nav
 */
- (void)changeNav
{
     //设置NavigationBar背景颜色
     [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:1]];
     //@{}代表Dictionary
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     //不设置这个无法修改状态栏字体颜色
     [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
     //返回按钮的颜色
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

#pragma mark -- 注册LeanCloud --
- (void)initAVOSCloud
{
    [AVOSCloud setApplicationId:@"YavVlGleImoT5XVkekX0kyGm-gzGzoHsz"
                      clientKey:@"nPIl7IkH9LtvsnUK7b8hxlS4"];
}


#pragma mark -- 注册融云 --
- (void)initRongYun
{
    [[RCIMClient sharedRCIMClient] init:@"x4vkb1qpvduzk"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"EnterBackground" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

//进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"EnterForeground" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
