//
//  BaseNaviController.m
//  DouYU
//
//  Created by Alesary on 15/10/29.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "BaseNaviController.h"
#import "Public.h"

@interface BaseNaviController ()

@end

@implementation BaseNaviController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.barTintColor=TabBar_T_Color;
    self.navigationBar.tintColor=[UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
