//
//  SmartbiAdaAppDelegate.h
//  SmartbiAdaConnotationApp
//
//  Created by mac on 16/3/29.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartbiAdaHomeViewController.h"
#import "SmartbiAdaRootViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "SmartbiAdaViewController.h"

@interface SmartbiAdaAppDelegate : UIResponder<UIApplicationDelegate>

@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)SmartbiAdaRootViewController *rootVC;
@end
