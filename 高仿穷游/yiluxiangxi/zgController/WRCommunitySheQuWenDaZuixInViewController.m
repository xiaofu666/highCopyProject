//
//  WRCommunitySheQuWenDaZuixInViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/6.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunitySheQuWenDaZuixInViewController.h"
#import "AppDelegate.h"

@interface WRCommunitySheQuWenDaZuixInViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator ;
}
@end

@implementation WRCommunitySheQuWenDaZuixInViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
}
-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    UINavigationBar *navigation=[[UINavigationBar alloc]initWithFrame:[delegate createFrimeWithX:0 andY:22 andWidth:375 andHeight:44]];
    [navigation setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2015-11-06 下午2.30.58.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:navigation];
    
    UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:10 andY:5 andWidth:35 andHeight:34]];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_webview_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=100;
    [navigation addSubview:button];
    
    UILabel *label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:60 andY:5 andWidth:100 andHeight:34 ]];
    label.text=@"问答详情";
    label.textColor=[UIColor whiteColor];
    [navigation addSubview:label];
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:[delegate createFrimeWithX:310 andY:5 andWidth:40 andHeight:34]];
    [button1 setBackgroundImage:[UIImage imageNamed:@"x_nav_btn_share_highlighted@2x.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag=200;
    [navigation addSubview:button1];
    
    UITabBar *tab=[[UITabBar alloc]initWithFrame:[delegate createFrimeWithX:0 andY:630 andWidth:375 andHeight:44]];
    [self.view addSubview:tab];
    
    NSArray *array4=@[@"添加同问",@"添加回答"];
    for (int i=0; i<2; i++) {
        UIButton *button2=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:189*i andY:0 andWidth:186 andHeight:44]];
        [button2 setTitle:array4[i] forState:UIControlStateNormal];
        button2.titleLabel.textAlignment=NSTextAlignmentCenter;
        button2.titleLabel.font=[UIFont systemFontOfSize:13];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tab addSubview:button2];
        button2.tag=300+100*i;
    }
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:186 andY:5 andWidth:3 andHeight:24]];
    imageView.backgroundColor=[UIColor whiteColor];
    [tab addSubview:imageView];
    
    webView=[[UIWebView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:64 andWidth:375 andHeight:550]];
    NSString *path=self.zuixinpath;
    NSURL *url=[NSURL URLWithString:path];
    webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:webView];
    
        
}
-(void)pressButton:(id)sender{
    UIButton *button=(UIButton*)sender;
    if (button.tag==100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (button.tag==200){
        
    }
    else if (button.tag==300){
        [button setTitle:@"已同问" forState:UIControlStateNormal];
        button.backgroundColor=[UIColor redColor];
    }
    else {
        
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    activityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:[delegate createFrimeWithX:170 andY:230 andWidth:40 andHeight:40]];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
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
