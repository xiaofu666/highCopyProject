//
//  Union_VideoViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/6/30.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_VideoViewController.h"

#import "PCH.h"

#import "TabView.h"

#import "Union_Video_SortCollectionView.h"

#import "Union_Video_VideoListTableView.h"

#import "VideoListViewController.h"

#import "DownloadViewController.h"

#import "DownloadView.h"

#import "AppDelegate.h"


#import <MobClick.h>

@interface Union_VideoViewController ()

@property (nonatomic , retain)TabView *tabView; //标签导航栏视图

@property (nonatomic , retain) Union_Video_SortCollectionView *sortView;//分类视图

@property (nonatomic , retain) Union_Video_VideoListTableView *newView;//最新视图

@property (nonatomic ,retain) VideoListViewController *videoListVC;//视频列表视图控制器

@end

@implementation Union_VideoViewController

-(void)dealloc{
    
    [_tabView release];
    
    [_newView release];
    
    [_sortView release];
    
    [_videoListVC release];
    
    [super dealloc];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加标签导航栏视图
    
    [self.view addSubview:self.tabView];
    
    //标签导航栏视图回调block实现
    
    __block Union_VideoViewController *Self = self;
    
    self.tabView.returnIndex = ^(NSInteger selectIndex){
        
        //根据标签导航下标切换不同视图显示
    
        [Self switchViewBySelectIndex:selectIndex];
    
    };
    
    //添加分类视图
    
    [self.view addSubview:self.sortView];
    
    //添加最新视图
    
    [self.view addSubview:self.newView];
    
    //默认显示分类视图
    
    self.tabView.selectIndex = 0;
    
    //默认sortView在最上方
    
    [self.view bringSubviewToFront:self.sortView];
    
    
    //获取在线参数判断是否显示下载
    
    BOOL isShowDownLoad = [[MobClick getConfigParams:@"isShowDownLoad"] boolValue];
    
    if (isShowDownLoad) {
        
        //调用navigationButton方法
        
        [self navigationButton];
        
    } else {
        
        //清除右导航按钮
        
        self.navigationItem.rightBarButtonItem = nil;
        
    }
        
}



#pragma mark----导航控制器上的下载按钮

-(void)navigationButton{
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-xiazai"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction:)];
    
    rightButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;

}





#pragma mark ---下载按钮响应事件

-(void)rightButtonAction:(UIBarButtonItem *)sender{
    
    //调用打开下载视图控制器方法
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    [app openDownloadVC];


}


#pragma mark ---懒加载标签导航栏视图
    
-(TabView *)tabView{
    
    if (_tabView == nil) {
        
        NSArray * tabArray = @[@"分类",@"最新"];
        
        _tabView = [[TabView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        
        _tabView.dataArray = tabArray;
    }
    
    return _tabView;
    
}

#pragma mark ---根据标签导航下标切换不同视图显示

- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    
    //判断选中的标签下标 执行相应的切换
    
    switch (selectIndex) {
        case 0:
            
            //分类视图
            
            [self.view bringSubviewToFront:self.sortView];
            
            break;
            
        case 1:
        {
            
            //最新视图
            
            [self.view bringSubviewToFront:self.newView];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
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

//分类

-(Union_Video_SortCollectionView *)sortView{
    
    if (_sortView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        //设置单元格大小
        
        flowLayout.itemSize = CGSizeMake( ( CGRectGetWidth(self.view.frame) - 50 ) /4 , ( CGRectGetWidth(self.view.frame) - 50 ) /4 + 20);
        
        //设置最小左右间距 ，单元格之间
        
        flowLayout.minimumInteritemSpacing = 10;
        
        //设置最小上下间距
        
        flowLayout.minimumLineSpacing = 10;
        
        //设置滑动方向
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //设置cell的边界范围
        
        flowLayout.sectionInset = UIEdgeInsetsMake(10 , 10 , 10 , 10 );
        
        _sortView = [[Union_Video_SortCollectionView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40 - 113) collectionViewLayout:flowLayout];
        
        [flowLayout release];
        
        __block Union_VideoViewController *Self = self;
        
        _sortView.block = ^(NSString *tag , NSString *name){
            
            Self.videoListVC.string = tag;
            
            Self.videoListVC.name = name;
            
            [Self.videoListVC loadData];//加载数据
            
            Self.videoListVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
            
            [Self.navigationController pushViewController:Self.videoListVC animated:YES];
        
        };
        
        _sortView.videoSearchBlock = ^(NSString *videoName){
          
            Self.videoListVC.name = [NSString stringWithFormat:@"%@的搜索结果",videoName];
            
            Self.videoListVC.searchName = videoName;
            
            [Self.videoListVC loadData];//加载数据
            
            Self.videoListVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
            
            [Self.navigationController pushViewController:Self.videoListVC animated:YES];
            
        };
        
        
        
    }

    return _sortView;

}


#pragma mark ---LazyLoading

//最新

-(Union_Video_VideoListTableView *)newView{

    if (_newView == nil) {
        
         _newView = [[Union_Video_VideoListTableView alloc]initWithFrame:CGRectMake(0, 40 , self.view.frame.size.width, self.view.frame.size.height - 113 - 40) style:UITableViewStylePlain];
        
        _newView.urlStr = kUnion_Video_NewURL;
        
        _newView.rootVC = self;
        
    }

    return _newView;
}


-(VideoListViewController *)videoListVC{
    
    if (_videoListVC == nil) {
        
        _videoListVC = [[VideoListViewController alloc]init];
        
    }
    
    return _videoListVC;
    
}


@end
