//
//  DownloadViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "DownloadViewController.h"

#import "TabView.h"

#import "DiskSpaceProgressView.h"

#import "DownloadManager.h"

#import "DataCache.h"

#import "PCH.h"

#import "SettingManager.h"

@interface DownloadViewController ()<UIScrollViewDelegate>

@property (nonatomic ,retain ) UIView *headerView;//顶部视图

@property (nonatomic , retain ) UIButton *backButton;//返回按钮

@property (nonatomic ,retain ) TabView *tabView;//标签导航栏视图

@property (nonatomic , retain ) DiskSpaceProgressView *diskSpaceProgressView;//磁盘空间进度视图

@property (nonatomic , retain ) UIScrollView *scrollView;//滑动视图

@end

@implementation DownloadViewController

-(void)dealloc{
    
    [_headerView release];
    
    [_backButton release];
    
    [_tabView release];
    
    [_diskSpaceProgressView release];
    
    [_scrollView release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"缓存";
    
    //加载顶部视图
    
    [self loadHeaderView];
    
    //添加标签导航栏视图
    
    [self.view addSubview:self.tabView];
    
    //标签导航栏视图回调block实现
    
    __block DownloadViewController *Self = self;
    
    self.tabView.returnIndex = ^(NSInteger selectIndex){
        
        //根据标签导航下标切换不同视图显示
        
        [Self switchViewBySelectIndex:selectIndex];
        
    };
    
    //加载滑动视图
    
    [self loadScrollView];
    
    //加载磁盘空间进度视图
    
    [self loadDiskSpaceProgressView];
    
}

#pragma mark ---视图已经出现

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //加载磁盘空间计算
    
    [self loadDiskSpace];
    
}

#pragma mark ---视图即将出现

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //隐藏下载气泡
    
    [[SettingManager shareSettingManager] downloadViewHiddenOrShow:YES];
    
}

#pragma mark ---视图已经消失

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    //显示下载气泡
    
    [[SettingManager shareSettingManager] downloadViewHiddenOrShow:NO];
    
}


#pragma mark ---加载顶部视图

- (void)loadHeaderView{
    
    //加载顶部视图
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    
    _headerView.backgroundColor = MAINCOLOER;
    
    [self.view addSubview:_headerView];
    
    //初始化返回按钮
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton.backgroundColor = [UIColor clearColor];
    
    _backButton.tintColor = [UIColor whiteColor];
    
    [_backButton setImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    _backButton.frame = CGRectMake(0, 20, 80, 44);
    
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:_backButton];
    
    //初始化标题Label
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 , 20 , CGRectGetWidth(_headerView.frame) - 160 , 44)];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"缓存";
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_headerView addSubview:titleLabel];
    
    [titleLabel release];
    
}


#pragma mark ---返回按钮点击事件

- (void)backButtonAction:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


#pragma mark ---加载磁盘空间进度视图

- (void)loadDiskSpaceProgressView{
    
    //初始化磁盘空间进度视图
    
    _diskSpaceProgressView = [[DiskSpaceProgressView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 20, CGRectGetWidth(self.view.frame), 20)];
    
    _diskSpaceProgressView.progressColor = MAINCOLOER;
    
    _diskSpaceProgressView.trackColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_diskSpaceProgressView];
    
}

#pragma mark ---加载滑动视图

- (void)loadScrollView{
    
    //初始化滑动视图
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , 104 , CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame) - 104)];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 2 , CGRectGetHeight(_scrollView.frame));
    
    _scrollView.pagingEnabled=YES;
    
    _scrollView.directionalLockEnabled=YES;
    
    _scrollView.showsHorizontalScrollIndicator=NO;
    
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
}

#pragma mark ---懒加载标签导航栏视图

-(TabView *)tabView{
    
    if (_tabView == nil) {
        
        NSArray * tabArray = @[@"缓存中",@"已缓存"];
        
        _tabView = [[TabView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
        
        _tabView.dataArray = tabArray;
    }
    
    return _tabView;
    
}

#pragma mark ---根据标签导航下标切换不同视图显示

- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    
    //获取选中的下标 并设置内容视图相应的页面显示
    
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) * selectIndex, 0);
    
}

#pragma mark ---加载磁盘空间数据

- (void)loadDiskSpace{
    
    CGFloat freeDiskSpaceFloat = [[DownloadManager freeDiskSpace] floatValue];
    
    CGFloat totalDiskSpaceFloat = [[DownloadManager totalDiskSpace] floatValue];
    
    _diskSpaceProgressView.titleStr = [NSString stringWithFormat:@"已用空间%@/剩余空间%@",[[DataCache shareDataCache] getKBorMBorGBWith: totalDiskSpaceFloat - freeDiskSpaceFloat ] , [[DataCache shareDataCache] getKBorMBorGBWith: freeDiskSpaceFloat ] ];
    
    //设置设备容量占用进度视图 (1.0 - 可用空间 / 总空间大小 )
    
    [_diskSpaceProgressView setProgress: 1.0 - freeDiskSpaceFloat / totalDiskSpaceFloat ];
    
}

#pragma mark ---UIScrollViewDelegate

//滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //设置相应的标签导航视图的选中下标
    
    self.tabView.selectIndex = page;
    
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


#pragma mark ---当前viewcontroller支持哪些转屏方向

-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
    
}

#pragma mark ---设置电池条前景部分样式类型 (白色)

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

@end
