//
//  SleeveViewController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SleeveViewController.h"
#import "NewViewController1.h"
#import "AsianViewController2.h"
#import "EuropeViewController3.h"
#import "NorthAmericaViewController4.h"
#import "SouthAmericaViewController5.h"
#import "OceaniaViewController6.h"
#import "AfricaViewController7.h"
#import "SpecialViewController8.h"
#import "ChinaViewController9.h"
#import "SCNavTabBarController.h"
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)
@interface SleeveViewController ()

@end

@implementation SleeveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    NewViewController1* new1=[[NewViewController1 alloc]init];
    new1.title=@"最新";
    AsianViewController2* asian2=[[AsianViewController2 alloc]init];
    asian2.title=@"亚洲";
    EuropeViewController3* europ3=[[EuropeViewController3 alloc]init];
    europ3.title=@"欧洲";
    NorthAmericaViewController4* north4=[[NorthAmericaViewController4 alloc]init];
    north4.title=@"北美洲";
    SouthAmericaViewController5* south5=[[SouthAmericaViewController5 alloc]init];
    south5.title=@"南美洲";
    OceaniaViewController6* ocean6=[[OceaniaViewController6 alloc]init];
    ocean6.title=@"大洋洲";
    AfricaViewController7* afric7=[[AfricaViewController7 alloc]init];
    afric7.title=@"非洲";
    SpecialViewController8* special8=[[SpecialViewController8 alloc]init];
    special8.title=@"专题锦囊";
    ChinaViewController9* china9=[[ChinaViewController9 alloc]init];
    china9.title=@"中国内地";
    SCNavTabBarController* SCNavTabBar=[[SCNavTabBarController alloc]init];
    SCNavTabBar.subViewControllers=@[new1,asian2,europ3,north4,south5,ocean6,afric7,special8,china9];
    [SCNavTabBar addParentController:self];
    
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
