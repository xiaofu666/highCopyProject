//
//  Union_RunesViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/14.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_RunesViewController.h"

#import "FilterView.h"

#import "FilterMenuItem.h"

#import "RunesCell.h"

#import "RunesModel.h"

#import "PCH.h"

#import "DataCache.h"

@interface Union_RunesViewController ()<FilterViewDelegate,UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic , retain ) UICollectionView *collectionView;//集合视图

@property (nonatomic , retain ) FilterView *filterView;//筛选视图

@property (nonatomic , retain ) NSMutableDictionary *dataDic;//数据源字典

@property (nonatomic , retain ) NSMutableArray *showArray;//显示数组

@property (nonatomic , retain ) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic , copy ) NSString *runesTypeFilter;//符文类型筛选

@property (nonatomic , copy ) NSString *runesLevelFilter;//符文等级筛选


@end

@implementation Union_RunesViewController

-(void)dealloc{
    
    [_collectionView release];
    
    [_filterView release];
    
    [_dataDic release];
    
    [_showArray release];
    
    [_manager release];
    
    [_runesLevelFilter release];
    
    [_runesTypeFilter release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"符文";

    //初始化集合视图
    
    [self initCollectionView];
    
    //初始化筛选视图
    
    [self initFilterView];
    
    //加载数据
    
    [self loadData];
    
}

#pragma mark ---初始化筛选视图

- (void)initFilterView{
    
    FilterMenuModel *fmModel1 = [[FilterMenuModel alloc]init];
    
    fmModel1.menuTitle = @"3级符文";
    
    fmModel1.menuDic = @{ @"default" : @[@"3级符文",@"2级符文",@"1级符文" ] };
    
    
    FilterMenuModel *fmModel2 = [[FilterMenuModel alloc]init];
    
    fmModel2.menuTitle = @"印记符文";
    
    fmModel2.menuDic = @{ @"default" : @[@"印记符文",@"雕纹符文",@"符印符文",@"精华符文" ] };
    
    
    _filterView = [[FilterView alloc]initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(self.view.frame), 40)];
    
    _filterView.dataArray = @[ fmModel1 , fmModel2 ];
    
    _filterView.delegate = self;
    
    [self.view addSubview:_filterView];
    
    [fmModel1 release];
    
    [fmModel2 release];
    
}

#pragma mark ---初始化集合视图

-(void)initCollectionView{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    //1.设置单元格的大小 ,itemSize
    
    //flow.itemSize = CGSizeMake( ( CGRectGetWidth(self.view.frame) - 30 ) / 2 , ( CGRectGetWidth(self.view.frame) - 30 ) / 2 + 60);
    
    flow.itemSize = CGSizeMake(145 , 205);
    
    //2.设置最小左右间距,单元格之间
    
    flow.minimumInteritemSpacing = 10;
    
    //3.设置最小上下间距, 单元格之间
    
    flow.minimumLineSpacing = 10;
    
    //4.设置滑动方向 (UICollectionViewScrollDirectionVertical 纵向)
    
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //5.section中cell的边界范围
    
    CGFloat inset = (CGRectGetWidth(self.view.frame) - 290 ) / 3;
    
    flow.sectionInset = UIEdgeInsetsMake(10, inset, 10, inset);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40 , CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 104 ) collectionViewLayout:flow];
    
    [flow release];
    
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    //设置代理
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    //注册
    
    [_collectionView registerClass:[RunesCell class ] forCellWithReuseIdentifier:@"cell"];
    
}



#pragma mark ---加载缓存数据

- (void)loadLocallData{
    
    //查询本地缓存 指定数据名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:[NSString stringWithFormat:@"Ency_AllRunesData"]  Classify:@"Runes"];
    
    if (caCheData == nil) {
        
        
    } else {
        
        //解析数据
        
        [self JSONAnalyticalWithData:caCheData];
        
    }
    
}

#pragma mark ---加载数据

- (void)loadData{
    
    //加载缓存数据
    
    [self loadLocallData];
    
    
    //请求数据
    
    __block typeof(self) Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:kUnion_AllRunesURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //解析数据
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:[NSString stringWithFormat:@"Ency_AllRunesData"]  Classify:@"Runes"];

            
        } else {
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}

#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(id)data{

    if (data != nil) {
        
        //清空数据源字典
        
        [self.dataDic removeAllObjects];
        
        NSDictionary *tempDic = data;
        
        NSArray *runesKeyArray = [[NSArray alloc]initWithArray:@[@"Red" , @"Blue" , @"Yellow" , @"Purple"]];
        
        //符文解析
        
        for (NSString *key in runesKeyArray) {
            
            NSArray *runesTempArray = [tempDic valueForKey:key];
            
            NSMutableArray *runesArray = [[NSMutableArray alloc]init];
            
            for (NSDictionary *itemDic in runesTempArray) {
                
                //创建符文数据模型对象
                
                RunesModel *model = [[RunesModel alloc]init];
                
                model.Name = [[itemDic valueForKey:@"Name"] retain];
                
                model.Alias = [[itemDic valueForKey:@"Alias"] retain];
                
                model.lev1 = [[itemDic valueForKey:@"lev1"] retain];
                
                model.lev2 = [[itemDic valueForKey:@"lev2"] retain];
                
                model.lev3 = [[itemDic valueForKey:@"lev3"] retain];
                
                model.iplev1 = [[itemDic valueForKey:@"iplev1"] retain];
                
                model.iplev2 = [[itemDic valueForKey:@"iplev2"] retain];
                
                model.iplev3 = [[itemDic valueForKey:@"iplev3"] retain];
                
                model.Prop = [[itemDic valueForKey:@"Prop"] retain];
                
                model.Type = [[itemDic valueForKey:@"Type"] integerValue];
                
                model.Img = [[itemDic valueForKey:@"Img"] retain];
                
                model.Units = [[itemDic valueForKey:@"Units"] retain];
                
                model.level = 3;//默认3级
                
                //添加数组
                
                [runesArray addObject:model];
                
            }
            
            //添加数据源字典
            
            [self.dataDic setValue:runesArray forKey:key];
            
        }
        
        [runesKeyArray release];
        
        //设置默认筛选条件
        
        _runesLevelFilter = @"3级符文";
        
        [self dataScreeningConditions:@"印记符文" Type:@"印记符文"];
        
        
        
    }
    
}


#pragma mark ---筛选数据

- (void)dataScreeningConditions:(NSString *)condition Type:(NSString *)type{

    
    if ([type isEqualToString:@"印记符文"]) {
        
        if ([condition isEqualToString:@"印记符文"]) {
            
            _runesTypeFilter = @"Red";
            
        } else if ([condition isEqualToString:@"雕纹符文"]){
            
            _runesTypeFilter = @"Blue";
            
        } else if ([condition isEqualToString:@"符印符文"]){
            
            _runesTypeFilter = @"Yellow";
            
        } else if ([condition isEqualToString:@"精华符文"]){
            
            _runesTypeFilter = @"Purple";
            
        }
        
    }
    
    if ([type isEqualToString:@"3级符文"]) {
        
        _runesLevelFilter = condition;
        
    }
    
    //清空原有数组
    
    [_showArray release];
    
    _showArray = nil;
    
    //将数据数组的数据添加给显示的数据数组
    
    self.showArray = [[self.dataDic valueForKey:_runesTypeFilter] mutableCopy];
    
    //更新集合视图
    
    [self.collectionView reloadData];
    
}

-(void)setShowArray:(NSMutableArray *)showArray{
    
    if (_showArray != showArray ) {
        
        [_showArray release];
        
        _showArray = [showArray retain];
        
    }
    
    //筛选操作

    NSString *levelStr = [_runesLevelFilter substringToIndex:1];
    
    //循环设置数据等级属性
    
    for (RunesModel *model in self.showArray) {
        
        model.level = [levelStr integerValue];
        
    }

    
}


#pragma mark ---FilterViewDelegate

- (void)selectedScreeningConditions:(NSString *)condition Type:(NSString *)type{
    
//    NSLog(@"筛选条件 : %@ , 筛选类型 : %@ " , condition , type);
    
    [self dataScreeningConditions:condition Type:type];
    
}

#pragma mark ---UICollectionViewDataSource , UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.showArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RunesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = [self.showArray objectAtIndex:indexPath.item];
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---LazyLoading

-(NSMutableDictionary *)dataDic{
    
    if (_dataDic == nil) {
        
        _dataDic = [[NSMutableDictionary alloc]init];
        
    }
    
    return _dataDic;
    
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







@end
