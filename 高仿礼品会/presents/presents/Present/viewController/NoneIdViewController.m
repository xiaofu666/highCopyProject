//
//  NoneIdViewController.m
//  presents
//
//  Created by dapeng on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "NoneIdViewController.h"

@interface NoneIdViewController ()

@end

@implementation NoneIdViewController
#pragma mark -----------轮播图广告详情---------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imageUrl]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    [webView loadRequest:request];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
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
