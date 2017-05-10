//
//  AllHeroCollectionView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AllHeroCollectionView.h"

#import "PCH.h"

#import "Networking.h"

#import "ListHero.h"

#import "AllHeroCollectionViewCell.h"

#import "LoadingView.h"

#import "DataCache.h"

@interface AllHeroCollectionView ()


@property (nonatomic , retain) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain) NSMutableArray *showArray;//显示的数据数组

@property (nonatomic , retain) GearPowered *gearPowered;//齿轮刷新


@property (nonatomic , copy) NSString *heroTypeScreen;//英雄类型筛选

@property (nonatomic , copy) NSString *heroLocationScreen;//英雄位置筛选

@property (nonatomic , copy) NSString *heroPriceScreen;//英雄价格筛选

@property (nonatomic , copy) NSString *heroSortScreen;//排序筛选



@property (nonatomic ,retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end



@implementation AllHeroCollectionView

-(void)dealloc{
    
    [_dataArray release];
    
    [_showArray release];
    
    [_heroTypeScreen release];
    
    [_heroLocationScreen release];
    
    [_heroPriceScreen release];
    
    [_heroSortScreen release];
    
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
        
        [self registerClass:[AllHeroCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        _gearPowered.url = [NSURL URLWithString:[NSString stringWithFormat:kUnion_Ency_HeroListURL , @"all"]]; //设置下拉刷新url
        
        //_gearPowered.bottomUrl = [NSURL URLWithString:[NSString stringWithFormat:kUnion_Ency_HeroListURL , @"free"]]; //上拉刷新url 如果不设置 就不会显示上拉刷新功能
        
        
        //默认筛选条件
        
        _heroTypeScreen = @"全部类型";
        
        _heroLocationScreen = @"全部";
        
        _heroPriceScreen = @"不限";
        
        _heroSortScreen = @"默认";
        
        
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
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:@"AllHeroData" Classify:@"Hero"];
    
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
    
    __block AllHeroCollectionView *Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[NSString stringWithFormat:kUnion_Ency_HeroListURL , @"all"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //调用数据解析方法
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:@"AllHeroData" Classify:@"Hero"];
            
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
        
        NSArray *tempArray = [dic valueForKey:@"all"];
        
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
        
        //将数据源数组的数据添加给显示的数据数组
        
        self.showArray = [self.dataArray mutableCopy];
        
        //更新列表视图
        
        [self reloadData];
        
    }
    
}


#pragma mark ---筛选数据

- (void)dataScreeningConditions:(NSString *)condition Type:(NSString *)type{
    
    if ([type isEqualToString:@"英雄类型"]) {
        
        _heroTypeScreen = condition;
        
    } else if ([type isEqualToString:@"英雄位置"]) {
        
        _heroLocationScreen = condition;
        
    } else if ([type isEqualToString:@"英雄价格"]) {
        
        _heroPriceScreen = condition;
        
    } else if ([type isEqualToString:@"排序"]) {
        
        _heroSortScreen = condition;
        
    }
    
    [_showArray release];
    
    _showArray = nil;
    
    //将数据源数组的数据添加给显示的数据数组
    
    self.showArray = [self.dataArray mutableCopy];
    
}


//设置显示数据数组

- (void)setShowArray:(NSMutableArray *)showArray{
    
    if (_showArray != showArray) {
        
        [_showArray release];
        
        _showArray = [showArray retain];
        
    }
    
    //英雄类型筛选
    
    [self heroTypeScreening:_heroTypeScreen];
    
    //英雄位置筛选
    
    [self heroLocationScreening:_heroLocationScreen];
    
    //英雄价格筛选
    
    [self heroPriceScreening:_heroPriceScreen];
    
    //排序筛选
    
    [self heroSortScreening:_heroSortScreen];
    
    
    //更新视图
    
    [self reloadData];
    
}


//英雄类型筛选

- (void)heroTypeScreening:(NSString *)condition{
    
    //筛选条件不为默认条件
    
    if (![condition isEqualToString:@"全部类型"]) {
        
        //转换英文类型
        
        NSString *tags = [self heroTypeHandle:condition];
        
        //创建临时数组存储showArray (防止直接对showArray进行删除操作造成循环混乱)
        
        NSArray * tempArray = [self.showArray copy];
        
        for (int i = 0 ; i < tempArray.count ; i++ ) {
            
            ListHero *lhItem = tempArray[i];
            
            //不符合条件的从显示数据数组中删除
            
            if (![tags isEqualToString:lhItem.tags]) {
                
                [self.showArray removeObject:lhItem];
                
            }
    
        }
        
        [tempArray release];
        
    }
    
}

//英雄类型处理 中文转英文

- (NSString *)heroTypeHandle:(NSString *)heroType{
    
    if ([heroType isEqualToString:@"坦克"]) {
        
        return @"tank";
        
    } else if ([heroType isEqualToString:@"刺客"]) {
        
        return @"assassin";
        
    } else if ([heroType isEqualToString:@"法师"]) {
        
        return @"mage";
        
    } else if ([heroType isEqualToString:@"战士"]) {
        
        return @"fighter";
        
    } else if ([heroType isEqualToString:@"射手"]) {
        
        return @"marksman";
        
    } else if ([heroType isEqualToString:@"辅助"]) {
        
        return @"support";
        
    } else {
        
        return @"novice";//新手
        
    }
    
    
}

//英雄位置筛选

- (void)heroLocationScreening:(NSString *)condition{
    
    //筛选条件不为默认条件
    
    if (![condition isEqualToString:@"全部"]) {
        
        //创建临时数组存储showArray (防止直接对showArray进行删除操作造成循环混乱)
        
        NSArray * tempArray = [self.showArray copy];

        
        for (ListHero *lhItem in tempArray) {
            
            //不符合条件的从显示数据数组中删除
            
            if ([lhItem.location rangeOfString:condition].length <= 0) {
                
                [self.showArray removeObject:lhItem];
                
            }
            
        }
        
        [tempArray release];
        
    }
    
}

//英雄价格筛选

- (void)heroPriceScreening:(NSString *)condition{
    
    //筛选条件不为默认条件
    
    if (![condition isEqualToString:@"不限"]) {
        
        //创建临时数组存储showArray (防止直接对showArray进行删除操作造成循环混乱)
        
        NSArray * tempArray = [self.showArray copy];
        
        for (ListHero *lhItem in tempArray) {
            
            //判断是金币还是点劵
            
            if ([@"450,1350,3150,4800,6300,7800" rangeOfString:condition].length>0) {
                
                //金币
                
                //不符合条件的从显示数据数组中删除
                
                if (![condition isEqualToString:lhItem.goldPrice]) {
                    
                    //筛选金币价格
                    
                    [self.showArray removeObject:lhItem];
                    
                }

                
            } else if ([@"1000,1500,2000,2500,3000,3500,4000,4500" rangeOfString:condition].length>0) {
                
                //点劵
                
                if (![condition isEqualToString:lhItem.couponsPrice]) {
                    
                    //筛选点劵价格
                    
                    [self.showArray removeObject:lhItem];
                    
                }
                
                
            }

        }
        
        [tempArray release];
        
    }
    
}

//英雄排序筛选

- (void)heroSortScreening:(NSString *)condition{
    
    //筛选条件不为默认条件
    
    if (![condition isEqualToString:@"默认"]) {
        
        if ([condition isEqualToString:@"物攻"]) {
            
            //降序排序
            
            NSComparator cmptr = ^(ListHero *obj1, ListHero *obj2){
               
                if ([obj1.ratingA integerValue] < [obj2.ratingA integerValue]) {
                
                    return (NSComparisonResult)NSOrderedDescending;
                
                } else {
                    
                    return (NSComparisonResult)NSOrderedAscending;
                    
                }
                
                return (NSComparisonResult)NSOrderedSame;
                
            };
            
            [self.showArray sortUsingComparator:cmptr];
            
        } else if ([condition isEqualToString:@"法伤"]) {
            
            //降序排序
            
            NSComparator cmptr = ^(ListHero *obj1, ListHero *obj2){
                
                if ([obj1.ratingC integerValue] < [obj2.ratingC integerValue]) {
                    
                    return (NSComparisonResult)NSOrderedDescending;
                    
                } else {
                    
                    return (NSComparisonResult)NSOrderedAscending;
                    
                }
                
                return (NSComparisonResult)NSOrderedSame;
                
            };
            
            [self.showArray sortUsingComparator:cmptr];
            
            
        } else if ([condition isEqualToString:@"防御"]) {
            
            //降序排序
            
            NSComparator cmptr = ^(ListHero *obj1, ListHero *obj2){
                
                if ([obj1.ratingB integerValue] < [obj2.ratingB integerValue]) {
                    
                    return (NSComparisonResult)NSOrderedDescending;
                    
                } else {
                    
                    return (NSComparisonResult)NSOrderedAscending;
                    
                }
                
                return (NSComparisonResult)NSOrderedSame;
                
            };
            
            [self.showArray sortUsingComparator:cmptr];
            
            
        } else if ([condition isEqualToString:@"操作"]) {
            
            //降序排序
            
            NSComparator cmptr = ^(ListHero *obj1, ListHero *obj2){
                
                if ([obj1.ratingD integerValue] < [obj2.ratingD integerValue]) {
                    
                    return (NSComparisonResult)NSOrderedDescending;
                    
                } else {
                    
                    return (NSComparisonResult)NSOrderedAscending;
                    
                }
                
                return (NSComparisonResult)NSOrderedSame;
                
            };
            
            [self.showArray sortUsingComparator:cmptr];
            
        } else if ([condition isEqualToString:@"金币"]) {
            
            //降序排序
            
            NSComparator cmptr = ^(ListHero *obj1, ListHero *obj2){
                
                if ([obj1.goldPrice integerValue] < [obj2.goldPrice integerValue]) {
                    
                    return (NSComparisonResult)NSOrderedDescending;
                    
                } else {
                    
                    return (NSComparisonResult)NSOrderedAscending;
                    
                }
                
                return (NSComparisonResult)NSOrderedSame;
                
            };
            
            [self.showArray sortUsingComparator:cmptr];
            
        } else if ([condition isEqualToString:@"点劵"]) {
            
            //降序排序
            
            NSComparator cmptr = ^(ListHero *obj1, ListHero *obj2){
                
                if ([obj1.couponsPrice integerValue] < [obj2.couponsPrice integerValue]) {
                    
                    return (NSComparisonResult)NSOrderedDescending;
                    
                } else {
                    
                    return (NSComparisonResult)NSOrderedAscending;
                    
                }
                
                return (NSComparisonResult)NSOrderedSame;
                
            };
            
            [self.showArray sortUsingComparator:cmptr];
            
        }

    }
    
}



#pragma mark ---根据英雄名字搜索英雄

- (void)searchHeroWithHeroName:(NSString *)heroName{
    
    //清空释放之前的数据
    
    [_showArray release];
    
    _showArray = nil;
    
    //将数据源数组的数据添加给显示的数据数组
    
    self.showArray = [self.dataArray mutableCopy];
    
    
    //搜索条件非空判断
    
    if (heroName != nil) {
        
        if (![heroName isEqualToString:@""]) {
            
            //筛选条件不为默认条件
            
            //创建临时数组存储showArray (防止直接对showArray进行删除操作造成循环混乱)
            
            NSArray * tempArray = [self.showArray copy];
            
            for (int i = 0 ; i < tempArray.count ; i++ ) {
                
                ListHero *lhItem = tempArray[i];
                
                //不符合条件的从显示数据数组中删除
                
                //判断英雄标题
                
                if (![lhItem.title rangeOfString:heroName].length > 0) {
                    
                    //判断英雄英文名
                    
                    if (![lhItem.enName rangeOfString:heroName].length > 0) {
                        
                        //判断英雄中文名
                        
                        if (![lhItem.cnName rangeOfString:heroName].length > 0) {
                        
                            [self.showArray removeObject:lhItem];
                            
                        }
                        
                    }
                    
                }
                
            }
            
            [tempArray release];

        }
        
    }
    
}

#pragma mark ---UICollectionViewDataSource , UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.showArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AllHeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.listHero = [self.showArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击跳转
    
    ListHero *listHero = [self.showArray objectAtIndex:indexPath.row];
    
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
    
    [[DataCache shareDataCache] saveDataForDocumentWithData:data DataName:@"AllHeroData" Classify:@"Hero"];
    
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
