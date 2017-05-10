//
//  WRCommunitySheQuSelectView.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/6.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunitySheQuSelectView.h"
#import "AppDelegate.h"


@interface WRCommunitySheQuSelectView ()<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@end

@implementation WRCommunitySheQuSelectView

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
    
    UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:10 andY:5 andWidth:35 andHeight:34]];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_webview_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:button];
    
    NSArray *array=@[@"看楼主",@"",@""];
    for (int i=0; i<3; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:250 andY:10 andWidth:40 andHeight:24]];
        [button setTitle:array[i] forState:UIControlStateNormal];
        
    }

    UIButton * button1 = [[UIButton alloc]initWithFrame:[delegate createFrimeWithX:220 andY:5 andWidth:50 andHeight:34]];
    [button1 setTitle:@"看楼主" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.titleLabel.font=[UIFont systemFontOfSize:13];
    [button1 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:button1];
    button1.tag = 100;
    UIButton * button2 = [[UIButton alloc]initWithFrame:[delegate createFrimeWithX:280 andY:5 andWidth:30 andHeight:34]];
    [button2 setBackgroundImage:[UIImage imageNamed:@"lastMinute_nav_btn_like_highlighted@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:button2];
    button2.tag = 200;
    UIButton * button3 = [[UIButton alloc]initWithFrame:[delegate createFrimeWithX:320 andY:5 andWidth:30 andHeight:34]];
    [button3 setBackgroundImage:[UIImage imageNamed:@"x_nav_btn_share_highlighted@2x.png"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:button3];
    button3.tag = 300;
    
    UITabBar *tab=[[UITabBar alloc]initWithFrame:[delegate createFrimeWithX:0 andY:630 andWidth:375 andHeight:44]];
    [self.view addSubview:tab];
    
    NSArray *array4=@[@"回复楼主",@"相关折扣"];
    for (int i=0; i<2; i++) {
        UIButton *button4=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:189*i andY:0 andWidth:186 andHeight:44]];
        [button4 setTitle:array4[i] forState:UIControlStateNormal];
        button4.titleLabel.textAlignment=NSTextAlignmentCenter;
        button4.titleLabel.font=[UIFont systemFontOfSize:13];
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [tab addSubview:button4];
        button4.tag=400+100*i;
    }
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:186 andY:5 andWidth:3 andHeight:24]];
    imageView.backgroundColor=[UIColor whiteColor];
    [tab addSubview:imageView];
    
    webView=[[UIWebView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:64 andWidth:375 andHeight:550]];
    NSString *path=self.url;
    NSURL *url=[NSURL URLWithString:path];
    webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}
-(void)pressButton:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==100) {
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else if (button.tag==200){
        [button setBackgroundImage:[UIImage imageNamed:@"lastMinute_nav_btn_liked_highlighted@2x.png"] forState:UIControlStateNormal];
    }
    else if(button.tag==300){
    
    }
    else if (button.tag==400){
    
    }
    else{
        
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

-(void)pressBackButton:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
