//
//  MyHeroTableView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MyHeroTableView.h"

#import "PCH.h"

#import "Networking.h"

#import "ListHero.h"

#import "MyHeroTableViewCell.h"

#import "MyHeroTableViewHeaderView.h"

#import "NSString+URL.h"

#import "LoadingView.h"

#import "DataCache.h"

@interface MyHeroTableView ()

@property (nonatomic , retain ) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain ) GearPowered *gearPowered;//齿轮刷新

@property (nonatomic , assign ) NSInteger heroGoldPrice;//英雄金币总价格

@property (nonatomic , copy ) NSString *serverFullName;//服务器全名

@property (nonatomic , retain ) MyHeroTableViewHeaderView *header;//表视图顶部视图

@property (nonatomic ,retain ) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain ) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain ) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end

@implementation MyHeroTableView

-(void)dealloc{
    
    [_dataArray release];
    
    [_gearPowered release];
    
    [_serverFullName release];
    
    [_serverName release];
    
    [_summonerName release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_manager release];
    
    [_header release];
    
    [super dealloc];
    
}

//初始化

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        //初始化数据源数组
        
        _dataArray = [[NSMutableArray alloc]init];
        
        //背景颜色
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置代理
        
        self.dataSource = self;
        
        self.delegate = self;
        
        //注册CELL
        
        [self registerClass:[MyHeroTableViewCell class] forCellReuseIdentifier:@"cell"];
        

        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        
        _loadingView.loadingColor = MAINCOLOER;
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self addSubview:_loadingView];
        
    }
    
    return self;
    
}



//加载数据

- (void)loadData{
    
    //查询本地缓存 指定数据名
    
    NSData *caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:@"MyHeroData" Classify:@"Hero"];
    
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
    
    __block MyHeroTableView *Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[[NSString stringWithFormat:kUnion_Ency_MyHeroListURL , _serverName , _summonerName ] URLEncodedString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //调用数据解析方法
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:@"MyHeroData" Classify:@"Hero"];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:YES];
        
    }];
    
    //设置齿轮刷新下拉刷新url
    
    _gearPowered.url = [NSURL URLWithString:[[NSString stringWithFormat:kUnion_Ency_MyHeroListURL , _serverName , _summonerName ] URLEncodedString]];
    
}


#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(id)data{
    
    if (data != nil) {
        
        //解析前清空数据源数组
        
        [self.dataArray removeAllObjects];
        
        //清空总金币价格
        
        self.heroGoldPrice = 0;
        
        NSDictionary *dic = data;
        
        NSArray *tempArray = [dic valueForKey:@"myHeroes"];
        
        self.serverFullName = [dic valueForKey:@"serverName"];
        
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
            
            listHero.presentTimes = [[itemDic valueForKey:@"presentTimes"] retain];
            
            //添加数据源数组
            
            [self.dataArray addObject:listHero];
            
            //增加总金币价格计数
            
            self.heroGoldPrice += [listHero.goldPrice integerValue];
            
        }
        
        //更新列表视图
        
        [self reloadData];
        
    }
    
}



#pragma mark ---GearPoweredDelegate


-(void)didLoadData:(id)data{
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //将数据缓存到本地 指定数据名
    
    [[DataCache shareDataCache] saveDataForDocumentWithData:data DataName:@"MyHeroData" Classify:@"Hero"];
    
    //调用数据解析方法
    
    [self JSONAnalyticalWithData:data];
    
}



#pragma mark ---UITableViewDataSource , UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyHeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 80);
    
    cell.listHero = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击跳转
    
    ListHero *listHero = [self.dataArray objectAtIndex:indexPath.row];
    
    //调用英雄详情Block 传入英雄英文名
    
    self.heroDetailBlock(listHero.enName);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

    self.header.serverFullName = self.serverFullName;
    
    self.header.heroCount = self.dataArray.count;
    
    self.header.heroGoldPrice = self.heroGoldPrice;
    
    [self.header addData];
    
    return self.header;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.gearPowered scrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.gearPowered scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
}

#pragma mark ---LazyLoading

-(MyHeroTableViewHeaderView *)header{
    
    if (_header == nil) {
        
        _header = [[MyHeroTableViewHeaderView alloc]initWithFrame:CGRectMake(0 , 0 , CGRectGetWidth(self.frame), 40)];
        
    }
    
    return _header;
    
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
