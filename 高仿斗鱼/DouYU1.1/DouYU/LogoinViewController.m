//
//  LogoinViewController.m
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "LogoinViewController.h"

@interface LogoinViewController ()

@end

@implementation LogoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNav];
    
}

-(void)initNav
{
    self.navigationItem.leftBarButtonItem=nil;
    
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"btn_dismiss"] forState:UIControlStateNormal];
    rightbutton.frame=CGRectMake(0, 0, 25, 25);
    [rightbutton addTarget:self action:@selector(CloseVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    self.title=@"登陆";
    self.navigationItem.titleView=nil;
}

-(void)CloseVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
