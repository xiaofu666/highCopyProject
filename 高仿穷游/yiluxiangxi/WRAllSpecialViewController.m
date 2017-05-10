//
//  WRAllSpecialViewController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRAllSpecialViewController.h"
#import "Path.h"
#import "SpecialAllImageCell.h"
#import "RequestModel.h"
#import "UIImageView+WebCache.h"
#import "WRRecWebViewController.h"
#import "MJRefresh.h"
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)
@interface WRAllSpecialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,sendRequestInfo>
{
    NSMutableArray* dataSource;
    UICollectionView *_collectionView;
    int currentPage;
    //下拉刷新
    BOOL isRefreshing;
    //上拉加载
    BOOL isLoading;
}
@end

@implementation WRAllSpecialViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
}

-(void)creatCollection{
    UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[SpecialAllImageCell class] forCellWithReuseIdentifier:@"SpecialAllImageCell"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    currentPage=1;
    isRefreshing=NO;
    isLoading=NO;
    dataSource=[[NSMutableArray alloc]init];
    [self creatCollection];
    [self reloadDataSource];
    [self LoadingAndRefreshing];
}


-(void)reloadDataSource{
    
    RequestModel* request=[[RequestModel alloc]init];
    NSString* pathStr=[NSString stringWithFormat:SPECIALALL1,currentPage,SPECIALALL2];
    //NSLog(@"%d",currentPage);
    request.path=pathStr;
    request.delegate=self;
    [request startRequestInfo];
}


-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSArray* array=message[@"data"];
    [dataSource addObjectsFromArray:array];
    [_collectionView reloadData];
}


-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}

-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* special=@"SpecialAllImageCell";
    SpecialAllImageCell* specialCell=[collectionView dequeueReusableCellWithReuseIdentifier:special forIndexPath:indexPath];
    if (dataSource.count!=0) {
        NSString* imageStr=dataSource[indexPath.row][@"photo"];
        [specialCell.speImageView setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:nil];
    }
    return specialCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(357*(WIDTH/375.0), 250*(HEIGHT/667.0));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* imageStrUrl=dataSource[indexPath.row][@"url"];
    WRRecWebViewController* webView=[[WRRecWebViewController alloc]init];
    webView.pathStr=imageStrUrl;
    [self.navigationController pushViewController:webView animated:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}


//实现加载刷新
-(void)LoadingAndRefreshing{
    //刷新
    [_collectionView addHeaderWithCallback:^{
        [dataSource removeAllObjects];
        if (isRefreshing) {
            return ;
        }
        isRefreshing=YES;
        currentPage=1;
        [self reloadDataSource];
        
        isRefreshing=NO;
        [_collectionView headerEndRefreshing];
    }];
    //加载
    [_collectionView addFooterWithCallback:^{
        if (isLoading) {
            return ;
        }
        isLoading=YES;
        currentPage++;
        [self reloadDataSource];
        isLoading=NO;
        [_collectionView footerEndRefreshing];
    }];
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
