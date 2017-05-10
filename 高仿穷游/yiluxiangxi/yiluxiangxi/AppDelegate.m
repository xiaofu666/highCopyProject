//
//  AppDelegate.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "AppDelegate.h"
#import "WRRecommendViewController.h"
#import "WRCommunityViewController.h"
#import "WRDestinationViewController.h"
#import "WRMineViewController.h"
#import "XXYNavigationController.h"
#define WIDTH (float)(self.window.frame.size.width)
#define HEIGHT (float)(self.window.frame.size.height)

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)creatTabBarNavs{
    WRRecommendViewController* recommend=[[WRRecommendViewController alloc]init];
    XXYNavigationController* nav1=[[XXYNavigationController alloc]initWithRootViewController:recommend];
    WRDestinationViewController* destinaion=[[WRDestinationViewController alloc]init];
    XXYNavigationController* nav2=[[XXYNavigationController alloc]initWithRootViewController:destinaion];
    WRCommunityViewController* commnity=[[WRCommunityViewController alloc]init];
    XXYNavigationController* nav3=[[XXYNavigationController alloc]initWithRootViewController:commnity];
    WRMineViewController* mine=[[WRMineViewController alloc]init];
    XXYNavigationController* nav4=[[XXYNavigationController alloc]initWithRootViewController:mine];
    NSArray* controllers=@[nav1,nav2,nav3,nav4];
    UITabBarController* tab=[[UITabBarController alloc]init];
    tab.viewControllers=controllers;
    self.window.rootViewController=tab;
    
    NSArray* imageArr=@[@"tabbar_reduceprice@2x.png",@"tabbar_appfree@2x.png",@"tabbar_subject@2x.png",@"tabbar_account@2x.png"];
    NSArray* selectArr=@[@"tabbar_reduceprice_press@2x.png",@"tabbar_appfree_press.png",@"tabbar_subject_press@2x.png",@"tabbar_account_press@2x.png"];
    
    nav1.tabBarItem.image=[UIImage imageNamed:imageArr[0]];
    UIImage* image1 = [UIImage imageNamed:selectArr[0]];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage=image1;
    nav1.tabBarItem.title=@"推荐";
    
    nav2.tabBarItem.image=[UIImage imageNamed:imageArr[1]];
    UIImage* image2 = [UIImage imageNamed:selectArr[1]];
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.selectedImage=image2;
    nav2.tabBarItem.title=@"目的地";

    nav3.tabBarItem.image=[UIImage imageNamed:imageArr[2]];
    UIImage* image3 = [UIImage imageNamed:selectArr[2]];
    image3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage=image3;
    nav3.tabBarItem.title=@"社区";

    nav4.tabBarItem.image=[UIImage imageNamed:imageArr[3]];
    UIImage* image4 = [UIImage imageNamed:selectArr[3]];
    image4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem.selectedImage=image4;
    nav4.tabBarItem.title=@"我们";
    
}

-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    return CGRectMake(x*(WIDTH/375.0), y*(HEIGHT/667.0), width*(WIDTH/375.0), height*(HEIGHT/667));
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self creatTabBarNavs];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
