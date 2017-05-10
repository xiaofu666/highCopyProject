//
//  SmartbiAdaNavigationController.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaNavigationController.h"

@interface SmartbiAdaNavigationController ()

@end

@implementation SmartbiAdaNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationBar setBackgroundColor:[UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0]];
    
   
    
    // 标题的样式
    UIColor *titleColor = [UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
    UIFont *titleFont = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName: titleFont, NSForegroundColorAttributeName: titleColor}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
