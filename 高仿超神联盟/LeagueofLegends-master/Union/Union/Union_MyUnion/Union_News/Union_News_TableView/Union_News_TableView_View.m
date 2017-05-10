//
//  Union_News_TableView_View.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_News_TableView_View.h"

#import "Union_News_TableViewCell.h"

#import "Union_News_Details_ViewController.h"

#import <UIImageView+WebCache.h>

#import "Union_News_TableView_Model.h"

#import "PCH.h"

#import "GearPowered.h"

#import "LoadingView.h"

#import "NSString+URL.h"

#import "PictureCycleModel.h"

#import "PictureCycleView.h"

#import "DataCache.h"


@interface Union_News_TableView_View ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,GearPoweredDelegate>


@property (nonatomic , retain) UIScrollView *scrollView;

@property (nonatomic , retain) UIPageControl *pageControl;

@property (nonatomic , retain) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain) NSMutableArray *pictureArray;//图片数据数组

@property (nonatomic , retain) GearPowered *gearPowered;//齿轮刷新

@property (nonatomic , retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , assign) NSInteger page;//页数

@property (nonatomic , retain) PictureCycleView *pictureCycleView;//图片轮播视图

@property (nonatomic , assign) BOOL isBottomLoading;//是否为底部刷新

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking


@end


@implementation Union_News_TableView_View


-(void)dealloc{
    
    Block_release(_detailsBlock);
    
    Block_release(_topicBlock);
    
    [_tableView release];
    
    [_scrollView release];
    
    [_pageControl release];
    
    [_dataArray release];
    
    [_urlstring release];
    
    [_gearPowered release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_pictureCycleView release];
    
    [_pictureArray release];
    
    [_manager release];
    
    [super dealloc];
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {


        //创建tableView
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        
        //设置cell的高度
        
        _tableView.rowHeight = 80;
        
        //设置代理
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        //添加到视图上
        
        [self addSubview:_tableView];
        
        //注册
        
        [_tableView registerClass:[Union_News_TableViewCell class] forCellReuseIdentifier:@"CELL"];
    
        
        [_tableView release];
        
        //设置页数
        
        _page = 1;
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self.tableView;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self addSubview:_loadingView];
        
        
        //初始化图片轮播视图
        
        _pictureCycleView = [[PictureCycleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetWidth(self.tableView.frame) / 7 * 4)];
        
        _pictureCycleView.timeInterval = 3.0f;
        
        _pictureCycleView.isPicturePlay = YES;
        
        _pictureCycleView.selectedPictureBlock = ^(PictureCycleModel *model){
            
            //跳转相应的详情页面
            
            self.detailsBlock(model.pid , nil);
            
        };
        
    }
    
    return self;
    
}

//获取URL字符串

- (void)setUrlstring:(NSString *)urlstring{
    
    if (_urlstring != urlstring) {
        
        [_urlstring release];
        
        _urlstring = [urlstring retain];
    }
    
    if (urlstring != nil) {
        
        //设置表视图样式无cell分隔线
        
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        //加载数据
       
        [self loadData];
        
        self.tableView.contentOffset = CGPointMake(0, 0);
        
        self.gearPowered.url = [NSURL URLWithString:[[NSString stringWithFormat:_urlstring ,self.page] URLEncodedString] ];
        
        self.gearPowered.bottomUrl = [NSURL URLWithString:[[NSString stringWithFormat:_urlstring ,self.page] URLEncodedString] ];
        
    }
  
    
}



#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark -------加载请求数据

//加载数据

- (void)loadData{
    
    //查询本地缓存 指定数据名 和 分组名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:[NSString stringWithFormat:@"%@%ld",@"NewsListData",self.scrollPage] Classify:@"News"];
    
    if (caCheData == nil) {
        
        //显示加载视图
        
        self.loadingView.hidden = NO;
        
    } else {
        
        //解析前清空数据源数组
        
        [self.dataArray removeAllObjects];
        
        [self.tableView reloadData];
        
        //解析数据
        
        [self JSONSerializationWithData:caCheData];
        
    }

    
    
    //非底部刷新
    
    self.isBottomLoading = NO;
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;

    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[[NSString stringWithFormat:self.urlstring ,self.page] URLEncodedString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //隐藏重新加载提示视图
        
        Self.reloadImageView.hidden = YES;
        
        //调用数据解析方法
        
        if (responseObject != nil) {
            
            //解析前清空数据源数组
            
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            
            //设置表视图样式有cell分隔线
            
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            
            [Self JSONSerializationWithData:responseObject];
            
            //将数据缓存到本地 指定数据名 和分组名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:[NSString stringWithFormat:@"%@%ld",@"NewsListData",self.scrollPage]  Classify:@"News"];
            
        } else {
            
            if (Self.dataArray.count == 0) {
                
                //显示重新加载提示视图
                
                Self.reloadImageView.hidden = NO;

            }
            
        }
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (Self.dataArray.count == 0) {
        
            //将表视图顶部视图设为nil 不显示图片轮播视图
            
            self.tableView.tableHeaderView = nil;
            
            //显示重新加载提示视图
            
            Self.reloadImageView.hidden = NO;
            
            //隐藏加载视图
            
            Self.loadingView.hidden = YES;
            
        } else {
            
            [UIView addLXNotifierWithText:@"加载失败 快去看看网络去哪了" dismissAutomatically:YES];
            
        }
        
    }];

}


#pragma mark ---解析数据

- (void)JSONSerializationWithData:(id)data{
    
    if (data != nil) {
        
        NSDictionary *dic = data;
        
        NSArray *tempDataArray = [dic valueForKey:@"data"];
        
        //判断是否有轮播图片数据键
        
        if ([[dic allKeys] containsObject:@"headerline"]) {
            
            if (![[dic objectForKey:@"headerline"] isEqual:[NSNull null]]) {
                
                //清空图片数据数组
                
                [self.pictureArray removeAllObjects];
                
                NSArray *tempPictureArray = [dic objectForKey:@"headerline"];
                
                if (tempPictureArray.count > 1) {
                    
                    for (NSDictionary *tempDic in tempPictureArray) {
                        
                        PictureCycleModel *model = [[PictureCycleModel alloc]init];
                        
                        model.pid = [[tempDic valueForKey:@"id"] retain];
                        
                        model.photoUrl = [[tempDic valueForKey:@"photo"] retain];
                        
                        [self.pictureArray addObject:model];
                        
                    }
                    
                    //将图片轮播视图添加到表视图顶部视图上 显示图片轮播视图
                    
                    self.tableView.tableHeaderView = self.pictureCycleView;
                    
                    //为图片轮播视图添加数据数组
                    
                    self.pictureCycleView.dataArray = self.pictureArray;
                    
                    //发送通知 传递轮播图数据
                    
                    NSDictionary * dic = @{@"pictureArray":self.pictureArray};
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PictureDataArray" object:self userInfo:dic];

                    
                }
                
                
            } else {
                
                //判断是否为下拉刷新 如果不是下拉刷新 则去除图片轮播视图
                
                if (_isBottomLoading == NO) {
                    
                    //将表视图顶部视图设为nil 不显示图片轮播视图
                    
                    self.tableView.tableHeaderView = nil;
                    
                }
                
            }
            
        }
        
        for (NSDictionary *tempDic in tempDataArray) {
            
            Union_News_TableView_Model *model = [[Union_News_TableView_Model alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDic];
            
            [self.dataArray addObject:model];
            
        }
        
        //刷新
        
        [self.tableView reloadData];
        
    }

}



#pragma mark ---UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate

//实现代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //重用cell机制
    
    Union_News_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    
    //设置cell的frame cell默认是320
    
    cell.frame = CGRectMake(0, 0, self.tableView.frame.size.width,90);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}

//点击cell push到的视图

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Union_News_TableView_Model *model =[self.dataArray objectAtIndex:indexPath.row];
    
    if (indexPath.row  == 0 && self.tableView.tableHeaderView != nil && [model.type isEqualToString:@"topic"]) {
        
        NSString *topicId = nil;
        
        NSArray *tempArray = [model.destUrl componentsSeparatedByString:@"&"];
        
        for (NSString *tempItem in tempArray) {
            
            if ([tempItem hasPrefix:@"topicId="]) {
                
                topicId = [tempItem substringFromIndex:8];
                
            }
            
        }
        
        self.topicBlock([NSString stringWithFormat:News_TopicURL , topicId ],model.type);
        
    }else{
        
        self.detailsBlock(model.id , model.type);
        
    }
    
    
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
    
    //清空页数
    
    self.page = 1;
    
    //解析前清空数据原数组
    
    [self.dataArray removeAllObjects];
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //调用数据解析方法
    
    [self JSONSerializationWithData:data];
    
}

- (void)didBottomLoadData:(id)data{
    
    //上拉加载返回数据
    
    [self JSONSerializationWithData:data];
    
}

-(NSURL *)settingBottomLoadDataURL{
    
    //是底部加载
    
    self.isBottomLoading = YES;
    
    //叠加页数
    
    self.page ++;
    
    //设置上拉加载URL (页数+1)
    
    return [NSURL URLWithString:[[NSString stringWithFormat:self.urlstring ,self.page] URLEncodedString] ];
    
}




#pragma mark ---LazyLoading


-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
}

-(NSMutableArray *)pictureArray{
    
    if (_pictureArray == nil) {
        
        _pictureArray = [[NSMutableArray alloc]init];
        
    }
    
    return _pictureArray;
    
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
