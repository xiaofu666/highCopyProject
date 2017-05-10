

//
//  XHQDaoGoDescViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQDaoGoDescViewController.h"
#import "XHQZUIXINDatabase.h"

#import "UMSocial.h"
#import "UMSocialShakeService.h"
#import "UMSocialScreenShoter.h"


@interface XHQDaoGoDescViewController ()<UIWebViewDelegate>

@property(nonatomic,assign)BOOL b;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation XHQDaoGoDescViewController

- (void)setModel:(XHQZuiXinModel *)model
{
     _model = model;
   
    self.b = NO;
  
    
    [ self BuiltUI];
            
    self.title = @"详情";
    
}
- (void)BuiltUI
{
   
 
    self.btn =  [XHQFactoryUI createButtonWithFrame:CGRectMake(0, 0, 80, 25) title:@"收藏" titleColor:[UIColor whiteColor] imageName:nil backgroundImageName:nil target:self selector:@selector(clickSave)];
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:self.btn];
    
       UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(clickShare)];
    

   
    self.navigationItem.rightBarButtonItems  = @[btn1,shareBtn];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.frame];
    web.delegate = self;
    NSURL *ur = [NSURL URLWithString:_model.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:ur];
    [web loadRequest:request];
    [self.view addSubview:web];

}
- (void)clickShare
{
    //不弹出系统的分享界面，需要自定义分享界面
    NSString *uri = _model.url;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content: uri image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            [XHQAuxiliary alertWithTitle:@"分享操作提醒" message:@"分享成功，快去看看吧!" button:0 done:nil];
        } }];
    
}
//加载完成或失败时，去掉loading效果
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    //    [activityIndicator stopAnimating];
    //    [_webView removeFromSuperview];
    //    NSLog(@"webViewDidFinishLoad");
    //去掉广告
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('affix')[0].style.display = 'NONE';document.getElementsByClassName('affix-top hide')[0].style.display = 'NONE'"];
    
       NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";

    NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
   NSLog(@"data💐💐💐💐💐  ========   %@",HTMLSource);
    
}
- (void)clickSave
{
   self.b = [[XHQZUIXINDatabase sharedManager]modelIsExists:_model];
    
    if (self.b)
    {
        [[XHQZUIXINDatabase sharedManager]deleteRecord:_model];
        [self.btn setTitle: @"收藏" forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]  ;
        [XHQAuxiliary alertWithTitle:@"温馨提示" message:@"取消收藏成功" button:0 done:nil];
        
    }else
    {
        [[XHQZUIXINDatabase sharedManager]addRecord:_model];
        [self.btn setTitle: @"已收藏" forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal]  ;
        [XHQAuxiliary alertWithTitle:@"温馨提示" message:@"收藏成功" button:0 done:nil];
        
    }
   
   

}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com