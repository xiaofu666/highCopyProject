//
//  AppDelegate.m
//  YueduFM
//
//  Created by StarNet on 9/17/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MenuViewController.h"
#import "FavorViewController.h"
#import "GuideViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) RESideMenu* sideMenu;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    application.statusBarHidden = NO;
    
    [self setupAppearance];
    [self setupService];
    
    MainViewController* mvc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    nvc.navigationBar.translucent = NO;
    nvc.navigationBar.barTintColor = kThemeColor;
    nvc.navigationBar.tintColor = [UIColor whiteColor];
    [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    nvc.navigationBar.barStyle = UIBarStyleBlack;
    
    MenuViewController* vc = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.sideMenu = [[RESideMenu alloc] initWithContentViewController:nvc leftMenuViewController:vc rightMenuViewController:nil];
    
    [PlayerBar setContainer:self.sideMenu.view];

    [self showGuideViewIfNeed];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)showGuideView {
    GuideViewController* gvc = [[GuideViewController alloc] initWithNibName:@"GuideViewController" bundle:nil];
    __weak typeof(self) weakSelf = self;
    gvc.guideDidFinished = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.window.rootViewController = weakSelf.sideMenu;
            [weakSelf.window makeKeyAndVisible];
        });
    };
    
    self.window.rootViewController = gvc;
    
}

- (void)showGuideViewIfNeed {
    if (!USER_CONFIG(@"FirstLaunch")) {
        [self showGuideView];
    } else {
        self.window.rootViewController = self.sideMenu;
    }
    USER_SET_CONFIG(@"FirstLaunch", @"");
}

- (void)setupService {
    [__serviceCenter setup];
    
    SRV(DownloadService).taskDidFinished = ^(YDSDKArticleModelEx* model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MessageKit showWithSuccessedMessage:[NSString stringWithFormat:@"%@ %@", model.title, LOC(@"download_done_prompt")]];
        });
    };
}

- (void)setupAppearance {
    [[UIBarButtonItem appearance] setTintColor:kThemeColor];
    UIImage* image = [[UIImage imageNamed:@"icon_nav_back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self becomeFirstResponder];
    [__serviceCenter stopAllServices];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid){
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [__serviceCenter startAllServices];
    [self resignFirstResponder];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler{
    SRV(DownloadService).backgroundTransferCompletionHandler = completionHandler;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void) remoteControlReceivedWithEvent:(UIEvent *)event {
    [SRV(StreamerService) remoteControlReceivedWithEvent:event];
}

@end
