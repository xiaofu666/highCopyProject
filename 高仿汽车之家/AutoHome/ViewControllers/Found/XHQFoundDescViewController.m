//
//  XHQFoundDescViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQFoundDescViewController.h"

@interface XHQFoundDescViewController ()

@end

@implementation XHQFoundDescViewController

- (void)setUrl:(NSString *)url
{
    _url = url;
    [self builtUI];
}
- (void)builtUI
{
   
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURL *ur = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:ur];
    [web loadRequest:request];
    [self.view addSubview:web];
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com