//
//  SmartbiAdaAppDelegate.m
//  SmartbiAdaConnotationApp
//
//  Created by mac on 16/3/29.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaAppDelegate.h"


@interface SmartbiAdaAppDelegate ()

@end

@implementation SmartbiAdaAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor=[UIColor whiteColor];
    
    self.rootVC=[[SmartbiAdaRootViewController alloc]init];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] boolValue])
    {
        
        self.window.rootViewController=self.rootVC;
        
    }
    else
    {
        self.window.rootViewController = [[SmartbiAdaViewController alloc] init];
    }
   

    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    
    return [TencentOAuth HandleOpenURL:url];
    
}


@end
