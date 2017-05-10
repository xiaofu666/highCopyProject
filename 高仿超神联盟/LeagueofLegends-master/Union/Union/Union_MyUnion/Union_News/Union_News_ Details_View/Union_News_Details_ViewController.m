//
//  Union_News_Details_ViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_News_Details_ViewController.h"

#import "PCH.h"

#import "LoadingView.h"

#import "NSString+SensitiveWords.h"

#import "Union_Video_VideoListTableView.h"

#import "VideoPlayerViewController.h"

#import "VideoDetailsModel.h"




@interface Union_News_Details_ViewController ()<UIWebViewDelegate>

@property (nonatomic, retain) NSDictionary *dataDic;

@property (nonatomic, copy) NSString *htmlTitle;

@property (nonatomic, copy) NSString *htmlStr;

@property (nonatomic, retain) UIWebView *webView;

@property (nonatomic , retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic , retain) Union_Video_VideoListTableView *videoListTableView;//视频列表视图

@end

@implementation Union_News_Details_ViewController

-(void)dealloc{
    
    [_dataDic release];
    
    [_htmlTitle release];
    
    [_htmlStr release];
    
    [_webView release];
    
    [_manager release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_videoListTableView release];
       
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    
    self.title = @"资讯";
    

    
    //添加导航栏左按钮
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-sharebutton"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
    
    rightBarButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;

    
    
}


- (void)setUrlString:(NSString *)urlString{
    
    
    if (_urlString != urlString) {
        
        [_urlString release];
        
        _urlString = [urlString retain];
    }
    
    if (urlString != nil) {
        
        //加载数据
        
        [self loadData];
        
    }
    
    
}

-(void)setHtmlStr:(NSString *)htmlStr{
    
    if (_htmlStr != htmlStr) {
        
        [_htmlStr release];
        
        _htmlStr = [htmlStr retain];
        
    }
    
    //清除敏感词汇
    
    _htmlStr = [[_htmlStr removeSensitiveWordsWithArray:@[@"多玩"]] retain];
    
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
    
    [self.manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //解析JSON数据
            
            [Self JSONSerializationWithData:responseObject];
            
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
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.htmlStr = [[dic valueForKey:@"data"] valueForKey:@"content"];
        
        self.htmlTitle = [[dic valueForKey:@"data"] valueForKey:@"title"];
        
        //更新webView
        
        [self.webView loadHTMLString:self.htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
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
        
        //判断类型 根据不同类型 进行不同处理

        NSString *urlString = [request.URL absoluteString];
        
        if (self.type != nil) {
            
            if ([self.type isEqualToString:@"video"]) {
                
                //视频

                [self webViewVideoWithUrl:urlString];
                
                
            } else if ([self.type isEqualToString:@"news"]) {
                
                //信息
                
                //通过浏览器打开
                
                [[UIApplication sharedApplication] openURL:request.URL];
                
                return NO;
                
            }
            
            
        }else {
            
            
            //通过浏览器打开
            
            [[UIApplication sharedApplication] openURL:request.URL];
            
            return NO;
            
            
        }
        
        

        
        return NO;
        
    }
    
}

//通过url字符串 获取视频ID 并判断播放 或 下载操作

-(void)webViewVideoWithUrl:(NSString *)urlString{
    
    //判断是否以指定域名链接开头
    
    if ([urlString hasPrefix:@"http://box.dwstatic.com/unsupport"]) {
        
        NSString *vid = nil;
        
        NSString *type = nil;
        
        //去除域名部分
        
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http://box.dwstatic.com/unsupport" withString:@""];
        
        NSRange range = [urlString rangeOfString:@"?"];
        
        urlString = [urlString substringFromIndex:range.location + range.length];
        
        //分隔字符串 获取参数
        
        NSArray *tempArray = [urlString componentsSeparatedByString:@"&"];
        
        for (NSString *item in tempArray) {
            
            if ([item hasPrefix:@"vid="]) {
                
                vid = [item substringFromIndex:4];
                
            }
            
            if ([item hasPrefix:@"lolboxAction="]) {
                
                type = [item substringFromIndex:13];
                
            }
            
        }
        
        //判断类型
        
        if (vid != nil && type != nil) {
            
            if ([type isEqualToString:@"videoPlay"]) {
                
                //根据vid查询视频详情数据 并跳转视频播放
                
                [self.videoListTableView netWorkingGetVideoDetailsWithVID:vid Title:self.htmlTitle];
                
            } else if ( [type isEqualToString:@"videoDownLoad"]){
                
                //下载视频
                
                
                
            }
            
            
        }
        
        
    }
    
    //http://box.dwstatic.com/unsupport.php?vu=&vid=140561&lolboxAction=videoPlay

    
}




#pragma mark ---rightBarButtonAction

- (void)rightBarButtonAction:(UIBarButtonItem *)sender{
    
    
}


#pragma mark ---LazyLoading

-(Union_Video_VideoListTableView *)videoListTableView{
    
    if (_videoListTableView == nil) {
        
        _videoListTableView = [[Union_Video_VideoListTableView alloc]init];
        
        _videoListTableView.rootVC = self;
        
    }
    
    return _videoListTableView;
}

-(UIWebView *)webView{
    
    if (_webView == nil) {
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        
        //自适应屏幕
        
        _webView.scalesPageToFit = NO;
        
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        
        _webView.delegate = self;
        
        [self.view addSubview:_webView];

        
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
        
        [self.webView bringSubviewToFront:_loadingView];
        
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
        
        _reloadImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
        
        _reloadImageView.image = [[UIImage imageNamed:@"reloadImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _reloadImageView.tintColor = [UIColor lightGrayColor];
        
        _reloadImageView.backgroundColor = [UIColor clearColor];
        
        [_reloadImageView addGestureRecognizer:reloadImageViewTap];
        
        _reloadImageView.hidden = YES;//默认隐藏
        
        _reloadImageView.userInteractionEnabled = YES;
        
        [self.view addSubview:_reloadImageView];
        
        
    }
    
    return _reloadImageView;
    
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
