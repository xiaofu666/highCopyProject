//
//  Union_Video_SortCollectionView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Video_SortCollectionView.h"

#import "SortCollectionViewCell.h"

#import "PCH.h"

#import "SortModel.h"

#import "SortCollectionReusableView.h"

#import "LoadingView.h"

#import "DataCache.h"


@interface Union_Video_SortCollectionView ()

@property (nonatomic ,retain) NSMutableArray *dataArray;//数据原数组

@property (nonatomic ,retain) NSMutableArray *headerArray;//区头数据源

@property (nonatomic ,retain) GearPowered *gearPowered;//齿轮刷新

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic ,retain) LoadingView *loadingView;//加载视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end


@implementation Union_Video_SortCollectionView
-(void)dealloc{

    [_dataArray release];

    [_headerArray release];
    
    [_gearPowered release];
    
    [_reloadImageView release];
    
    [_loadingView release];
    
    [_manager release];
    
    [super dealloc];



}

//初始化

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
      
        //设置背景色
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置代理
        
        self.delegate = self;
        
        self.dataSource = self;
        
        //注册CELL
        
        [self registerClass:[SortCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
        
        //注册区头
        
        [self registerClass:[SortCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        _gearPowered.url = [NSURL URLWithString:kUnion_Video_SortURL];//设置上拉刷新

        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self addSubview:_loadingView];
        
        
        //加载数据
        
        [self loadData];
        
    
    }

    return self;

}

-(void)loadData{
    
    //查询本地缓存 指定数据名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:@"VideoSortData" Classify:@"Video"];
    
    if (caCheData == nil) {
        
        //显示加载视图
        
        self.loadingView.hidden = NO;
        
    } else {
        
        //解析数据
        
        [self NSJSONSerializationWithData:caCheData];
        
    }
    
    
    

    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;
    
    __block Union_Video_SortCollectionView *Self = self;
    
    //取消之前的请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:kUnion_Video_SortURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //解析数据
            
            [Self NSJSONSerializationWithData:responseObject];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:@"VideoSortData" Classify:@"Video"];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (self.dataArray.count > 0 ) {
            
            [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:YES];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
            //隐藏加载视图
            
            self.loadingView.hidden = YES;
            
        }
        
    }];
    

}

#pragma mark ---LazyLoading

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
}


-(NSMutableArray *)headerArray{
    
    if (_headerArray == nil) {
    
        _headerArray = [[NSMutableArray alloc]init];
    
    }
    
    return _headerArray;

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

-(UIImageView *)reloadImageView{
    
    if (_reloadImageView == nil) {
        
        //初始化 并添加单击手势
        
        UITapGestureRecognizer *reloadImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadImageViewTapAction:)];
        
        _reloadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        
        _reloadImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , CGRectGetHeight(self.frame) / 2);
        
        _reloadImageView.image = [[UIImage imageNamed:@"reloadImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _reloadImageView.tintColor = [UIColor lightGrayColor];
        
        _reloadImageView.backgroundColor = [UIColor clearColor];
        
        [_reloadImageView addGestureRecognizer:reloadImageViewTap];
        
        _reloadImageView.hidden = YES;//默认隐藏
        
        _reloadImageView.userInteractionEnabled = YES;
        
        [self addSubview:_reloadImageView];
        
        
    }
    
    return _reloadImageView;
    
}

#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark ---解析数据

-(void)NSJSONSerializationWithData:(id)data{
    
    
    if (data != nil) {
        
        //解析前清空数据原数组
        
        [self.dataArray removeAllObjects];
        
        [self.headerArray removeAllObjects];
        
        NSMutableArray *array = data;
        
        //遍历取出所有字典
        
        for (NSDictionary *dic in array) {
            
            //在字典中用key取出subCategory里的值
            
            NSMutableArray *subArray = [dic valueForKey:@"subCategory"];
            
            [self.headerArray addObject:[dic valueForKey:@"name"]];
            
            NSMutableArray *itemArray = [NSMutableArray array];
            
            for (NSDictionary *subDic in subArray) {
                
                SortModel *model = [[SortModel alloc]init];
                
                [model setValuesForKeysWithDictionary:subDic];
                
                [itemArray addObject:model];
                
            }
            
            //添加到数据原数组中
            
            [self.dataArray addObject:itemArray];
            
        }
        
        //刷新数据
        
        [self reloadData];
        
    }

    
}

#pragma mark ------UICollectionViewDataSource , UICollectionViewDelegate  方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.dataArray[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.sortModel = self.dataArray[indexPath.section][indexPath.row];

    return cell;
}

//设置页眉的尺寸

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        
        CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 80);
        
        return size;
    }else{
    
      CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 30);
        
        return size;
    
    }
}

//为collection view添加一个补充视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    SortCollectionReusableView *VRC = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    //判断
    
    if (indexPath.section == 0 ) {
        
        __block Union_Video_SortCollectionView *Self = self;
        
        VRC.videoSearchBlock = ^(NSString *videoName){
            
            Self.videoSearchBlock(videoName);
            
        };
        
        //隐藏
        
        VRC.textField.hidden = NO;
        
        VRC.button.hidden = NO;
    }
    else{
        
        VRC.textField.hidden = YES;
        
        VRC.button.hidden = YES;
    }
    
    VRC.myHeader.text = self.headerArray[indexPath.section];
    
    return VRC;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //调用齿轮刷新的滑动事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //调用齿轮刷新的拖动结束事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
}

#pragma mark ---GearPoweredDelegate

-(void)didLoadData:(id)data{
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //调用数据解析方法
    
    [self NSJSONSerializationWithData:data];
    
}

//点击方法

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    SortModel *model = self.dataArray[indexPath.section][indexPath.row];
    
    self.block(model.tag , model.name);

}




@end
