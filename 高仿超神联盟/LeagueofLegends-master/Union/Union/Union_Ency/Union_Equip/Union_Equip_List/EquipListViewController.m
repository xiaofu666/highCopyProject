//
//  EquipListViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipListViewController.h"

#import "LoadingView.h"

#import "DataCache.h"

#import "EquipListModel.h"

#import "EquipListCollectionViewCell.h"

#import "EquipDetailsViewController.h"

@interface EquipListViewController ()<UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic , retain ) UICollectionView *collectionView;//集合视图

@property (nonatomic , retain ) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain ) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic ,retain ) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain ) UIImageView *reloadImageView;//重新加载图片视图


@property (nonatomic , retain ) EquipDetailsViewController *equipDetailsVC;//装备详情视图控制器

@end

@implementation EquipListViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)dealloc{
    
    [_collectionView release];
    
    [_dataArray release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_manager release];
    
    [_equipDetailsVC release];
    
    [_typeModel release];
    
    [super dealloc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"装备分类";
    
    
    [self.view addSubview:self.collectionView];
    
}

-(void)setTypeModel:(EquipTypeListModel *)typeModel{
    
    if (_typeModel != typeModel) {
        
        [_typeModel release];
        
        _typeModel = [typeModel retain];
        
    }
    
    //加载数据
    
    [self loadData];

    //设置标题

    self.title = typeModel.text;
    

}

#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

//加载数据

-(void)loadData{
    

    //请求数据
    
    __block typeof(self) Self = self;

    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];

    //执行新的请求操作
    
    [self.manager GET:[NSString stringWithFormat:kUnion_Equip_ListURl , self.typeModel.tag] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {

            //调用数据解析方法
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:[NSString stringWithFormat:@"EquipList%@Data" , self.typeModel.tag] Classify:@"Equip"];
            
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

#pragma mark ---加载缓存数据

- (void)loadLocallData
{

    
    //查询本地缓存 指定数据名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:[NSString stringWithFormat:@"EquipList%@Data" , self.typeModel.tag] Classify:@"Equip"];
    
    if (caCheData == nil) {
        
        //显示加载视图
        
        self.loadingView.hidden = NO;
        
        //隐藏集合视图
        
        self.collectionView.hidden = YES;
        
    } else {
        
        //解析数据
        
        [self JSONAnalyticalWithData:caCheData];
        
    }
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;

}

#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(id)data{
    
    if (data != nil) {
        
        //显示集合视图
        
        self.collectionView.hidden = NO;
        
        //解析前清空数据源数组
        
        [self.dataArray removeAllObjects];

        NSArray *tempArray = data;
        
        for (NSDictionary *itemDic in tempArray) {
            
            //创建数据模型对象
            
            EquipListModel *model = [[EquipListModel alloc]init];
            
            //添加数据 (注意加retain 否则会被自动释放)
            
            model.eid = [[itemDic valueForKey:@"id"] integerValue];
            
            model.text = [[itemDic valueForKey:@"text"] retain];
            
            //添加数据源数组
            
            [self.dataArray addObject:model];
            
        }
        
        //更新列表视图
        
        [self.collectionView reloadData];
        
    }
    
}

#pragma mark ---视图即将出现

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    //加载缓存数据
    
    [self loadLocallData];

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
    
    EquipListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.model = [self.dataArray objectAtIndex:indexPath.item];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转装备详情视图控制器 并传递装备ID
    
    EquipListModel *model = [self.dataArray objectAtIndex:indexPath.item];
    
    self.equipDetailsVC.eid = model.eid;
    
    [self.navigationController pushViewController:self.equipDetailsVC animated:YES];
    
}



#pragma mark ---LazyLoading

-(UICollectionView *)collectionView{

    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        //1.设置单元格的大小 ,itemSize
        
        CGFloat itemWidth = ( CGRectGetWidth(self.view.frame) - 50 ) / 4;
        
        CGFloat itemHeight = ( CGRectGetWidth(self.view.frame) - 50 ) / 4;
        
        layout.itemSize = CGSizeMake( itemWidth > 64 ? 64 : itemWidth , itemHeight > 64 ? 64 + 30 : itemHeight + 30  );
        
        //2.设置最小左右间距,单元格之间
        
        layout.minimumInteritemSpacing = 10;
        
        //3.设置最小上下间距, 单元格之间
        
        layout.minimumLineSpacing = 10;
        
        //4.设置滑动方向 (UICollectionViewScrollDirectionVertical 纵向)
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //5.section中cell的边界范围
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[EquipListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        [layout release];

    }

    return _collectionView;

}

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
    }
    
    return _dataArray;
    
}

-(EquipDetailsViewController *)equipDetailsVC{
    
    if (_equipDetailsVC == nil) {
        
        _equipDetailsVC = [[EquipDetailsViewController alloc]init];
        
    }
    
    return _equipDetailsVC;
    
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
