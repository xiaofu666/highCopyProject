//
//  SmartbiAdaAppDelegate.m
//  SmartbiAdaConnotationApp
//
//  Created by mac on 16/3/29.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaAppDelegate.h"
#import "SmartbiAdaHomeViewController.h"
#import "SmartbiAdaRootViewController.h"

@interface SmartbiAdaAppDelegate ()

@end

@implementation SmartbiAdaAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController=[[SmartbiAdaRootViewController alloc]init];
    
    self.window.backgroundColor=[UIColor whiteColor];
        [self.window makeKeyAndVisible];

    return YES;
}

@end
