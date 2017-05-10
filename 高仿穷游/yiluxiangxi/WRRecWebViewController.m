//
//  WRRecWebViewController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRRecWebViewController.h"
#import "Path.h"
#import "RequestModel.h"
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)
@interface WRRecWebViewController ()<UIWebViewDelegate,sendRequestInfo>
{
    UIWebView *_webView;
}
@end

@implementation WRRecWebViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    //NSLog(@"%@",self.discountID);
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+48)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    if (self.discountID==nil) {
        NSURL *url = [NSURL URLWithString:self.pathStr];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
    }else{
        RequestModel* request=[[RequestModel alloc]init];
        NSString* pathUrl=[NSString stringWithFormat:DISCOUNTDETAIL1,self.discountID,DISCOUNTDETAIL2];
        request.path=pathUrl;
        request.delegate=self;
        [request startRequestInfo];
    }
}

-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSString* pathStr=message[@"data"][@"app_url"];
    NSURL *url = [NSURL URLWithString:pathStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
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
