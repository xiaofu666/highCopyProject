//
//  SmartbiAdaHomeDetailViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/17.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaHomeDetailViewController.h"
#import "config__api.h"

@interface SmartbiAdaHomeDetailViewController ()<UIWebViewDelegate>

@end

@implementation SmartbiAdaHomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    NSLog(@"%@==%d+%d",self.shareUrl,kScreenWidth,kScreenHeight);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.shareUrl]]];
    webView.delegate=self;
    [self.view addSubview:webView];
}

//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//已经加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
