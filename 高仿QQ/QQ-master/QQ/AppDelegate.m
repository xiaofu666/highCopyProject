//
//  AppDelegate.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "AppDelegate.h"
#import "WSNavigationController.h"
#import "WSRecentMsgTableViewController.h"
#import "WSBuddyListViewController.h"
#import "WSQworldViewController.h"
#import "RESideMenu.h"
#import "WSLeftMenuController.h"
#import "NSObject+CoreDataHelper.h"


@interface AppDelegate ()


@property(nonatomic,strong) UITabBarController *mainTabBar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.window.backgroundColor = [UIColor whiteColor];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:self.mainTabBar leftMenuViewController:[[WSLeftMenuController alloc] init] rightMenuViewController:nil];
    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"leftMenuBk"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1;
    sideMenuViewController.delegate = nil;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    self.window.rootViewController = self.mainTabBar;
    
    [self.window makeKeyAndVisible];
   
    return YES;
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

-(UITabBarController *)mainTabBar
{
    if (_mainTabBar) {
        return _mainTabBar;
    }
    
    _mainTabBar = [[UITabBarController alloc]init];
    
    
    
    WSRecentMsgTableViewController *message = [[WSRecentMsgTableViewController alloc]init];
    
    WSBuddyListViewController *tel = [[WSBuddyListViewController alloc]init];

    WSQworldViewController *dynamic = [[WSQworldViewController alloc]init];
    
    [_mainTabBar setViewControllers:@[[[WSNavigationController alloc]initWithRootViewController:message],[[WSNavigationController alloc]initWithRootViewController:tel],[[WSNavigationController alloc]initWithRootViewController:dynamic]]];
    
    return _mainTabBar;
}






@end
