//
//  MoreViewController.m
//  DouYU
//
//  Created by Alesary on 15/11/3.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "MoreViewController.h"
#import "ZWCollectionViewFlowLayout.h"
#import "FourCollectionCell.h"
#import "NetworkSingleton.h"
#import "OnlineModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "NSString+Times.h"

#define URL @"http://www.douyutv.com/api/v1/live/"

#define URL2 @"?aid=ios&auth=9e3802f36db0fd94e29839ee3a92834a&client_sys=ios&limit=20&offset=0&time="

#define URL3 @"?aid=ios&auth=9e3802f36db0fd94e29839ee3a92834a&client_sys=ios&limit=20&offset="

#define URL4 @"&time="

#define URL_a @"0"


static NSString *cellIdentifier = @"OnlineViewCell";


@interface MoreViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,ZWwaterFlowDelegate>
{
    UICollectionView *_collectionView;
    
    NSMutableArray *_dataArray;
    
    ZWCollectionViewFlowLayout *_flowLayout;//自定义layout
    
    int times; //记录上拉的次数
    
}


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
    [self initCollectionView];
    [self initNavBar];
    [self loadData];
    [self loadMoreData];
}

-(void)initNavBar
{
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"btn_nav_back"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 25, 25);
    [leftbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    self.navigationItem.rightBarButtonItem=nil;
    self.navigationItem.titleView=nil;
    
    
}

-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)loadData
{
    NSLog(@"%@%@%@%@%@",URL,self.Cate_id,URL2,URL4,[NSString GetNowTimes]);
    
    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:[NSString stringWithFormat:@"%@%@%@%@%@",URL,self.Cate_id,URL2,URL4,[NSString GetNowTimes]] successBlock:^(id responseBody) {
        
        _dataArray=[OnlineModel objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
        
        [_collectionView reloadData];
        
    } failureBlock:^(NSString *error) {
        
        
    }];
}

-(void)loadMoreData
{
    
    _collectionView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[NetworkSingleton sharedManager] getResultWithParameter:nil url:[NSString stringWithFormat:@"%@%@%@%@",URL,self.Cate_id,URL2,[NSString GetNowTimes]] successBlock:^(id responseBody) {
            
            _dataArray=[OnlineModel objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
            
            [_collectionView reloadData];
            [_collectionView.header endRefreshing];
            
        } failureBlock:^(NSString *error) {
            
            [_collectionView.header endRefreshing];
            
        }];
        
        
    }];
    
    [_collectionView.header beginRefreshing];
    
    
    _collectionView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        times+=20;
        NSString *time=[NSString stringWithFormat:@"%d",times];
        
        NSLog(@"%@%@%@%@%@",URL,self.Cate_id,URL3,time,[NSString GetNowTimes]);
        
        [[NetworkSingleton sharedManager] getResultWithParameter:nil url:[NSString stringWithFormat:@"%@%@%@%@%@%@",URL,self.Cate_id,URL3,time,URL4,[NSString GetNowTimes]] successBlock:^(id responseBody) {
            
            NSArray *array=[OnlineModel objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
            
            for (OnlineModel *moreData in array) {
                
                [_dataArray addObject:moreData];
            }
            
            [_collectionView reloadData];
            [_collectionView.footer endRefreshing];
            
        } failureBlock:^(NSString *error) {
            
            [_collectionView.footer endRefreshing];
        }];
        
    }];
    
    _collectionView.footer.hidden = YES;
    
}

-(void)initCollectionView
{
    //初始化自定义layout
    _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    _flowLayout.colMagrin = 5;
    _flowLayout.rowMagrin = 5;
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    _flowLayout.colCount = 2;
    _flowLayout.degelate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout: _flowLayout];
    //注册显示的cell的类型
    
    UINib *cellNib=[UINib nibWithNibName:@"FourCollectionCell" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor=RGBA(200, 200, 200, 0.25);
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    _collectionView.footer.hidden = YES;
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    FourCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.onlineData=_dataArray[indexPath.item];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"你点击了 %ld--%ld",(long)indexPath.section,indexPath.item);
}


#pragma mark ZWwaterFlowDelegate
- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    
    return 150*KWidth_Scale;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
