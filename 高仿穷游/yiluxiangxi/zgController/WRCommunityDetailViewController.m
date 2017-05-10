//
//  WRCommunityDetailViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityDetailViewController.h"
#import "AppDelegate.h"
#import "RequestModel.h"
#import "UIImageView+WebCache.h"
#import "Path.h"
#import "zgSCNavTabBarController.h"
#import "WRCommunityZuiXinViewController.h"
#import "WRCommunityGongLueViewController.h"
#import "WRCommunityJieBanViewController.h"
#import "WRCommunityHuiDaViewController.h"
#import "WRCommunityZhuanRangViewController.h"

@interface WRCommunityDetailViewController ()

@end

@implementation WRCommunityDetailViewController
//社区模块
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self createUI];
}
-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:[delegate createFrimeWithX:0 andY:24 andWidth:375 andHeight:44 ]];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2015-11-06 下午2.30.58.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:navigationBar];
    
    UILabel *label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:64 andY:0 andWidth:300 andHeight:44]];
    label.text=self.name;
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentLeft;
    [navigationBar addSubview:label];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:15 andY:85 andWidth:70 andHeight:70]];
    NSString *imageName=self.path;
    [imageView setImageWithURL:[NSURL URLWithString:imageName]];
    [self.view addSubview:imageView];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:95 andY:90 andWidth:200 andHeight:20]];
    label2.text=[NSString stringWithFormat:@"%@个帖子",self.num];
    label2.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label2];

    WRCommunityZuiXinViewController *zuixin=[[WRCommunityZuiXinViewController alloc]init];
    zuixin.title=@"最新";
    zuixin.zuixinID=self.ID;
    WRCommunityGongLueViewController *gonglue=[[WRCommunityGongLueViewController alloc]init];
    gonglue.title=@"攻略";
    gonglue.gonglueID=self.ID;
    WRCommunityJieBanViewController *jieban=[[WRCommunityJieBanViewController alloc]init];
    jieban.title=@"结伴";
    jieban.jiebanID=self.ID;
    WRCommunityHuiDaViewController *huida=[[WRCommunityHuiDaViewController alloc]init];
    huida.title=@"回答";
    huida.huidaID=self.ID;
    WRCommunityZhuanRangViewController *zhuanrang=[[WRCommunityZhuanRangViewController alloc]init];
    zhuanrang.title=@"转让";
    zhuanrang.zhuanrangID=self.ID;
    zgSCNavTabBarController *tabBar=[[zgSCNavTabBarController alloc]init];
    NSArray *array=@[zuixin,gonglue,jieban,huida,zhuanrang];
    tabBar.subViewControllers=array;
    [tabBar addParentController:self];
    
    

}
-(void)pressBackButton:(id)sender{
    UIButton *button=(UIButton *)sender;
    button.backgroundColor=[UIColor greenColor];
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self.tabBarController popoverPresentationController];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    //self.tabBarController.tabBar.hidden=YES;
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
