//
//  SummonerDetailsViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SummonerDetailsViewController.h"

#import "NSString+URL.h"

#import "PCH.h"

#import "LoadingView.h"

#import "NSString+SensitiveWords.h"

@interface SummonerDetailsViewController ()<UIWebViewDelegate>

@property (nonatomic , retain )UIWebView *webView;

@property (nonatomic, copy ) NSString *htmlStr;

@property (nonatomic , retain ) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain ) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain ) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end

@implementation SummonerDetailsViewController

-(void)dealloc{
    
    [_webView release];
    
    [_summonerName release];
    
    [_serverName release];
    
    [_htmlStr release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_manager release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"召唤师详情";

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)setSummonerName:(NSString *)summonerName{
    
    if (_summonerName != summonerName) {
        
        [_summonerName release];
        
        _summonerName = [summonerName retain];
        
    }
    
}

- (void)setServerName:(NSString *)serverName {
    
    if (_serverName != serverName) {
        
        [_serverName release];
        
        _serverName = [serverName retain];
        
    }
    
}

-(void)setHtmlStr:(NSString *)htmlStr{
    
    if (_htmlStr != htmlStr) {
        
        [_htmlStr release];
        
        _htmlStr = [htmlStr retain];
        
    }
    
    //去除敏感字符串
    
    _htmlStr = [[_htmlStr removeSensitiveWordsWithArray:@[@"欢迎下载多玩LOL手机盒子",@"战绩遗漏？"]] retain];
    

}

#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark ---加载数据

//加载数据

- (void)loadData{
    
    //显示加载视图
    
    self.loadingView.hidden = NO;
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;

    //清空webView内容
    
    [self.webView loadHTMLString:@" " baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[[NSString stringWithFormat:kUnion_MyUnion_URL , _serverName , _summonerName ] URLEncodedString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //转换编码
            
            NSData *resultData = responseObject;
            
            self.htmlStr =  [[[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding] autorelease];
            
            //更新webView
            
            [self.webView loadHTMLString:self.htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

            
        } else {
            
            //显示重新加载提示视图
            
            Self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //显示重新加载提示视图
        
        Self.reloadImageView.hidden = NO;
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    }];
    
}

#pragma mark ---解析数据

- (void)JSONSerializationWithData:(id)data{
    
    if (data != nil) {
        
        
    }
    
}

#pragma mark ---加载WebView

- (void)loadWebView{
    
    //非空判断
    
    if (_summonerName != nil && _serverName != nil) {
        
        //加载数据
        
        [self loadData];
   
    }
    
    
}


#pragma mark ---UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //加载完成
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    if ([request.URL isEqual:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]]) {
        
        return YES;
        
    }else{
        
        return NO;
        
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark ---LazyLoading

-(UIWebView *)webView{
    
    if (_webView == nil) {
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame) - 64)];
        
        _webView.scalesPageToFit = NO;
        
        //代理
        
        _webView.delegate = self;
        
        [self.view addSubview:_webView];
        
        //将加载视图置为最上层
        
        [self.view bringSubviewToFront:_loadingView];
        
    }
 
    return _webView;
    
}

-(LoadingView *)loadingView{
    
    if (_loadingView == nil) {
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        
        _loadingView.loadingColor = MAINCOLOER;
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self.webView addSubview:_loadingView];
        
    }
    
    return _loadingView;

}


-(AFHTTPRequestOperationManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [[AFHTTPRequestOperationManager manager] retain];
        
        // 设置超时时间
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer.timeoutInterval = 15.0f;
        
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    
    return _manager;
    
}

-(UIImageView *)reloadImageView{
    
    if (_reloadImageView == nil) {
        
        //初始化 并添加单击手势
        
        UITapGestureRecognizer *reloadImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadImageViewTapAction:)];
        
        _reloadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        
        _reloadImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2 - 50);
        
        _reloadImageView.image = [UIImage imageNamed:@""];
        
        _reloadImageView.backgroundColor = [UIColor lightGrayColor];
        
        [_reloadImageView addGestureRecognizer:reloadImageViewTap];
        
        _reloadImageView.hidden = YES;//默认隐藏
        
        _reloadImageView.userInteractionEnabled = YES;
        
        [self.view addSubview:_reloadImageView];
        
        
    }
    
    return _reloadImageView;
    
}


#pragma mark ---禁止横屏

-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
    
}

@end
