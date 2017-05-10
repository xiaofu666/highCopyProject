//
//  Union_Equip_Type_List_ViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Equip_Type_List_ViewController.h"

#import "EquipTypeListCollectionViewCell.h"

#import "EquipTypeListModel.h"

#import "LoadingView.h"

#import "DataCache.h"

#import "LXHoneycombCollectionViewLayout.h"

#import "EquipListViewController.h"

@interface Union_Equip_Type_List_ViewController ()<UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic , retain) UICollectionView *collectionView;//集合视图

@property (nonatomic , retain) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic ,retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain) EquipListViewController *equipListVC;//装备列表视图控制器

@end

@implementation Union_Equip_Type_List_ViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)dealloc{
    
    [_collectionView release];
    
    [_dataArray release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_manager release];
    
    [_equipListVC release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"装备分类";
    
    

    [self.view addSubview:self.collectionView];
    
    //加载数据
    
    [self loadData];
    
}


#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

//加载数据

-(void)loadData{
    
    //查询本地缓存 指定数据名 和 分组名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:@"EquipTypeListData" Classify:@"Equip"];
    
    if (caCheData == nil) {
        
        //显示加载视图
        
        self.loadingView.hidden = NO;
        
    } else {
        
        //解析数据
        
        [self JSONAnalyticalWithData:caCheData];
        
    }
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;
    
    
    //请求数据
    
    __block typeof(self) Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:kUnion_Equip_Type_ListURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //调用数据解析方法
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //将数据缓存到本地 指定数据名 和分组名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:@"EquipTypeListData"  Classify:@"Equip"];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (self.dataArray.count > 0) {
            
            [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:NO];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
            //隐藏加载视图
            
            self.loadingView.hidden = YES;
            
        }
        
    }];
    
    
    
}

#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(id)data{
    
    if (data != nil) {
        
        //解析前清空数据源数组
        
        [self.dataArray removeAllObjects];
        
        NSArray *tempArray = data;
        
        for (NSDictionary *itemDic in tempArray) {
            
            //创建数据模型对象
            
            EquipTypeListModel *model = [[EquipTypeListModel alloc]init];
            
            //添加数据 (注意加retain 否则会被自动释放)
            
            model.tag = [[itemDic valueForKey:@"tag"] retain];
            
            model.text = [[itemDic valueForKey:@"text"] retain];
            
            //添加数据源数组
            
            [self.dataArray addObject:model];
            
        }
        
        //更新列表视图
        
        [self.collectionView reloadData];
        

        
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---UICollectionViewDataSource , UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EquipTypeListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.itemSize = ( CGRectGetWidth(self.view.frame)) / 4 + 15;
    
    cell.model = [self.dataArray objectAtIndex:indexPath.item];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.equipListVC.typeModel = [self.dataArray objectAtIndex:indexPath.item];
    
    [self.navigationController pushViewController:self.equipListVC animated:YES];
    
}




#pragma mark ---LazyLoading

-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        LXHoneycombCollectionViewLayout *layout = [[LXHoneycombCollectionViewLayout alloc]init];
        
        layout.size = ( CGRectGetWidth(self.view.frame) ) / 4 + 15 ;
        
        layout.col = 4;
        
        layout.margin = 10;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[EquipTypeListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
        [layout release];
        
    }
    
    return _collectionView;
    
}

-(EquipListViewController *)equipListVC{
    
    if (_equipListVC == nil) {
        
        _equipListVC = [[EquipListViewController alloc]init];
        
    }
    
    
    return _equipListVC;
}

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
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

-(LoadingView *)loadingView{
    
    if (_loadingView == nil) {
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        
        _loadingView.loadingColor = MAINCOLOER;
        
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




@end
