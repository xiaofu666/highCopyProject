//
//  Union_NewsViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/6/30.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_NewsViewController.h"

#import "TabView.h"

#import "Union_News_PrettyPictures_View.h"

#import "Union_News_Pictures_Scroll_ViewController.h"

#import "Union_News_TableView_View.h"

#import "Union_News_Details_ViewController.h"

#import "Union_News_Topic_ViewController.h"


#import "PCH.h"

@interface Union_NewsViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain) TabView *tabView; //标签导航栏视图

@property (nonatomic, retain) UIScrollView *scrollView; //滑动视图控制器

@property (nonatomic, retain) Union_News_TableView_View *newsTopTableView;//头条

@property (nonatomic, retain) Union_News_TableView_View *newsVideoTableView;//视频

@property (nonatomic, retain) Union_News_TableView_View *newsEventTableView;//赛事



@property (nonatomic, retain) Union_News_PrettyPictures_View *prettyCharmingPicturesView;//靓照

@property (nonatomic, retain) Union_News_PrettyPictures_View *prettyEmbarrassedPicturesView;//囧图

@property (nonatomic, retain) Union_News_PrettyPictures_View *prettyWallpaperPicturesView;//壁纸


@end

@implementation Union_NewsViewController

-(void)dealloc{
    
    [_tabView release];
    
    [_scrollView release];
    
    [_newsTopTableView release];
    
    [_newsVideoTableView release];
    
    [_newsEventTableView release];
    
    [_prettyCharmingPicturesView release];
    
    [_prettyEmbarrassedPicturesView release];
    
    [_prettyWallpaperPicturesView release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载所有视图
    
    [self loadAllView];
    
    //添加标签导航栏视图
    
    [self.view addSubview:self.tabView];
    
    //标签导航栏视图回调block实现
    
    __block Union_NewsViewController *Self = self;
    
    _tabView.returnIndex = ^(NSInteger selectIndex){
        
        //根据标签导航下标切换不同视图显示
    
        [Self switchViewBySelectIndex:selectIndex];
        
    };

    //设置默认标签页
    
    _tabView.selectIndex = 0;
    
 }

#pragma mark ---懒加载标签导航栏视图

-(TabView *)tabView{
    
    if (_tabView == nil) {
        
        NSArray * tabArray = @[@"头条",@"视频",@"赛事",@"靓照",@"囧图",@"壁纸"];
        
        _tabView = [[TabView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        
        _tabView.dataArray = tabArray;
    }
    
    return _tabView;
    
}

#pragma mark ---根据标签导航下标切换不同视图显示

- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    
    //获取选中的下标 并设置内容视图相应的页面显示
    
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) * selectIndex, 0);
    
}


#pragma mark ----加载所有视图

- (void)loadAllView{
    
    //初始化滑动视图
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , 40 , CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame) - 153)];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 6 , CGRectGetHeight(_scrollView.frame));
    
    _scrollView.pagingEnabled=YES;
    
    _scrollView.directionalLockEnabled=YES;
    
    _scrollView.showsHorizontalScrollIndicator=NO;
    
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    

    //加载资讯表视图
    
    [self loadNewsTabelViews];
    
    //加载图片视图
    
    [self loadPicturesViews];
   
}

#pragma mark ---加载资讯表视图

- (void)loadNewsTabelViews{
    
    __block typeof (self) Self = self;
    
    __block Union_News_Details_ViewController *details = [[Union_News_Details_ViewController alloc]init];
    
    __block Union_News_Topic_ViewController *topic = [[Union_News_Topic_ViewController alloc]init];

    
    //头条资讯表视图
    
    _newsTopTableView = [[Union_News_TableView_View alloc]initWithFrame:CGRectMake(0 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    _newsTopTableView.scrollPage = 0;
    
    //设置URL
    
    _newsTopTableView.urlstring = [NSString stringWithFormat:kNews_ListURL,@"headlineNews",@"%ld"];
    
    //跳转详情页面
    
    _newsTopTableView.detailsBlock = ^(NSString *string , NSString *type){
        
        details.urlString = [NSString stringWithFormat:@"%@%@",News_WebViewURl,string];
        
        details.type = type;
        
        [Self.navigationController pushViewController:details animated:YES];
        
    };
    
    [_scrollView addSubview: _newsTopTableView];
    
    //跳转专题视图
    
    _newsTopTableView.topicBlock = ^(NSString *string , NSString *type){
        
        topic.urlString = [NSString stringWithFormat:@"%@",string];
        
        [Self.navigationController pushViewController:topic animated:YES];
        
    };
    
    
    //视频资讯表视图
    
    _newsVideoTableView = [[Union_News_TableView_View alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame)  , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    _newsVideoTableView.scrollPage = 1;
    
    //设置URL
    
    _newsVideoTableView.urlstring = [NSString stringWithFormat:kNews_ListURL, @"newsVideo" ,@"%ld"];
    
    //跳转详情页面
    
    _newsVideoTableView.detailsBlock = ^(NSString *string , NSString *type){
        
        details.urlString = [NSString stringWithFormat:@"%@%@",News_WebViewURl,string];
        
        details.type = type;
        
        [Self.navigationController pushViewController:details animated:YES];
        
    };
    
    [_scrollView addSubview: _newsVideoTableView];
    
    //跳转专题视图
    
    _newsVideoTableView.topicBlock = ^(NSString *string , NSString *type){
        
        topic.urlString = [NSString stringWithFormat:@"%@",string];
        
        [Self.navigationController pushViewController:topic animated:YES];
        
    };
    

    //赛事资讯表视图
    
    _newsEventTableView = [[Union_News_TableView_View alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * 2 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    _newsEventTableView.scrollPage = 2;
    
    //设置URL
    
    _newsEventTableView.urlstring = [NSString stringWithFormat:kNews_ListURL, @"upgradenews" ,@"%ld"];
    
    //跳转详情页面
    
    _newsEventTableView.detailsBlock = ^(NSString *string , NSString *type){
        
        details.urlString = [NSString stringWithFormat:@"%@%@",News_WebViewURl,string];
        
        details.type = type;
        
        [Self.navigationController pushViewController:details animated:YES];
        
    };
    
    [_scrollView addSubview: _newsEventTableView];
    
    //跳转专题视图
    
    _newsEventTableView.topicBlock = ^(NSString *string , NSString *type){
        
        topic.urlString = [NSString stringWithFormat:@"%@",string];
        
        [Self.navigationController pushViewController:topic animated:YES];
        
    };

    
    
    //隐藏tabBar
    
    details.hidesBottomBarWhenPushed = YES;
    
    topic.hidesBottomBarWhenPushed = YES;
    
}

#pragma mark ---加载图片视图

- (void)loadPicturesViews{
    
    __block typeof (self) Self = self;
    
    __block Union_News_Pictures_Scroll_ViewController *pictures = [[Union_News_Pictures_Scroll_ViewController alloc]init];

    
    //创建靓照图片视图
    
    _prettyCharmingPicturesView = [[Union_News_PrettyPictures_View alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * 3 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    //设置URL
    
    _prettyCharmingPicturesView.urlString = [NSString stringWithFormat:News_PrettyPicturesURL, @"beautifulWoman" ,@"%ld"];
    
    _prettyCharmingPicturesView.prettyPicturesBlock = ^(NSString *string){
        
        pictures.pictruesString = [NSString stringWithFormat:@"%@%@",News_PicturesURL,string];
        
        
        [Self presentViewController:pictures animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_prettyCharmingPicturesView];

    
    //创建囧图图片视图
    
    _prettyEmbarrassedPicturesView = [[Union_News_PrettyPictures_View alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * 4 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    //设置URL
    
    _prettyEmbarrassedPicturesView.urlString = [NSString stringWithFormat:News_PrettyPicturesURL, @"jiongTu" ,@"%ld"];
    
    _prettyEmbarrassedPicturesView.prettyPicturesBlock = ^(NSString *string){
        
        pictures.pictruesString = [NSString stringWithFormat:@"%@%@",News_PicturesURL,string];
        
        
        [Self presentViewController:pictures animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_prettyEmbarrassedPicturesView];
    
    
    //创建壁纸图片视图
    
    _prettyWallpaperPicturesView = [[Union_News_PrettyPictures_View alloc]initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * 5 , 0 , CGRectGetWidth(_scrollView.frame) , CGRectGetHeight(_scrollView.frame))];
    
    //设置URL
    
    _prettyWallpaperPicturesView.urlString = [NSString stringWithFormat:News_PrettyPicturesURL, @"wallpaper" ,@"%ld"];
    
    _prettyWallpaperPicturesView.prettyPicturesBlock = ^(NSString *string){
        
        pictures.pictruesString = [NSString stringWithFormat:@"%@%@",News_PicturesURL,string];
        
        
        [Self presentViewController:pictures animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_prettyWallpaperPicturesView];
    
    
    
    //隐藏tabBar
    
    pictures.hidesBottomBarWhenPushed = YES;
    
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
    
    //清空内存中的图片缓存
    
    [[SDImageCache sharedImageCache] clearMemory];
    
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
