//
//  ColumnController.m
//  DouYU
//
//  Created by Alesary on 15/10/29.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "ColumnController.h"
#import "Public.h"
#import "ColumnViewCell.h"
#import "NetworkSingleton.h"
#import "ColumnModel.h"
#import "MJExtension.h"
#import "ZWCollectionViewFlowLayout.h"
#import "SDRotationLoopProgressView.h"

static NSString *cellIdentifier = @"ColumnViewCell";

#define URL @"http://www.douyutv.com/api/v1/game?aid=ios&auth=3f252c3294b31a61fbdd890a45609549&client_sys=ios&time=1446450360"

@interface ColumnController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,ZWwaterFlowDelegate>
{
    UICollectionView *_collectionView;
    
    NSMutableArray *_dataArray;
    
    ZWCollectionViewFlowLayout *_flowLayout;//自定义layout
    
    SDRotationLoopProgressView *_LoadView;
    
}


@end

@implementation ColumnController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];

    [self initCollectionView];
    [self loadData];
}

-(void)loadData
{
    
    [self showLoadView];
    
    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:URL successBlock:^(id responseBody) {
        
        _dataArray=[ColumnModel objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
        
        [_collectionView reloadData];
        
      [self hidenLoadView];
        
    } failureBlock:^(NSString *error) {
        
       [self hidenLoadView];
    }];
}


-(void)initCollectionView
{
    //初始化自定义layout
    _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    _flowLayout.degelate = self;
    _flowLayout.colCount=3;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout: _flowLayout];
    //注册显示的cell的类型
    
    UINib *cellNib=[UINib nibWithNibName:@"ColumnViewCell" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor=RGBA(200, 200, 200, 0.25);
    [self.view addSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ColumnViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setContentWith:_dataArray[indexPath.item]];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

#pragma mark ZWwaterFlowDelegate
- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    
    return 187*KWidth_Scale;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"你点击了 %ld--%ld",(long)indexPath.section,indexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)hidenLoadView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [_LoadView removeFromSuperview];
        
    }];
}

-(void)showLoadView
{
    _LoadView=[SDRotationLoopProgressView progressView];
    
    _LoadView.frame=CGRectMake(0, 0, 100*KWidth_Scale, 100*KWidth_Scale);
    
    _LoadView.center=self.view.center;

    [self.view addSubview: _LoadView ];

}

@end
