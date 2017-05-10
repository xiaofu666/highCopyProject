//
//  Union_News_Topic_ViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_News_Topic_ViewController.h"

#import "TabView.h"

#import "Union_News_TableViewCell.h"

#import "Networking.h"

#import <UIImageView+WebCache.h>

#import "PCH.h"

#import "Union_News_Details_ViewController.h"

#import "GearPowered.h"

#import "LoadingView.h"

#import "NSString+URL.h"

#import "NSString+SensitiveWords.h"

#import "Union_Video_VideoListTableView.h"

#import "VideoPlayerViewController.h"


@interface Union_News_Topic_ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,GearPoweredDelegate>

@property (nonatomic, retain) TabView *tabView;//标签导航栏视图

@property (nonatomic, retain) NSMutableArray *tabArray;//标签数据数组

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UIWebView *liveWebView;

@property (nonatomic, retain) NSMutableDictionary *liveWebUrlDic;//webURL数据字典

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) UIImageView *disImageView;//区头图片

@property (nonatomic, retain) UILabel *titleLabel;//区头标题

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic , retain) GearPowered *gearPowered;//齿轮刷新

@property (nonatomic , retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图


@property (nonatomic , retain) Union_News_Topic_ViewController *topicVC;//专题视图控制器

@property (nonatomic , retain) Union_Video_VideoListTableView *videoListTableView;//视频列表视图

@end

@implementation Union_News_Topic_ViewController

- (void)dealloc{
    
    [_tableView release];
    
    [_tabArray release];
    
    [_liveWebView release];
    
    [_dataArray release];
    
    [_urlString release];
    
    [_titleLabel release];
    
    [_manager release];
    
    [_gearPowered release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_liveWebUrlDic release];
    
    [_videoListTableView release];
    
    [_topicVC release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    //加载视图控件
    
    [self addTableView];

    [self addDistricthead];
    

  }
#pragma mark 重写set方法


- (void)setUrlString:(NSString *)urlString{
    
    if (_urlString != urlString) {
        
        [_urlString release];
        
        _urlString = [urlString retain];
    }
    
    if (urlString != nil) {
        
        //设置表视图样式无cell分隔线
        
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        //加载数据
        
        [self loadArrayData];
        
        self.gearPowered.url = [NSURL URLWithString:[urlString URLEncodedString] ];

    }
    
}

#pragma mark ---- 区头图片

- (void)addDistricthead{
    
    //区头白色底视图
    
    UIView *districthView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.width/3)];
    
    districthView.backgroundColor = [UIColor whiteColor];
    
    
    _disImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.width/3 - 50)];
    
    
    [districthView addSubview:_disImageView];
    
    
    //区头标题
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.frame.size.width/3 - 50, self.view.frame.size.width - 20, 50)];
    
    
    [districthView addSubview:_titleLabel];
    
    _titleLabel.textColor = [UIColor grayColor];
    
    _titleLabel.font = [UIFont systemFontOfSize:15];
    
    _titleLabel.numberOfLines = 0;
    
    [districthView addSubview:_titleLabel];
    
    self.tableView.tableHeaderView = districthView;

    [districthView release];
    
}







#pragma mark ---根据标签导航下标切换不同视图显示

- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    
    //判断选中的标签下标
    
    switch (selectIndex) {
            
        case 0:
            
            [self.view bringSubviewToFront:self.tableView];
            
            break;
            
        default:
            
            [self.view bringSubviewToFront:self.liveWebView];
            
            NSURL *lurl = [NSURL  URLWithString:[self.liveWebUrlDic valueForKey:[NSString stringWithFormat:@"%ld",(long)selectIndex]]];
            
            NSURLRequest *lrequest = [NSURLRequest requestWithURL:lurl];
            
            [self.liveWebView loadRequest:lrequest];
            
            break;
            
    }
    
}
#pragma mark ------添加tableView

- (void)addTableView{

    //创建tableView
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40 - 64 ) style:UITableViewStylePlain];
    
    _tableView.rowHeight = 80;
    
    //代理
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    //注册
    
    [_tableView registerClass:[Union_News_TableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    
    
}

#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadArrayData];
    
}


#pragma mark ----加载数据

//加载数据

- (void)loadArrayData{
    
    //显示加载视图
    
    self.loadingView.hidden = NO;
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;

    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //调用数据解析方法
        
        if (responseObject != nil) {
            
            //解析前清空数据源数组
            
            [Self.dataArray removeAllObjects];
            
            [Self.tabArray removeAllObjects];
            
            [Self.liveWebUrlDic removeAllObjects];
            
            //设置表视图样式有cell分隔线
            
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            
            //解析数据
            
            [Self JSONSerializationWithData:responseObject];
            
            
        } else {
            
            //显示重新加载提示视图
            
            Self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        //显示加载视图
        
        self.loadingView.hidden = NO;
        
        //隐藏重新加载提示视图
        
        self.reloadImageView.hidden = YES;

        
    }];

}



#pragma mark ---数据解析 

- (void)JSONSerializationWithData:(id)data{
    
    NSInteger webIndex = 0;
    
    NSDictionary *dic = data;
    
    NSArray *dataArray = [dic valueForKey:@"data"];
    
    for (NSDictionary *dataItem in dataArray) {
        
        //添加标签导航栏数据数组
        
        [self.tabArray addObject:[[dataItem valueForKey:@"title"] retain]];
        
        NSString *type = [dataItem valueForKey:@"type"];
        
        //专题数据
        
        if ([type isEqualToString:@"topic"]) {
            
            NSDictionary *tempDataDic = [dataItem valueForKey:@"data"];
            
            //给区头加载图片和标题
            
            self.title = [tempDataDic valueForKey:@"title"];
            
            self.titleLabel.text = [[tempDataDic valueForKey:@"content"] removeSensitiveWordsWithArray:@[@"手机盒子"]];
            
            //加载图片
            
            NSURL *murl = [NSURL URLWithString:[tempDataDic valueForKey:@"photo"]];
            
            [self.disImageView sd_setImageWithURL:murl];
            
            NSArray *newsArray = [tempDataDic valueForKey:@"news"];
            
            for (NSDictionary *newsDic in newsArray) {
                
                Union_News_TableView_Model *model = [[Union_News_TableView_Model alloc]init];
                
                [model setValuesForKeysWithDictionary:newsDic];
                
                [self.dataArray addObject:model];
                
            }
            
            
        }
        
        //web网页数据
        
        if ([type isEqualToString:@"web"]) {
            
            //将webURL在数组中的下标作为KEY url作为Value 添加进字典中
            
            [self.liveWebUrlDic setValue:[[dataItem valueForKey:@"url"] retain] forKey:[NSString stringWithFormat:@"%ld",(long)webIndex]];

        }
        
        webIndex ++;
    }
    
    if (self.tabArray != nil) {
        
        //为标签导航栏添加数据数组
        
        self.tabView.dataArray = [NSArray arrayWithArray:self.tabArray];
        
        //通过判断标签导航数组元素个数 判断是否只包含一个表视图
        
        if (self.tabArray.count > 1) {
            
            //显示标签导航栏 设置表视图高度
            
            self.tabView.hidden = NO;
            
            self.tableView.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40 );
            
        } else {
            
            //隐藏标签导航栏 设置表视图高度
            
            self.tabView.hidden = YES;
            
            self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
        }
        
    }
    
    //刷新表视图
    
    [self.tableView reloadData];

    
}


#pragma mark -----tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Union_News_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    //点击状态
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArray[indexPath.row];
    
    
    return cell;
    
    
}

//cell点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Union_News_TableView_Model *model = self.dataArray [indexPath.row];
    
    Union_News_Details_ViewController *details = [[Union_News_Details_ViewController alloc]init];
    
    details.urlString = [NSString stringWithFormat:@"%@%@",News_WebViewURl, model.id];
    
    details.type = model.type;
    
    [self.navigationController pushViewController:details animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //调用齿轮刷新的滑动事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //调用齿轮刷新的拖动结束事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
}


#pragma mark ---UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //判断类型 根据不同类型 进行不同处理
    
    NSString *urlString = [request.URL absoluteString];

    //通过url字符串 判断播放 或 专题
    
    return [self webViewVideoORTopicWithUrl:urlString];
    
}

//通过url字符串 判断播放 或 专题

-(BOOL)webViewVideoORTopicWithUrl:(NSString *)urlString{
    
    //判断是否以指定域名链接开头
    
    if ([urlString hasPrefix:@"http://box.dwstatic.com/unsupport"]) {
        
        NSString *vid = nil;
        
        NSString *topicId = nil;
        
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
            
            if ([item hasPrefix:@"topicId="]) {
                
                topicId = [item substringFromIndex:8];
            
            }
            
            if ([item hasPrefix:@"lolboxAction="]) {
                
                type = [item substringFromIndex:13];
                
            }
            
            
            
        }
        
        //判断类型
        
        if (vid != nil || type != nil || topicId != nil) {
            
            if ([type isEqualToString:@"videoPlay"]) {
                
                //播放视频
                
                //根据vid查询视频详情数据 并跳转视频播放
                
                [self.videoListTableView netWorkingGetVideoDetailsWithVID:vid Title:self.title];
                
            } else if ( [type isEqualToString:@"toNewsTopic"]){
                
                //专题
                
                //拼接专题URL 并跳转
                
                self.topicVC.urlString = [NSString stringWithFormat:News_TopicURL , topicId ];
                
                [self.navigationController pushViewController:self.topicVC animated:YES];
                
            }
            
            
        }
        
        return NO;
        
    } else {
        
        return YES;
        
    }
    
    //http://box.dwstatic.com/unsupport.php?vu=&vid=140561&lolboxAction=videoPlay
    
    
}


#pragma mark ---GearPoweredDelegate

-(void)didLoadData:(id)data{
    
    
    //解析前清空数据原数组
    
    [self.dataArray removeAllObjects];
    
    [self.tabArray removeAllObjects];
    
    [self.liveWebUrlDic removeAllObjects];
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //调用数据解析方法
    
    [self JSONSerializationWithData:data];
    
}





#pragma mark ---leftBarButtonAction

- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark ---LazyLoading

//标签视图

- (TabView *)tabView{
    
    if (_tabView == nil) {
        
        _tabView = [[TabView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        
        //添加标签导航栏视图
        
        [self.view addSubview:_tabView];
        
        //标签导航栏视图回调block实现
        
        __block typeof(self) Self = self;
        
        _tabView.returnIndex = ^(NSInteger selectIndex){
            
            //根据标签导航下标切换不同视图显示
            
            [Self switchViewBySelectIndex:selectIndex];
            
        };
        
    }
    
    return _tabView;
}

-(UIWebView *)liveWebView{
    
    if (_liveWebView == nil) {
        
        _liveWebView = [[UIWebView alloc]initWithFrame:CGRectMake( 0 , 40, self.view.frame.size.width, self.view.frame.size.height - 40)];
        
        //自适应屏幕
        
        _liveWebView.scalesPageToFit = YES;
        
        _liveWebView.dataDetectorTypes = UIDataDetectorTypeAll;
        
        _liveWebView.delegate = self;
        
        [self.view addSubview:_liveWebView];
        
        
    }
    
    return _liveWebView;

    
}

-(Union_Video_VideoListTableView *)videoListTableView{
    
    if (_videoListTableView == nil) {
        
        _videoListTableView = [[Union_Video_VideoListTableView alloc]init];
        
        _videoListTableView.rootVC = self;
        
    }
    
    return _videoListTableView;
}

-(Union_News_Topic_ViewController *)topicVC{
    
    if (_topicVC == nil) {
        
        _topicVC = [[Union_News_Topic_ViewController alloc]init];
        
    }
    
    return _topicVC;
    
}

-(AFHTTPRequestOperationManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [[AFHTTPRequestOperationManager manager] retain];
        
        // 设置超时时间
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer.timeoutInterval = 15.0f;
        
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    
    return _manager;
    
}


-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
}

-(NSMutableArray *)tabArray {
    
    if (_tabArray == nil) {
        
        _tabArray = [[NSMutableArray alloc]init];
        
    }
    
    return _tabArray;
    
}

-(NSMutableDictionary *)liveWebUrlDic{
    
    if (_liveWebUrlDic == nil) {
        
        _liveWebUrlDic = [[NSMutableDictionary alloc]init];
        
    }
    
    return _liveWebUrlDic;
    
}

-(GearPowered *)gearPowered{
    
    if (_gearPowered == nil) {
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self.tableView;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
    }

    return _gearPowered;
}

- (LoadingView *)loadingView{
    
    if (_loadingView == nil) {
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self.view addSubview:_loadingView];
        
    }
    
    return _loadingView;
    
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
