//
//  AppDelegate.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/6/29.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AppDelegate.h"

#import "CoreStatus.h"

#import "PCH.h"


#import "DownloadViewController.h"

#import "Union_NewsViewController.h"

#import "Union_VideoViewController.h"

#import "Union_EncyViewController.h"

#import "Union_MyUnionViewController.h"

#import "VideoPlayerViewController.h"

#import "BaseTabBarController.h"


#import <CBZSplashView.h>

#import <MobClick.h>

#import <UMFeedback.h>


@interface AppDelegate ()<CoreStatusProtocol>

@property (nonatomic ,retain) DownloadViewController *downloadVC;//下载视图控制器

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //window
    
    self.window = [[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]] autorelease];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self loadRootView];

    [self loadDownloadView];
    
    [self loadstartImage];
    
    
    
    
    //友盟Appkey 55d4404ae0f55a066500096e
    
    //统计SDK集成
    
    [MobClick startWithAppkey:@"55d4404ae0f55a066500096e" reportPolicy:BATCH   channelId:@""];
    
    //version标识
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [MobClick setAppVersion:version];
    
    //反馈SDK集成
    
    [UMFeedback setAppkey:@"55d4404ae0f55a066500096e"];
    
    //获取在线参数
    
    [MobClick updateOnlineConfig];
    
    
    return YES;
    
}

//加载主视图

- (void)loadRootView{

    //联盟资讯
    
    Union_NewsViewController *UNVC = [[Union_NewsViewController alloc]init];
    
    UINavigationController *newsNC = [[UINavigationController alloc]initWithRootViewController:UNVC];
    
    //设置视图控制器
    
    UNVC.title = @"资讯";
    
    
    //设置导航控制器
    
    newsNC.tabBarItem.title = @"联盟资讯";
    
    newsNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-news"];
    
    newsNC.navigationBar.translucent = NO;//不透明
    
    newsNC.navigationBar.barTintColor = MAINCOLOER;
    
    newsNC.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
    
    //---------------------------------------------
    
    //视频直播
    
    Union_VideoViewController *UVVC = [[Union_VideoViewController alloc]init];
    
    UINavigationController *videoNC = [[UINavigationController alloc]initWithRootViewController:UVVC];
    
    //设置视图控制器
    
    UVVC.title = @"视频";
    
    //设置导航控制器
    
    videoNC.tabBarItem.title = @"视频直播";
    
    videoNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-shipin"];
    
    videoNC.navigationBar.translucent = NO;//不透明
    
    videoNC.navigationBar.barTintColor = MAINCOLOER;
    
    videoNC.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
    
    //---------------------------------------------

    
    
    
    //联盟百科
    
    Union_EncyViewController *UEVC = [[Union_EncyViewController alloc]init];
    
    UINavigationController *encyNC = [[UINavigationController alloc]initWithRootViewController:UEVC];
    
    
    //设置视图控制器
    
    UEVC.title = @"百科";
    
    
    //设置导航控制器
    
    encyNC.tabBarItem.title = @"联盟百科";
    
    encyNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-ency"];
    
    encyNC.navigationBar.translucent = NO;//不透明
    
    encyNC.navigationBar.barTintColor = MAINCOLOER;
    
    encyNC.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
    //---------------------------------------------

    
    
    
    //我的联盟
    
    Union_MyUnionViewController *UMUVC = [[Union_MyUnionViewController alloc]init];
    
    UINavigationController *myunionNC = [[UINavigationController alloc]initWithRootViewController:UMUVC];
    
    
    //设置视图控制器
    
    UMUVC.title = @"我";
    
    
    //设置导航控制器
    
    myunionNC.tabBarItem.title = @"我的";
    
    myunionNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-myself"];
    
    myunionNC.navigationBar.translucent = NO;//不透明
    
    myunionNC.navigationBar.barTintColor = MAINCOLOER;
    
    myunionNC.navigationBar.barStyle=UIBarStyleBlackOpaque;//
    
    //---------------------------------------------

    
    
    
    
    //UITabBarController
    
    BaseTabBarController *tabBarController = [[BaseTabBarController alloc]init];
    
    tabBarController.tabBar.translucent = NO;//不透明
    
    tabBarController.viewControllers = @[newsNC , videoNC , encyNC , myunionNC];
    
    tabBarController.tabBar.tintColor = MAINCOLOER;
    
    self.window.rootViewController = tabBarController;
    
    
    
    //-------------------释放--------------------------
    
    [UNVC release];
    
    [newsNC release];
    
    [UVVC release];
    
    [videoNC release];
    
    [UEVC release];
    
    [encyNC release];
    
    [UMUVC release];
    
    [myunionNC release];
    
    [tabBarController release];
    
    
    
    
    
}

//加载启动图片

- (void)loadstartImage{
    
    //启动图片动画
    
    UIImage *icon = [UIImage imageNamed:@"startImage"];
    
    UIColor *color = MAINCOLOER;
    
    CBZSplashView *splashView = [CBZSplashView splashViewWithIcon:icon backgroundColor:color];
    
    splashView.animationDuration = 1.4f;
    
    splashView.iconColor = [UIColor whiteColor];
    
    [self.window addSubview:splashView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [splashView startAnimation];//延迟0.5秒开启动画
        
    });
    
}

//加载下载气泡视图

- (void)loadDownloadView{
    
    _downloadView = [[DownloadView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.window.frame) - 80 , self.window.frame.size.height - 190, 60, 60)];
    
    _downloadView.backgroundColor = [UIColor clearColor];
    
    [self.window addSubview:_downloadView];
    
    [self.window bringSubviewToFront:_downloadView];
    
    //获取在线参数判断是否显示下载
    
    BOOL isShowDownLoad = [[MobClick getConfigParams:@"isShowDownLoad"] boolValue];
    
    if (isShowDownLoad) {
        
        //允许显示下载气泡
        
        //获取本地设置 是否隐藏下载气泡
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        BOOL isHiddenDownloadView = NO;
        
        if ([defaults objectForKey:@"settingDownloadviewHiddenOrShow"] != nil) {
            
            isHiddenDownloadView = [[defaults objectForKey:@"settingDownloadviewHiddenOrShow"] boolValue];
        }
        
        if (isHiddenDownloadView) {
            
            self.downloadView.hidden = YES;
            
        } else {
            
            self.downloadView.hidden = NO;
            
        }
        
        
    } else {
        
        //隐藏下载气泡
        
        self.downloadView.hidden = YES;
        
    }

}


-(void)dealloc {
    
    [_window release];
    
    [_downloadView release];
    
    [_downloadVC release];
    
    [super dealloc];
    
}

//禁止横屏

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//        
//    return UIInterfaceOrientationMaskPortrait;
//    
//}


#pragma mark ---监控网络状态


//当网络改变时

-(void)coreNetworkChangeNoti:(NSNotification *)noti{
    
    NSString *stateString = nil;
    
    //获取当前网络状态
    
    CoreNetWorkStatus currentStatus = [CoreStatus currentNetWorkStatus];
    
    switch (currentStatus) {
            
        case CoreNetWorkStatusNone:
            
            stateString = @"无网络";
            
            break;
            
        case CoreNetWorkStatusWifi:
            
            stateString = @"Wifi网络";
            
            break;
            
        case CoreNetWorkStatusWWAN:
            
            stateString = @"蜂窝网络";
            
            break;
            
        case CoreNetWorkStatus2G:
            
            stateString = @"2G网络";
            
            break;
            
        case CoreNetWorkStatus3G:
            
            stateString = @"3G网络";
            
            break;
            
        case CoreNetWorkStatus4G:
            
            stateString = @"4G网络";
            
            break;
            
        case CoreNetWorkStatusUnkhow:
            
            stateString = @"未知网络";
            
            break;
            
        default:
            
            stateString = @"未知网络";
            
            break;
            
    }
    
    [UIView addLXNotifierWithText:[NSString stringWithFormat:@"您正处于%@状态",stateString] dismissAutomatically:YES];
    
}


#pragma mark ---打开下载视图控制器

- (void)openDownloadVC{
    
    [self.window.rootViewController presentViewController:self.downloadVC animated:YES completion:^{
        
    }];
    
}


#pragma mark ---AppDelegate

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //应用程序将要入非活动状态
    
    //移除网络状态监听
    
    [CoreStatus endNotiNetwork:self];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //程序被推送到后台
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //程序从后台将要重新回到前台
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //应用程序入活动状态
    
    //监听网络状态
    
    [CoreStatus beginNotiNetwork:self];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //应用程序即将终止时
    
    

}


#pragma  mark ----LazyLoading

-(DownloadViewController *)downloadVC{
    
    if (_downloadVC == nil) {
        
        _downloadVC = [[DownloadViewController alloc]init];
        
    }
    
    return _downloadVC;
    
}

@end
