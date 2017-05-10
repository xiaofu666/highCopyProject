//
//  AppDelegate.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "XHQTabBarViewController.h"

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"


@interface AppDelegate ()
- (void)initAppearence;
- (void)createAppFrame;
@end

@implementation AppDelegate
{
    XHQTabBarViewController *_tabBarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [self createAppFrame];
    [self initAppearence];
    [self.window makeKeyAndVisible];
    
    [self UmentInit];
    //友盟初始化
    return YES;

    
}

//搭建应用框架
-(void) createAppFrame{
    //创建标签栏控制器
    _tabBarController = [[XHQTabBarViewController alloc] init];
    
    //增加标签1
    
    NSArray *arrName = @[@"推荐",@"论坛",@"找车",@"发现",@"我"];
    
    NSArray *arrNameNImage = @[@"tab_icon_friend_normal@2x",@"tab_icon_more_normal@2x",@"tab_icon_news_normal@2x",@"tab_icon_quiz_normal@2x",@"tab_icon_friend_normal@2x"];
    
    NSArray *arrNameSImage = @[@"tab_icon_friend_press@2x",@"tab_icon_more_press@2x",@"tab_icon_news_press@2x",@"tab_icon_quiz_press@2x",@"tab_icon_friend_press@2x",];
    
    
        NSArray *arr = @[@"XHQRecommendViewController",@"XHQForumViewController",@"XHQZhaoCheViewController",@"XHQFoundViewController",@"XHQMeViewController"];

    for(NSInteger i = 0;i < arrName.count ;i ++)
    {
        
   
    [_tabBarController addItem:arrName[i] normalImage:[UIImage imageNamed:arrNameNImage[i]] highLightImage:[UIImage imageNamed:arrNameSImage[i]] controller:arr[i]];
    
    }
    
    
    //设置标签栏的viewControllers数组
    _tabBarController.viewControllers = _tabBarController.controllers;
    
    //设置window的rootviewcontroller
    self.window.rootViewController = _tabBarController;
    
   }

- (void)initAppearence
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor blueColor]];
    
    [bar setBarStyle:UIBarStyleBlack];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setTranslucent:NO];
}

- (void)UmentInit
{
    [UMSocialData  setAppKey:UMENGAPPKEY];
    [UMSocialWechatHandler setWXAppId:@"wxe6b5b748cdcff60f" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:@"www.umeng.com/social"];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession]];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    NSLog(@"💐%@",url);
    if(result == FALSE)
    {
        //调用其他SDK,例如支付宝等
    }
    return  result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
