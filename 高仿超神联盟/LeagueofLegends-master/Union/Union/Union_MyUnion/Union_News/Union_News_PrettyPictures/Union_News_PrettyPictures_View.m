//
//  Union_News_PrettyPictures_View.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_News_PrettyPictures_View.h"

#import "Union_News_PrettyPictures_CollectionViewCell.h"

#import "Union_News_Pictures_Scroll_ViewController.h"

#import "Union_News_PrettyPictures_Model.h"

#import "GearPowered.h"

#import "LoadingView.h"

#import "NSString+URL.h"

#import "LXCollectionViewFlowLayout.h"




@interface Union_News_PrettyPictures_View()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GearPoweredDelegate,LXwaterFlowDelegate>

@property (nonatomic , retain) UICollectionView *collectionView;

@property (nonatomic , retain) NSMutableArray *dataArray;

@property (nonatomic , retain) NSMutableArray *imageArray;

@property (nonatomic , retain) GearPowered *gearPowered;//齿轮刷新

@property (nonatomic , retain) LoadingView *loadingView;//加载视图

@property (nonatomic , retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , assign) NSInteger page;//页数

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end

@implementation Union_News_PrettyPictures_View


-(void)dealloc{
    
    [_collectionView release];
    
    [_dataArray release];
    
    [_imageArray release];
    
    [_gearPowered release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_urlString release];
    
    [_manager release];
    
    [super dealloc];
    
}



-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //创建集合视图瀑布流布局
        
        LXCollectionViewFlowLayout * layOut = [[LXCollectionViewFlowLayout alloc] init];
        
        layOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        layOut.delegate = self;
        
        //创建集合视图
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layOut];
        
        //集合视图的背景色
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        // 添加到视图
        
        [self addSubview:_collectionView];
        
        //设置代理
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        //注册
        
        [_collectionView registerClass:[Union_News_PrettyPictures_CollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];

        
        //设置页数
        
        _page = 1;
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self.collectionView;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self addSubview:_loadingView];

        
    }
    
    return self;
    
}


- (void)setUrlString:(NSString *)urlString{
    
    if (_urlString != urlString) {
        
        [_urlString release];
        
        _urlString = [urlString retain];
        
    }
    
    if (urlString != nil) {
        
        //加载数据
        
        [self loadData];
        
        self.gearPowered.url = [NSURL URLWithString:[[NSString stringWithFormat:_urlString ,self.page] URLEncodedString] ];
        
        self.gearPowered.bottomUrl = [NSURL URLWithString:[[NSString stringWithFormat:_urlString ,self.page] URLEncodedString] ];
        
        

    }
    
    
}


#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark ---加载数据

//加载数据

- (void)loadData{
    
    //显示加载视图
    
    self.loadingView.hidden = NO;
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;
    
    NSString *url = [[NSString stringWithFormat:self.urlString ,self.page] URLEncodedString];
    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET: url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //隐藏重新加载提示视图
        
        Self.reloadImageView.hidden = YES;
        
        //解析前清空数据源数组
        
        [Self.dataArray removeAllObjects];
        
        [Self.collectionView reloadData];
        
        //调用数据解析方法
        
        if (responseObject != nil) {

            [Self JSONSerializationWithData:responseObject];
            
        } else {
            
            //显示重新加载提示视图
            
            Self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
   
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //清空数据源数组
        
        [Self.dataArray removeAllObjects];
        
        [Self.collectionView reloadData];
        
        //显示重新加载提示视图
        
        Self.reloadImageView.hidden = NO;
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    }];
    
}

#pragma mark ---解析数据

- (void)JSONSerializationWithData:(id)data{
    
    NSDictionary *dic = data;
    
    NSArray *tempArray = [dic valueForKey:@"data"];
    
    for (NSDictionary *tempDic in tempArray) {
        
        Union_News_PrettyPictures_Model *model = [[Union_News_PrettyPictures_Model alloc]init];
        
        [model setValuesForKeysWithDictionary:tempDic];
        
        [self.dataArray addObject:model];
        
    }
    
    //刷新
    
    [self.collectionView reloadData];

    
    
}

#pragma mark -----集合视图的代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Union_News_PrettyPictures_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
    
}


//cell是否可以被点击

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


//点击方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.prettyPicturesBlock([self.dataArray[indexPath.item] galleryId]);
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //调用齿轮刷新的滑动事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //调用齿轮刷新的拖动结束事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
}

#pragma mark ---代理方法

-(CGFloat)LXwaterFlow:(LXCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    
    Union_News_PrettyPictures_Model *model = self.dataArray[indexPach.item];
    
    return [model.coverHeight floatValue] / [model.coverWidth floatValue ] * [model.coverWidth floatValue];
    
}


#pragma mark ---GearPoweredDelegate

-(void)didLoadData:(id)data{
    
    //清空页数
    
    self.page = 1;
    
    //解析前清空数据原数组
    
    [self.dataArray removeAllObjects];
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //调用数据解析方法
    
    [self JSONSerializationWithData:data];
    
}

- (void)didBottomLoadData:(id)data{
    
    
//    //页数限制10页
//    
//    if (self.page >= 10) {
//        
//        self.page = 1;
//        
//        //解析前清空数据原数组
//        
//        [self.dataArray removeAllObjects];
//        
//    }

    
    //上拉加载返回数据
    
    [self JSONSerializationWithData:data];
    
}

-(NSURL *)settingBottomLoadDataURL{
    
    self.page ++;
    
    
    //设置上拉加载URL (页数+1)
    
    return [NSURL URLWithString:[[NSString stringWithFormat:self.urlString ,self.page] URLEncodedString] ];
    
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








@end
