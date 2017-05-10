//
//  Union_News_Pictures_Scroll_ViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_News_Pictures_Scroll_ViewController.h"

#import "Union_NewsViewController.h"

#import "PCH.h"

#import "LoadingView.h"

#import "NSString+URL.h"

#import "Pictures_Sroll_CollectionViewCell.h"

#import "Pictures_Sreoll_Model.h"

#import <MBProgressHUD.h>





@interface Union_News_Pictures_Scroll_ViewController()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,MBProgressHUDDelegate>

@property (nonatomic, retain) UICollectionView *collectionView; //集合视图

@property (nonatomic, retain) UIView *topView; //顶部透明视图

@property (nonatomic, retain) UIView *bottomView; //底部透明视图

@property (nonatomic , retain) UIButton *backButton;//返回按钮

@property (nonatomic , retain) UIButton *saveButton;//保存按钮

@property (nonatomic, retain) UILabel *titleLable; //标题

@property (nonatomic, retain) UILabel *pageLable;  //显示页码

@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic , retain) LoadingView *loadingView;//加载视图

@property (nonatomic , retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic , assign) NSInteger itemIndex;//下标

@property (nonatomic, retain) UIImage *saveImage; //保存的图片

@end

@implementation Union_News_Pictures_Scroll_ViewController


-(void)dealloc {
    
    [_bottomView release];
    
    [_topView release];
    
    [_pageLable release];
    
    [_titleLable release];
    
    [_backButton release];
    
    [_saveButton release];
    
    [_flowLayout release];
    
    [_pictruesString release];
    
    [_pictureArray release];
    
    [_manager release];
    
    [_loadingView release];
    
    [_reloadImageView release];
    
    [_saveImage release];
    
    [super dealloc];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加视图
    
    [self addCollectionView];
    
    
    //添加顶部和底部视图
    
    [self loadCanHiddenView];
    
    
    //添加单击方法和缩放
    
    [self addTapGestureRecognizerAndZoom];
    
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    _topView.frame =  CGRectMake(0, 0, self.view.frame.size.width, 64);
    
    _bottomView.frame = CGRectMake(0, self.view.frame.size.height - 70 , self.view.frame.size.width , 70);
    
    _backButton.frame = CGRectMake(0, 20 , 60 , 50);
    
    _saveButton.frame = CGRectMake(CGRectGetWidth(_topView.frame) - 80 , 20 , 80 , 44);
    
    _titleLable.frame = CGRectMake(0, 0 , self.view.frame.size.width, 30);
    
    _pageLable.frame = CGRectMake(0, 30 ,self.view.frame.size.width, 40);
    
    _collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    _flowLayout.itemSize = CGSizeMake(self.view.frame.size.width , self.view.frame.size.height);

    [_collectionView setCollectionViewLayout:_flowLayout];
    
}



#pragma maek -----collectionView-----

- (void)addCollectionView{
    
    // 创建flowLayout
    
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置单元格的大小
    
    _flowLayout.itemSize = CGSizeMake(self.view.frame.size.width , self.view.frame.size.height);
    
    
    //设置单元格的左右最小间距
    
    _flowLayout.minimumInteritemSpacing = 0;
    
    //设置单元格的上下最小间距
    
    _flowLayout.minimumLineSpacing = 0;
    
    //设置滑动方向
    
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置边界
    
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //创建集合视图
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.flowLayout];
    
    
    _collectionView.pagingEnabled = YES;
    //集合视图的背景色
    
    _collectionView.backgroundColor = [UIColor blackColor];
    
    // 添加到视图
    
    [self.view addSubview:_collectionView];
    
    _collectionView.minimumZoomScale = 1;
    
    _collectionView.maximumZoomScale = 3;
    
    //设置代理
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    //注册
    
    [_collectionView registerClass:[Pictures_Sroll_CollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    
    
    [_flowLayout release];
    
    [_collectionView release];
    
   }



#pragma mark -----集合视图的代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.pictureArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Pictures_Sroll_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
  
    cell.model = self.pictureArray[indexPath.row];
    
    self.titleLable.text = [NSString stringWithFormat:@" %@",cell.model.picDesc];
    
    self.pageLable.text = [NSString stringWithFormat:@"%ld/%ld",indexPath.item + 1,(unsigned long)self.pictureArray.count];
    
    _itemIndex = indexPath.item;
        
    
    return cell;
}


//cell是否可以被点击

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
    
}




#pragma  mark ---hiddenView

- (void)loadCanHiddenView{
    
    //添加视图顶部半透明视图
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    _topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    [self.view addSubview:_topView];
    
    
    //创建返回按键
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _backButton.frame = CGRectMake(0, 20 , 80 , 44);
    
    _backButton.tintColor = [UIColor whiteColor];
    
    [_backButton setImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [_backButton addTarget:self action:@selector(buttonToNewsView) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView addSubview:_backButton];
    
    //创建保存图片按钮
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _saveButton.frame = CGRectMake(CGRectGetWidth(_topView.frame) - 80 , 20 , 80 , 44);
    
    _saveButton.tintColor = [UIColor whiteColor];
    
    [_saveButton setImage:[[UIImage imageNamed:@"iconfont-xiazaiimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [_saveButton addTarget:self action:@selector(saveImageAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView addSubview:_saveButton];
    
    
    //初始化底部视图
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 70 , self.view.frame.size.width , 70)];
    
    _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    [self.view addSubview:_bottomView];

    
    //初始化标题label
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(_bottomView.frame), 30)];
    
    _titleLable.textAlignment = NSTextAlignmentCenter;
    
    _titleLable.font = [UIFont systemFontOfSize:16];
    
    _titleLable.textColor = [UIColor whiteColor];
    
    _titleLable.backgroundColor = [UIColor blackColor];
    
    _titleLable.alpha = 0.7;
    
    [_bottomView addSubview:_titleLable];
    
    
    //设置页码label
    
    _pageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 30 , CGRectGetWidth(_bottomView.frame), 40)];
    
    _pageLable.textAlignment = NSTextAlignmentLeft;
    
    _pageLable.font = [UIFont systemFontOfSize:17];
    
    _pageLable.textColor = [UIColor whiteColor];
    
    _pageLable.alpha = 0.9;
    
    _pageLable.textAlignment = NSTextAlignmentCenter;
    
    _pageLable.backgroundColor = [UIColor blackColor];
    
    [_bottomView addSubview:_pageLable];
    
    
    [_pageLable release];
    
    [_titleLable release];
    
    [_topView release];
    
    [_bottomView release];
    
    [_backButton release];
    
    [_saveButton release];
    
    
}

#pragma mark ------添加单机隐藏和缩放功能

- (void)addTapGestureRecognizerAndZoom{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewCanHidden:)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tap];
    
    [tap release];
    
}

#pragma mark ---单次点击方法

- (void)tapViewCanHidden:(UITapGestureRecognizer *)sender{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:0.5f animations:^{
    
        Self.topView.alpha = Self.topView.alpha == 0.0f ? 1.0f : 0.0f;
        
        Self.bottomView.alpha = Self.bottomView.alpha == 0.0f ? 1.0f : 0.0f;
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
    
}



#pragma mark ---返回按钮

- (void)buttonToNewsView{
    
    //模态返回
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark ---获取数据

- (void)setPictruesString:(NSString *)pictruesString{
    
    if ( _pictruesString != pictruesString) {
        
        [_pictruesString release];
        
        _pictruesString = [pictruesString retain];
        
    }
    
    //每次更新数据就回到第一个
    
    self.collectionView.contentOffset = CGPointMake(0, 0);
    
    if (pictruesString != nil) {
        
        //清空
        
        //加载数据
        
        [self loadData];
        
    }
    
}



#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

#pragma mark ---加载数据

- (void)loadData{
    
    //解析前清空数据源数组
    
    [self.pictureArray removeAllObjects];
    
    [self.collectionView reloadData];
    
    //显示加载视图
    
    self.loadingView.hidden = NO;
    
    //隐藏重新加载提示视图
    
    self.reloadImageView.hidden = YES;
    
    NSString *url = [self.pictruesString URLEncodedString];
    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET: url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //隐藏重新加载提示视图
        
        Self.reloadImageView.hidden = YES;
        
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
        
        [Self.pictureArray removeAllObjects];
        
        [Self.collectionView reloadData];
        
        //显示重新加载提示视图
        
        Self.reloadImageView.hidden = NO;
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    }];
    
}

#pragma mark ---解析数据

- (void)JSONSerializationWithData:(id)data{

    
    if (data != nil) {
        
        NSDictionary *dic = data;
        
        NSArray *array = [dic valueForKey:@"pictures"];
        
        for (NSDictionary *dic in array){
            
            Pictures_Sreoll_Model *model = [[Pictures_Sreoll_Model alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.pictureArray addObject:model];
        }
        
        //刷新
        
        [self.collectionView reloadData];
        
    }
    
}


#pragma mark ---保存图片事件

- (void)saveImageAction{
    
    Pictures_Sreoll_Model *model = [self.pictureArray objectAtIndex:_itemIndex];
    
    NSURL *url = [NSURL URLWithString:model.url];
    
    //请求网络地址数据的同步方法
    
    //因为这个方法在子线程(全局队列)中执行,所以不需要考虑死线程的问题
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //从内存中查找缓存
    
    if ([manager cachedImageExistsForURL:url]) {
        
        self.saveImage = [[manager imageCache] imageFromMemoryCacheForKey:url.absoluteString];
        
    }else{
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        self.saveImage = [UIImage imageWithData:data];
        
    }
    
    //从硬盘查找缓存
    
//    if ([manager diskImageExistsForURL:url]) {
//    
//        self.saveImage = [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
//   
//    }else{
//       
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        
//        self.saveImage = [UIImage imageWithData:data];
//        
//    }
    
    //存储图片到本地相册
    
    [self saveImageToPhotos:self.saveImage];
    
}

#pragma mark ---存储图片到本地相册

- (void)saveImageToPhotos:(UIImage*)savedImage{
    
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"已成功存入相册" ;
        
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.delegate = self;
    
    hud.labelText = msg;
    
    [hud show:YES];
    
    [hud hide:YES afterDelay:2.0f];

}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    //提示框隐藏时 删除提示框视图
    
    [hud removeFromSuperview];
    
    [hud release];
    
    hud = nil;
}



#pragma mark ---LazyLoading

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

-(LoadingView *)loadingView{
    
    if (_loadingView == nil) {
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
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
        
        _reloadImageView.tintColor = [UIColor whiteColor];
        
        _reloadImageView.backgroundColor = [UIColor clearColor];
        
        [_reloadImageView addGestureRecognizer:reloadImageViewTap];
        
        _reloadImageView.hidden = YES;//默认隐藏
        
        _reloadImageView.userInteractionEnabled = YES;
        
        [self.view addSubview:_reloadImageView];
        
    }
    
    return _reloadImageView;
    
}







//隐藏状态条

- (BOOL)prefersStatusBarHidden
{
    
    return NO;
    
}

#pragma mark ---支持自动旋转

- (BOOL)shouldAutorotate
{
    
    return NO;
    
}

//当前viewcontroller支持哪些转屏方向

-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark ---设置电池条前景部分样式类型 (白色)

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    //清空内存中的图片缓存
    
    [[SDImageCache sharedImageCache] clearMemory];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
