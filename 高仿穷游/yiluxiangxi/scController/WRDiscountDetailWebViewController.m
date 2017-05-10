//
//  WRDiscountDetailWebViewController.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRDiscountDetailWebViewController.h"
#import "Path.h"
#import "AppDelegate.h"

#define WIDTH (float)(self.view.frame.size.width)
#define HEIGHT (float)(self.view.frame.size.height)
@interface WRDiscountDetailWebViewController ()<UIWebViewDelegate>
{
    UIWebView* _webView;
    UIActivityIndicatorView* _activityIndicator;
}
@end

@implementation WRDiscountDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBar];
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;

    _webView = [[UIWebView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:44 andWidth:375 andHeight:667]];
    _webView.delegate = self;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:DISCOUNTDETAILWEB,self.WebID,a]]];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
    
}
//导航栏的设置
-(void)createNavBar{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = [delegate createFrimeWithX:0 andY:0 andWidth:50 andHeight:50];
    [leftButton setImage:[UIImage imageNamed:@"btn_webview_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(pressLeftItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}
-(void)pressLeftItem{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    UIView* view1 = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:667]];
    view1.tag = 100;
    view1.alpha = 0.5;
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:32 andHeight:32]];
    _activityIndicator.center = self.view.center;
    _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [view1 addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicator stopAnimating];
    UIView* view = (UIView*)[self.view viewWithTag:100];
    [view removeFromSuperview];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_activityIndicator stopAnimating];
    UIView* view = (UIView*)[self.view viewWithTag:100];
    [view removeFromSuperview];
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
