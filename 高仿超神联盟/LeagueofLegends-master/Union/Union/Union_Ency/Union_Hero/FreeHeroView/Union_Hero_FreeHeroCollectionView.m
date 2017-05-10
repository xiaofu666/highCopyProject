//
//  Union_Hero_FreeHeroCollectionView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Hero_FreeHeroCollectionView.h"

#import "PCH.h"

#import "FreeHeroCollectionViewCell.h"

#import "FreeHeroHeaderCollectionReusableView.h"

#import "ListHero.h"

#import "LoadingView.h"

#import "DataCache.h"


@interface Union_Hero_FreeHeroCollectionView ()

@property (nonatomic , retain) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain) NSString *descString;//提示描述

@property (nonatomic , retain) GearPowered *gearPowered;//齿轮刷新

@property (nonatomic ,retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end

@implementation Union_Hero_FreeHeroCollectionView

-(void)dealloc{
    
    [_dataArray release];
    
    [_descString release];
    
    [_gearPowered release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_manager release];
    
    [super dealloc];
    
}

//初始化

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
    
        //背景颜色
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置代理
        
        self.dataSource = self;
        
        self.delegate = self;
        
        //注册CELL
        
        [self registerClass:[FreeHeroCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        //出册顶部补充视图
        
        [self registerClass:[FreeHeroHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"freeHeader"];
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        _gearPowered.url = [NSURL URLWithString:[NSString stringWithFormat:kUnion_Ency_HeroListURL , @"free"]]; //设置下拉刷新url
        
        //_gearPowered.bottomUrl = [NSURL URLWithString:[NSString stringWithFormat:kUnion_Ency_HeroListURL , @"free"]]; //上拉刷新url 如果不设置 就不会显示上拉刷新功能
        
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        
        _loadingView.loadingColor = MAINCOLOER;
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self addSubview:_loadingView];
        
        
        //加载数据
        
        [self loadData];
        
    }
    
    return self;
    
}

//加载数据

- (void)loadData{
    
    //查询本地缓存 指定数据名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:@"FreeHeroData" Classify:@"Hero"];
    
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
    
    __block Union_Hero_FreeHeroCollectionView *Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[NSString stringWithFormat:kUnion_Ency_HeroListURL , @"free"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //调用数据解析方法
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:@"FreeHeroData" Classify:@"Hero"];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (self.dataArray.count > 0) {
            
            [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:YES];
            
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
        
        NSDictionary *dic = data;
        
        NSArray *tempArray = [dic valueForKey:@"free"];
        
        self.descString = [dic valueForKey:@"desc"];
        
        for (NSDictionary *itemDic in tempArray) {
            
            //创建数据模型对象
            
            ListHero *listHero = [[ListHero alloc]init];
            
            //添加数据 (注意加retain 否则会被自动释放)
            
            listHero.enName = [[itemDic valueForKey:@"enName"] retain];
            
            listHero.cnName = [[itemDic valueForKey:@"cnName"] retain];
            
            listHero.title = [[itemDic valueForKey:@"title"] retain];
            
            listHero.tags = [[itemDic valueForKey:@"tags"] retain];
            
            listHero.rating = [[itemDic valueForKey:@"rating"] retain];
            
            listHero.location = [[itemDic valueForKey:@"location"] retain];
            
            listHero.price = [[itemDic valueForKey:@"price"] retain];
            
            //添加数据源数组
            
            [self.dataArray addObject:listHero];
            
        }
        
        //更新列表视图
        
        [self reloadData];
        
    }
    
}

#pragma mark ---UICollectionViewDataSource , UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FreeHeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.listHero = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}


//设定页眉的尺寸

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {CGRectGetWidth(self.frame),10};
    
    return size;
}


//为collection view添加一个补充视图(页眉或页脚)

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    FreeHeroHeaderCollectionReusableView *CRV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"freeHeader" forIndexPath:indexPath];
    
    CRV.titleLabel.text = self.descString;
    
    return CRV;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击跳转
    
    ListHero *listHero = [self.dataArray objectAtIndex:indexPath.row];
    
    //调用英雄详情Block 传入英雄英文名
    
    self.heroDetailBlock(listHero.enName);
    
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
    
    //将数据缓存到本地 指定数据名
    
    [[DataCache shareDataCache] saveDataForDocumentWithData:data DataName:@"FreeHeroData" Classify:@"Hero"];
    
    //调用数据解析方法
    
    [self JSONAnalyticalWithData:data];

}



#pragma mark ---LazyLoading

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

@end
