//
//  AppDelegate.m
//  presents
//
//  Created by dapeng on 16/1/6.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "AppDelegate.h"
#import "SAPGuidePageViewController.h"
@interface AppDelegate ()<guidePageDelegate>
@property (nonatomic, strong) UINavigationController *viewNav;
@property (nonatomic, strong) UINavigationController *hotNav;
@property (nonatomic, strong) UINavigationController *mineNav;
@property (nonatomic, strong) UINavigationController *classifyNav;
@property (nonatomic, strong) ViewController *viewCon;
@property (nonatomic, strong) HotViewController *hotVC;
@property (nonatomic, strong) ClassifyViewController *classVC;
@property (nonatomic, strong) MineViewController *mineVC;

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, assign) BOOL sure;
@property (nonatomic, strong) BaseViewController *baseVC;
@property (nonatomic, strong) NSMutableArray *pullArr;
@property (nonatomic, strong) NSMutableArray *scrollIdArr;

@property (nonatomic, copy) NSString *notMess;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
//    礼物说
    self.viewCon = [[ViewController alloc] init];
    self.viewNav = [[UINavigationController alloc] initWithRootViewController:self.viewCon];
    [self setTabBarItem:_viewNav Title:@"送礼攻略" withTitleSize:10 andFoneName:@"Marion-Italic" selectedImage:[UIImage imageNamed:@"presentSelected"] withTitleColor:RGB(255.0, 0, 0, 1.0f) unselectedImage:[UIImage imageNamed:@"presentIcon"] withTitleColor:RGB(108, 108, 108, 1.0f)];
    
//    热门
    self.hotVC = [[HotViewController alloc] init];
    self.hotNav = [[UINavigationController alloc] initWithRootViewController:self.hotVC];
    [self setTabBarItem:_hotNav Title:@"热门礼品" withTitleSize:10 andFoneName:@"HelveticaNeue" selectedImage:[UIImage imageNamed:@"hotSeleceted"] withTitleColor:RGB(255.0, 0, 0, 1.0f) unselectedImage:[UIImage imageNamed:@"hotIcon"] withTitleColor:RGB(108, 108, 108, 1.0f)];
    
//    分类
    self.classVC = [[ClassifyViewController alloc] init];
    self.classifyNav = [[UINavigationController alloc] initWithRootViewController:self.classVC];
    [self setTabBarItem:_classifyNav Title:@"礼品分类" withTitleSize:10 andFoneName:@"Marion-Italic" selectedImage:[UIImage imageNamed:@"classitySelected"] withTitleColor:RGB(255.0, 0, 0, 1.0f) unselectedImage:[UIImage imageNamed:@"classityIcon"] withTitleColor:RGB(108, 108, 108, 1.0f)];
    

    
//    我的
    self.mineVC = [[MineViewController alloc] init];
    self.mineNav = [[UINavigationController alloc] initWithRootViewController:self.mineVC];
    [self setTabBarItem:_mineNav Title:@"我的" withTitleSize:10 andFoneName:@"Marion-Italic" selectedImage:[UIImage imageNamed:@"mineSelected"] withTitleColor:RGB(255.0, 0, 0, 1.0f) unselectedImage:[UIImage imageNamed:@"mineIcon"] withTitleColor:RGB(108, 108, 108, 1.0f)];
    
//    TabBar
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.selectedIndex = 0;
    [self.tabBarController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(10, 5)];
 
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *result = [userDefaults valueForKey:@"userPassGuide"];
    if (![result isEqualToString:@"guidesPage"]) {
        [userDefaults setObject:@"guidesPage" forKey:@"userPassGuide"];
        
        //引导页
        NSArray *cover = @[@"", @"", @"", @"", @""];
        NSArray *bg = @[@"guidespage1", @"guidespage2", @"guidespage3", @"guidespage4", @"guidespage5"];
        SAPGuidePageViewController *guidePageVC = [[SAPGuidePageViewController alloc] initWithCoverImageNames:cover backgroundImageNames:bg];
        _window.rootViewController = guidePageVC;
        guidePageVC.delegate = self;
    }else {
        self.tabBarController.viewControllers = @[_viewNav, _hotNav, _classifyNav,  _mineNav];
        _window.rootViewController = self.tabBarController;
     
    }
    

    return YES;
}

- (void)click {
    self.tabBarController.viewControllers = @[_viewNav, _hotNav, _classifyNav,  _mineNav];
    _window.rootViewController = self.tabBarController;
}

    //重写tabBar设置方法
- (void)setTabBarItem:(UIViewController *)tabbarItem
                Title:(NSString *)title
        withTitleSize:(CGFloat)size
          andFoneName:(NSString *)foneName
        selectedImage:(UIImage *)selectedImage
       withTitleColor:(UIColor *)selectColor
      unselectedImage:(UIImage *)unselectedImage
       withTitleColor:(UIColor *)unselectColor{
    
    //设置图片
    tabbarItem.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
//    NSLog(@"noti:%@",notification);
//    if (notification.userInfo != nil) {
//        
//        
//        // 这里真实需要处理交互的地方
//        // 获取通知所带的数据
//        NSString *notMess = [notification.userInfo objectForKey:@"key"];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示！"
//                                                        message:notMess
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//        // 更新显示的徽章个数
//        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
//        badge--;
//        badge = badge >= 0 ? badge : 0;
//        [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //取消徽章
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (notification.userInfo != nil) {
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据


    self.notMess = [notification.userInfo objectForKey:@"key"];

        
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示！"
                                                    message:self.notMess
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
   
    // 在不需要再推送时，可以取消推送
//    [AlarmClockViewController cancelLocalNotificationWithKey:@"key"];


    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        // 获得 UIApplication
    
        UIApplication *app = [UIApplication sharedApplication];
    
        //获取本地推送数组
        
        NSArray *localArray = [app scheduledLocalNotifications];
    
        //声明本地通知对象
    
        UILocalNotification *localNotification;
    
        if (localArray) {
        
            for (UILocalNotification *noti in localArray) {
            
                NSDictionary *dict = noti.userInfo;
                
                if (dict) {
                
                    NSString *inKey = [dict objectForKey:@"key"];
                
                    if ([inKey isEqualToString:inKey]) {
                    
                        if (localNotification){
                        
                            localNotification = nil;
                        
                        }
                    
                        break;
                    
                    }
                
                }
            
            }
        
            //判断是否找到已经存在的相同key的推送
        
            if (!localNotification) {
            
                //不存在初始化
            
                localNotification = [[UILocalNotification alloc] init];
            
            }
        
            if (localNotification) {
            
                //不推送 取消推送
            
//                [app cancelLocalNotification:localNotification];
            
                return;
            
            }
        

    SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    NSArray *array = [store getAllItemsFromTable:@"alarmClock"];
//    NSLog(@"%@", array);
    
    // 遍历数组, 查找对应ID
    for (SAKeyValueItem *item in array) {
//        NSLog(@"%@", item.itemId);
        if ([self.notMess hasPrefix:item.itemId]) {
            [store deleteObjectById:item.itemId fromTable:@"alarmClock"];

        }
    }
}

    }}



@end
