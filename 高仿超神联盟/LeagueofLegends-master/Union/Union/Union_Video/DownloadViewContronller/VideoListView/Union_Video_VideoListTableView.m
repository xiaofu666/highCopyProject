//
//  Union_Video_NewCollectionView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Video_VideoListTableView.h"

#import "VideoListTableViewCell.h"

#import "NSString+URL.h"

#import "PCH.h"

#import "VideoListModel.h"

#import "VideoDetailsModel.h"

#import "GearPowered.h"

#import "LoadingView.h"

#import "CoreStatus.h"

#import "LXAlertViewController.h"

#import "VideoPlayerViewController.h"


@interface Union_Video_VideoListTableView ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,GearPoweredDelegate,LXAlertViewDelegate>

@property (nonatomic ,retain) NSMutableArray *tableArray;//数据原数组

@property (nonatomic ,retain) GearPowered *gearPowered;//齿轮刷新

@property (nonatomic ,retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,assign) NSInteger page;//页数

@property (nonatomic ,retain) NSMutableArray *videoArray ;//视频详情数组

@property (nonatomic ,assign) NSInteger selectedCellIndex;//选中的Cell

@property (nonatomic ,assign) NSInteger lastSelectedCellIndex;//上一次选中的Cell

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking


@property (nonatomic , retain ) VideoPlayerViewController *videoPlayerVC;//视频播放视图控制器

@property (nonatomic , retain ) LXAlertViewController *lxAlertViewController;//提示视图控制器

@end


@implementation Union_Video_VideoListTableView

-(void)dealloc{

    [_tableArray release];
    
    [_gearPowered release];
    
    [_urlStr release];
    
    [_videoArray release];
    
    [_reloadImageView release];
    
    [_loadingView release];
    
    [_manager release];
    
    [_videoPlayerVC release];
    
    [_lxAlertViewController release];
    
    [super dealloc];
    
}


//初始化

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
   
    if (self = [super initWithFrame:frame style:style]) {
        
        //背景色
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置代理
        
        self.delegate = self;
        
        self.dataSource =self;
        
        self.rowHeight = 90;
        
        //注册cell
        
        [self registerClass:[VideoListTableViewCell class] forCellReuseIdentifier:@"CELL"];
        
        //默认选中cell为-1
        
        _selectedCellIndex = -1;
        
        //默认上一次选中cell为-1
        
        _lastSelectedCellIndex = -1;
        
        //设置页数
        
        _page = 1;
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        
        
    }

    return self;

}


#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark ---获取URL

-(void)setUrlStr:(NSString *)urlStr{
    
    if (_urlStr != urlStr) {
        
        [_urlStr release];
        
        _urlStr = [urlStr retain];
        
    }
    
    _gearPowered.url = [NSURL URLWithString:[[NSString stringWithFormat:urlStr ,self.page] URLEncodedString]];//设置下拉刷新
    
    _gearPowered.bottomUrl = [NSURL URLWithString:[[NSString stringWithFormat:urlStr ,self.page] URLEncodedString]];//设置上拉加载
    
    
    //加载数据
    
    [self loadData];
    
}

#pragma mark ---加载数据

-(void)loadData{
    
    //显示加载视图
    
    self.loadingView.hidden = NO;
    
    //隐藏重新加载提示视图

    self.reloadImageView.hidden = YES;
    
    //设置表视图样式无cell分隔线
    
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //请求数据
    
    __block Union_Video_VideoListTableView *Self =self;
    
    //清除之前所有请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[[NSString stringWithFormat:self.urlStr ,self.page] URLEncodedString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        //清空数据原数组
        
        [self.tableArray removeAllObjects];
        
        [self reloadData];
        
        if (responseObject != nil) {
            
            //设置表视图样式有cell分隔线
            
            self.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            
            //调用解析方法
            
            [Self NSJSONSerializationWithData:responseObject];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //清空数据原数组
        
        [self.tableArray removeAllObjects];
        
        [self reloadData];
        
        //显示重新加载提示视图
        
        self.reloadImageView.hidden = NO;
        
        //隐藏加载视图
        
        self.loadingView.hidden = YES;
        
    }];
    

}

#pragma mark ---解析数据

-(void)NSJSONSerializationWithData:(id)data{
    
    if (data != nil) {
        
        NSMutableArray *array = data;
        
        for (NSDictionary *dic in array) {
            
            VideoListModel *vlModel = [[VideoListModel alloc]init];
            
            NSString *uploadTime = [[dic valueForKey:@"upload_time"] substringWithRange:NSMakeRange(5, 5)];
            
            //在字典中找到key取值  转换成NSInteger
            
            NSInteger videoLength = [[dic valueForKey:@"video_length"] integerValue];
            
            vlModel.video_length = [[self getStringWithTime:videoLength] retain];
            
            vlModel.vid = [[dic valueForKey:@"vid"] retain];
            
            vlModel.cover_url = [[dic valueForKey:@"cover_url"] retain];
            
            vlModel.title = [[dic valueForKey:@"title"] retain];
            
            vlModel.upload_time = [uploadTime retain];
            
            [self.tableArray addObject:vlModel];
            
        }
        
        //刷新数据
        
        [self reloadData];
        
    }

}


#pragma mark-----cell选中

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取网络当前状态
    
    CoreNetWorkStatus currentStatus = [CoreStatus currentNetWorkStatus];
    
    //设置选中cell下标属性的值
    
    _selectedCellIndex = indexPath.row;
    
    //如果当前网络是否为WIFI网络
    
    if (currentStatus == CoreNetWorkStatusWifi) {
        
        VideoListModel *model = self.tableArray[_selectedCellIndex];
        
        //判断是否为上一次选中的cell 如果是 则不再请求数据 直接跳转
        
        if (_lastSelectedCellIndex != _selectedCellIndex) {
            
            //请求视频详情数据
            
            [self netWorkingGetVideoDetailsWithVID:model.vid Title:model.title];
            
            _lastSelectedCellIndex = _selectedCellIndex;
            
        } else {
            
            //跳转视频播放视图控制器播放视频
            
            [self playVideoToVPVC:self.videoArray VideoTitle:model.title];
            
        }

        
    } else {
        
        //给出非Wifi网络提示 确认是否继续播放
        
        __block typeof(self.rootVC) VC = self.rootVC;
        
        [self.lxAlertViewController showView:VC];
        
        self.lxAlertViewController.alertTitle = @"您现在没有WiFi网络\n是否任性观看?";
        
        self.lxAlertViewController.againAlertTitle = @"注意您的流量哟\n土豪!";
        
        self.lxAlertViewController.successAlertTitle = @"马上为您播放..";
        
        self.lxAlertViewController.positiveTitle = @"任性";
        
        self.lxAlertViewController.negativeTitle = @"算了";
        
        self.lxAlertViewController.alertColor = [UIColor colorWithRed:85/255.0 green:129/255.0 blue:226/255.0 alpha:1.0f];
        
        self.lxAlertViewController.positiveColor = [UIColor colorWithRed:55/255.0 green:99/255.0 blue:196/255.0 alpha:1.0f];
        
        self.lxAlertViewController.negativeColor = [UIColor colorWithRed:70/255.0 green:114/255.0 blue:211/255.0 alpha:1.0f];

        
    }
    
}

#pragma mark ---LXAlertViewDelegate

-(void)positiveButtonAction:(BOOL)isYes{
    
    if (isYes) {
        
        __block typeof(self) Self = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //播放
            
            VideoListModel *model = Self.tableArray[_selectedCellIndex];
            
            //判断是否为上一次选中的cell 如果是 则不再请求数据 直接跳转
            
            if (_lastSelectedCellIndex != _selectedCellIndex) {
                
                //请求视频详情数据
                
                [Self netWorkingGetVideoDetailsWithVID:model.vid Title:model.title];
                
                _lastSelectedCellIndex = _selectedCellIndex;
                
            } else {
                
                //跳转视频播放视图控制器播放视频
                
                [self playVideoToVPVC:self.videoArray VideoTitle:model.title];
                
            }

            
        });
        
        //清空提示视图控制器
        
        [self closeButtonAction];
        
    }
    
}

-(void)negativeButtonAction{
    
    //清空提示视图控制器
    
    [_lxAlertViewController release];
    
    _lxAlertViewController = nil;
    
}

-(void)closeButtonAction{
    
    //清空提示视图控制器
    
    [_lxAlertViewController release];
    
    _lxAlertViewController = nil;
    
}


#pragma mark ---UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            
            //取消
            
            break;
        case 1:
        {
        
            //播放
            
            VideoListModel *model = self.tableArray[_selectedCellIndex];
            
            //判断是否为上一次选中的cell 如果是 则不再请求数据 直接跳转
            
            if (_lastSelectedCellIndex != _selectedCellIndex) {
                
                //请求视频详情数据
                
                [self netWorkingGetVideoDetailsWithVID:model.vid Title:model.title];
                
                _lastSelectedCellIndex = _selectedCellIndex;
                
            } else {
                
                
                //调用选中视频cellBlock传递视频详情数组
                
                self.selectedVideoBlock(self.videoArray , model.title);
                
            }
            
           
        
        }
            break;
            
        default:
            
            break;
            
    }
    
}

#pragma mark ---请求视频详情数据

- (void)netWorkingGetVideoDetailsWithVID:(NSString *)vid Title:(NSString *)title{
    
    //显示加载视图
    
    self.loadingView.hidden = NO;
    
    __block Union_Video_VideoListTableView *Self =self;
    
    //清除之前所有请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[[NSString stringWithFormat:kUnion_VideoDetailsURL , vid] URLEncodedString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //解析视频详情数据
            
            [Self JSONSerializationVideoDetailsWithData:responseObject];
            
            //跳转视频播放视图控制器播放视频
            
            [Self playVideoToVPVC:Self.videoArray VideoTitle: title];
            
            //隐藏加载视图
            
            Self.loadingView.hidden = YES;
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:YES];
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    }];

    
}

#pragma mark ---解析视频详情数据

-(void)JSONSerializationVideoDetailsWithData:(id)data{
    
    if (data != nil) {
        
        //清空视频详情数组
        
        [self.videoArray removeAllObjects];
        
        [_videoArray release];
        
        _videoArray = nil;
        
        NSDictionary *resultDic = [data valueForKey:@"result"];
        
        NSDictionary *itemsDic = [resultDic valueForKey:@"items"];
        
        for (NSString *key in itemsDic) {
            
            NSDictionary *itemDic = [itemsDic valueForKey:key];
            
            //创建视频详情对象
            
            VideoDetailsModel *VDModel = [[VideoDetailsModel alloc]init];
            
            VDModel.vid = [[itemDic valueForKey:@"vid"] retain];
            
            VDModel.transcode_id = [[itemDic valueForKey:@"transcode_id"] retain];
            
            VDModel.video_name = [[itemDic valueForKey:@"video_name"] retain];
            
            VDModel.definition = [[itemDic valueForKey:@"definition"] retain];
            
            VDModel.size = [[[itemDic valueForKey:@"transcode"] valueForKey:@"size"] retain];
            
            VDModel.width = [[[itemDic valueForKey:@"transcode"] valueForKey:@"width"] retain];
            
            VDModel.height = [[[itemDic valueForKey:@"transcode"] valueForKey:@"height"] retain];
            
            VDModel.duration = [[[itemDic valueForKey:@"transcode"] valueForKey:@"duration"] retain];
            
            VDModel.urls = [[[itemDic valueForKey:@"transcode"] valueForKey:@"urls"] retain];
            
            //添加数组
            
            [self.videoArray addObject:VDModel];
            
            
        }
        
        //排序数组 (按照分辨率从低到高排序)
        
        [self.videoArray sortUsingComparator:^NSComparisonResult(VideoDetailsModel *obj1, VideoDetailsModel *obj2) {
            
            return [obj1.definition integerValue] > [obj2.definition integerValue];
            
        }];

    }
    
}



#pragma mark ---跳转视频播放视图控制器

- (void)playVideoToVPVC:(NSMutableArray *) videoArray VideoTitle:(NSString *)videoTitle{
   
    //父视图控制器非空判断
    
    if (self.rootVC) {
        
        if (videoArray.count >0) {
            
            self.videoPlayerVC.videoArray = videoArray;
            
            self.videoPlayerVC.videoTitle = videoTitle;
            
            //跳转视频播放视图控制器
            
            [self.rootVC presentViewController:self.videoPlayerVC animated:YES completion:^{
                
            }];

            
        } else {
            
            [UIView addLXNotifierWithText:@"视频不存在了..其他视频一样精彩" dismissAutomatically:YES];
            
        }

    }
    
}



#pragma mark---实现UITableViewDataSource，UITableViewDelegate方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 90;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    //给cell的数据模型赋值
    
    cell.Model = self.tableArray[indexPath.row];
    
    return cell;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //调用齿轮刷新的滑动事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (decelerate) {
        
        //调用齿轮刷新的拖动结束事件<必须调用 否则无法事件上下拉刷新>
        
        [self.gearPowered scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }

}

#pragma mark ---GearPoweredDelegate

-(void)didLoadData:(id)data{
    
    //清空页数
    
    self.page = 1;
    
    //解析前清空数据原数组
    
    [self.tableArray removeAllObjects];
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //调用数据解析方法
    
    [self NSJSONSerializationWithData:data];
    
}

- (void)didBottomLoadData:(id)data{
    
    //上拉加载返回数据
    
    [self NSJSONSerializationWithData:data];
    
}

-(NSURL *)settingBottomLoadDataURL{
    
    self.page ++;
    
    //设置上拉加载URL (页数+1)
    
    return [NSURL URLWithString:[[NSString stringWithFormat:self.urlStr ,self.page] URLEncodedString]];
    
}


#pragma mark ---LazyLoading

-(NSMutableArray *)tableArray{
    
    if (_tableArray == nil) {
        
        _tableArray = [[NSMutableArray alloc]init];
        
    }
    
    return _tableArray;
}

-(NSMutableArray *)videoArray{
    
    if (_videoArray == nil) {
        
        _videoArray = [[NSMutableArray alloc]init];
        
    }
    
    return _videoArray;
    
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

-(VideoPlayerViewController *)videoPlayerVC{
    
    if (_videoPlayerVC == nil) {
        
        _videoPlayerVC = [[VideoPlayerViewController alloc]init];
        
    }
    
    return _videoPlayerVC;
    
}

-(LXAlertViewController *)lxAlertViewController{
    
    if (_lxAlertViewController == nil) {
        
        _lxAlertViewController = [[LXAlertViewController alloc] init];
        
        _lxAlertViewController.lxAlertViewDelegate = self;
        
    }
    
    
    return _lxAlertViewController;
    
}

-(LoadingView *)loadingView{
    
    if (_loadingView == nil) {
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:self.frame];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = YES;//默认隐藏
        
        //添加到父视图控制器的视图上
        
        [self.superview addSubview:_loadingView];
        
        [self.superview insertSubview:_loadingView aboveSubview:self];
        
    }
    
    return _loadingView;
    
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



#pragma mark ---时间格式转换 将秒转换成指定格式字符串

- (NSString *)getStringWithTime:(NSInteger)time{
    
    NSString *timeString = nil;
    
    NSInteger MM = 0;
    
    NSInteger HH = 0;
    
    if (59 < time) {
        
        MM = time / 60 ;
        
        timeString = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)MM,time - MM * 60];
        
        if (3599 < time) {
            
            HH = time / 3600 ;
            
            timeString = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld", (long)HH , MM > 59 ? MM - 60 : MM ,time - MM * 60];
            
        }
        
    }
    
    return timeString;
    
}


@end
