//
//  BaseViewController.m
//  DouYU
//
//  Created by Alesary on 15/10/29.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"Image_scan"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 25, 25);
    [leftbutton addTarget:self action:@selector(SaoMiao) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    rightbutton.frame=CGRectMake(0, 0, 25, 25);
    [rightbutton addTarget:self action:@selector(Search) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 104, 28)];
    titleView.image=[UIImage imageNamed:@"logo"];
    self.navigationItem.titleView=titleView;


}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)SaoMiao
{
    NSLog(@"SaoMiao");
}
-(void)Search
{
   NSLog(@"Search");
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
