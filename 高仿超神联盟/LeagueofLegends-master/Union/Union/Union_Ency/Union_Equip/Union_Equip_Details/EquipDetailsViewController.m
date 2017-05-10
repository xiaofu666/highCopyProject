//
//  EquipDetailsViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipDetailsViewController.h"

#import "UIView+Shadow.h"

#import "NSString+GetWidthHeight.h"

#import "PCH.h"

#import "LoadingView.h"

#import "DataCache.h"

#import "EquipDetailsModel.h"

#import "EquipComposeView.h"

@interface EquipDetailsViewController ()

@property (nonatomic ,retain) UIView *navigationView;//导航视图

@property (nonatomic , retain ) UIButton *backButton;//返回按钮

@property (nonatomic , retain ) UILabel *titleLabel;//标题



@property (nonatomic , retain ) UIScrollView *scrollView;//滑动视图

@property (nonatomic , retain ) EquipDetailsModel *model;//数据模型

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@property (nonatomic ,retain) LoadingView *loadingView;//加载视图

@property (nonatomic ,retain) UIImageView *reloadImageView;//重新加载图片视图

@property (nonatomic , retain ) UIView *headerView;//头部视图

@property (nonatomic , retain ) UIView *descriptionView;//描述视图

@property (nonatomic , retain ) EquipComposeView *needView;//需求视图

@property (nonatomic , retain ) EquipComposeView *composeView;//合成视图


@property (nonatomic , retain ) UIImageView *picImageView;//装备图片

@property (nonatomic , retain ) UILabel *nameLabel;//装备名称

@property (nonatomic , retain ) UILabel *priceLabel;//装备价格

@property (nonatomic , retain ) UILabel *descriptionTitleLabel;//描述标题

@property (nonatomic , retain ) UILabel *descriptionContentLabel;//描述内容


@property (nonatomic , retain ) EquipDetailsViewController *equipDetailsVC;//装备详情视图控制器

@end

@implementation EquipDetailsViewController

-(void)dealloc{
    
    [_navigationView release];
    
    [_backButton release];
    
    [_titleLabel release];
    
    [_scrollView release];
    
    [_loadingView release];
    
    [_manager release];
    
    [_reloadImageView release];
    
    [_model release];
    
    [_headerView release];
    
    [_needView release];
    
    [_descriptionView release];
    
    [_composeView release];
    
    [_picImageView release];
    
    [_nameLabel release];
    
    [_priceLabel release];
    
    [_descriptionContentLabel release];
    
    [_descriptionTitleLabel release];
    
    [_equipDetailsVC release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"装备详情";

    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载导航视图
    
    [self loadNavigationView];
    
    
    //判断是否有导航控制器
    
    if (self.navigationController) {
        
        //添加导航栏左按钮
        
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
        
        leftBarButton.tintColor = [UIColor whiteColor];
        
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
        //不显示导航视图
        
        _navigationView.frame = CGRectMake(_navigationView.frame.origin.x, _navigationView.frame.origin.y, CGRectGetWidth(self.view.frame) , 0);
        
    } else {
        
        //显示导航视图
        
        _navigationView.frame = CGRectMake(_navigationView.frame.origin.x, _navigationView.frame.origin.y, CGRectGetWidth(self.view.frame) , 64);
        
    }
    

    //加载头部视图
    
    [self loadHeaderView];
    
    //加载描述视图
    
    [self loadDescriptionView];
    
    //加载需求视图
    
    [self loadNeedView];
    
    //加载合成视图
    
    [self loadComposeView];
    
    [self.view bringSubviewToFront:_navigationView];
    
}

#pragma mark ---加载导航视图

- (void)loadNavigationView{
    
    //初始化导航视图
    
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 65)];
    
    _navigationView.backgroundColor = MAINCOLOER;
    
    _navigationView.clipsToBounds = YES;
    
    [self.view addSubview:_navigationView];
    

    //初始化返回按钮
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton.backgroundColor = [UIColor clearColor];
    
    _backButton.tintColor = [UIColor whiteColor];
    
    [_backButton setImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    _backButton.frame = CGRectMake(0, 20, 80, 44);
    
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_navigationView addSubview:_backButton];
    
    //初始化标题
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 , 20 , CGRectGetWidth(self.view.frame) - 160 , 44)];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.textColor = [UIColor whiteColor];
    
    _titleLabel.text = @"装备详情";
    
    _titleLabel.autoresizesSubviews = YES;
    
    [_navigationView addSubview:_titleLabel];
    
}

- (void)backButtonAction:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark ---加载头部视图

- (void)loadHeaderView{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_navigationView.frame) - 1, CGRectGetWidth(self.view.frame), 85)];
    
    _headerView.backgroundColor = MAINCOLOER;
    
    //添加阴影
    
    [_headerView dropShadowWithOffset:CGSizeMake(0, 3) radius:5 color:[UIColor darkGrayColor] opacity: 0.7];
    
    [self.view addSubview:_headerView];
    
    
    //初始化装备图片
    
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 64, 64)];
    
    _picImageView.clipsToBounds = YES;
    
    _picImageView.layer.cornerRadius = 10.0f;
    
    [_headerView addSubview:_picImageView];
    
    //初始化装备名称
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, CGRectGetWidth(self.view.frame) - 80 , 30)];
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    _nameLabel.font = [UIFont systemFontOfSize:18];
    
    [_headerView addSubview:_nameLabel];
    
    //初始化价格
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, CGRectGetWidth(self.view.frame) - 80 , 35)];
    
    _priceLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    _priceLabel.font = [UIFont systemFontOfSize:14];
    
    _priceLabel.numberOfLines = 0;
    
    [_headerView addSubview:_priceLabel];

    
    
}

#pragma mark ---加载描述视图

- (void)loadDescriptionView{
    
    _descriptionView = [[UIView alloc]initWithFrame:CGRectMake(10 , 15, CGRectGetWidth(self.view.frame) - 20 , 40)];
    
    _descriptionView.clipsToBounds = YES;
    
    _descriptionView.backgroundColor = [UIColor whiteColor];
    
    //添加阴影
    
    [_descriptionView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity: 0.6f];
    
    [self.scrollView addSubview:_descriptionView];
    
    UIView *descriptionTitleView = [[UIView alloc]initWithFrame:CGRectMake(0 , 15 , 5 , 20)];
    
    descriptionTitleView.backgroundColor = MAINCOLOER;
    
    [_descriptionView addSubview:descriptionTitleView];
    
    //初始化描述标题
    
    _descriptionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10 , 100, 30)];
    
    _descriptionTitleLabel.textColor = [UIColor grayColor];
    
    _descriptionTitleLabel.backgroundColor = [UIColor whiteColor];
    
    _descriptionTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _descriptionTitleLabel.text = @"装备属性";
    
    [_descriptionView addSubview:_descriptionTitleLabel];
    
    //初始化
    
    _descriptionContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, CGRectGetWidth(_descriptionView.frame) - 20 , 0)];
    
    _descriptionContentLabel.numberOfLines = 0;
    
    [_descriptionView addSubview:_descriptionContentLabel];
    
}

#pragma mark ---加载需求视图

- (void)loadNeedView{
    
    _needView = [[EquipComposeView alloc]initWithFrame:CGRectMake(10 , 0, CGRectGetWidth(self.view.frame) - 20 , 120)];
    
    _needView.title = @"合成需求";
    
    __block typeof(self) Self = self;
    
    _needView.selectedImageViewBlock = ^(NSInteger eid){
        
        //跳转装备详情视图控制器
        
        Self.equipDetailsVC.eid = eid;
        
        //判断是否存在导航控制器
        
        if (Self.navigationController) {
            
            [Self.navigationController pushViewController:Self.equipDetailsVC animated:YES];
            
        } else {
            
            [Self presentViewController:Self.equipDetailsVC animated:YES completion:^{
                
            }];
            
        }
        
    };
    
    [self.scrollView addSubview:_needView];
    
}

#pragma mark ---加载合成视图

- (void)loadComposeView{
    
    _composeView = [[EquipComposeView alloc]initWithFrame:CGRectMake(10 , 0, CGRectGetWidth(self.view.frame) - 20 , 120)];
    
    _composeView.title = @"可以合成";
    
    __block typeof(self) Self = self;
    
    _composeView.selectedImageViewBlock = ^(NSInteger eid){
        
        //跳转装备详情视图控制器
        
        Self.equipDetailsVC.eid = eid;
        
        //判断是否存在导航控制器
        
        if (Self.navigationController) {
            
            [Self.navigationController pushViewController:Self.equipDetailsVC animated:YES];
            
        } else {
            
            [Self presentViewController:Self.equipDetailsVC animated:YES completion:^{
                
            }];
            
        }

        
    };
    
    [self.scrollView addSubview:_composeView];
    
}



-(void)setEid:(NSInteger)eid{
    
    if (_eid != eid) {
        
        _eid = eid;
        
    }
    
    //加载数据
    
    [self loadData];
    
}


#pragma mark ---单击重新加载提示图片事件

- (void)reloadImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //重新调用加载数据
    
    [self loadData];
    
}

//加载数据

-(void)loadData{
    
    //隐藏视图
    
    self.descriptionView.hidden = YES;
    
    self.needView.hidden = YES;
    
    self.composeView.hidden = YES;

    
    //请求数据
    
    __block typeof(self) Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[NSString stringWithFormat:kUnion_Equip_DetailsURL , (long)self.eid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //调用数据解析方法
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:[NSString stringWithFormat:@"EquipDetailsData[%ld]" , (long)self.eid] Classify:@"Equip"];
            
        } else {
            
            //显示重新加载提示视图
            
            self.reloadImageView.hidden = NO;
            
        }
        
        //隐藏加载视图
        
        self.loadingView.hidden = YES;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (self.model == nil) {
            
            [UIView addLXNotifierWithText:@"加载失败 快看看网络去哪了" dismissAutomatically:YES];
            
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
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:[NSString stringWithFormat:@"EquipDetailsData[%ld]" , (long)self.eid] Classify:@"Equip"];
    
    if (caCheData == nil) {
        
        //显示加载视图
        
        self.loadingView.hidden = NO;
        
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
        
        //解析前清空数据源数组
        
        [_model release];
        
        _model = nil;
        
        NSDictionary *tempDic = data;
        
        //添加数据 (注意加retain 否则会被自动释放)
        
        
        self.model.eid = [[tempDic valueForKey:@"id"] integerValue];
        
        self.model.name = [[tempDic valueForKey:@"name"] retain];
        
        self.model.equipDescription = [[tempDic valueForKey:@"description"] retain];
        
        self.model.need = [[tempDic valueForKey:@"need"] retain];
        
        self.model.compose = [[tempDic valueForKey:@"compose"] retain];
        
        self.model.extAttrs = [[tempDic valueForKey:@"extAttrs"] retain];
        
        self.model.price = [[tempDic valueForKey:@"price"] integerValue];
        
        self.model.allPrice = [[tempDic valueForKey:@"allPrice"] integerValue];
        
        self.model.sellPrice = [[tempDic valueForKey:@"sellPrice"] integerValue];
        
        
        
        //加载数据到控件上
        
        [self loadDataToViewWithModel:self.model];
        

    }
    
}

//加载数据到控件上

- (void)loadDataToViewWithModel:(EquipDetailsModel *)model{
    
    //拼接装备图片url
    
    NSString *picURL = [NSString stringWithFormat:kUnion_Equip_ListImageURL , (long)model.eid];
    
    //SDWebImage 异步请求加载装备图片 <根据装备ID为参数>
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
    
    self.nameLabel.text = model.name;
    
    self.priceLabel.text = [NSString stringWithFormat:@"合成价格:%ld 总价格:%ld\n出售价格:%ld" , (long)model.price , (long)model.allPrice , (long)model.sellPrice ];
    
    //计算描述内容所需高度
    
    CGFloat height = [NSString getHeightWithstring:model.equipDescription Width:CGRectGetWidth(self.descriptionContentLabel.frame) - 30 FontSize:16] + 20;
    
    self.descriptionContentLabel.frame = CGRectMake(self.descriptionContentLabel.frame.origin.x, self.descriptionContentLabel.frame.origin.y, CGRectGetWidth(self.descriptionContentLabel.frame), height);
    
    self.descriptionContentLabel.text = model.equipDescription;
    
    self.descriptionView.frame = CGRectMake(self.descriptionView.frame.origin.x, self.descriptionView.frame.origin.y , CGRectGetWidth(self.descriptionView.frame), self.descriptionContentLabel.frame.origin.y + self.descriptionContentLabel.frame.size.height + 20 );
    
    [self.descriptionView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity: 0.6f];
    
    self.descriptionView.hidden = NO;
    
    
    //设置合成需求视图
    
    if (model.needArray != nil && model.needArray.count >=1 && ![[model.needArray objectAtIndex:0] isEqualToString:@""]) {
        
        self.needView.frame = CGRectMake(self.needView.frame.origin.x, self.descriptionView.frame.origin.y + CGRectGetHeight(self.descriptionView.frame) + 15, CGRectGetWidth(self.needView.frame), 120);
        
        self.needView.hidden = NO;
        
        self.needView.equipIDArray = model.needArray;
        
    } else {
        
        self.needView.hidden = YES;
        
        self.needView.frame = CGRectMake(self.needView.frame.origin.x, self.descriptionView.frame.origin.y + CGRectGetHeight(self.descriptionView.frame) , CGRectGetWidth(self.needView.frame), 0);
        
    }
    
    [self.needView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity: 0.6f];
    
    
    //设置可以合成视图
    
    if (model.composeArray != nil && model.composeArray.count >=1 && ![[model.composeArray objectAtIndex:0] isEqualToString:@""]) {
        
        self.composeView.frame = CGRectMake(self.composeView.frame.origin.x, self.needView.frame.origin.y + CGRectGetHeight(self.needView.frame) + 15, CGRectGetWidth(self.composeView.frame), 120);
        
        self.composeView.hidden = NO;
        
        self.composeView.equipIDArray = model.composeArray;
        
    } else {
        
        self.composeView.hidden = YES;
        
        self.composeView.frame = CGRectMake(self.composeView.frame.origin.x, self.needView.frame.origin.y + CGRectGetHeight(self.needView.frame) , CGRectGetWidth(self.composeView.frame), 0);
        
    }
    
    [self.composeView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity: 0.6f];
    
    
    //设置滑动视图内容大小
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.descriptionView.frame) + CGRectGetHeight(self.needView.frame) + CGRectGetHeight(self.composeView.frame) + self.descriptionView.frame.origin.y + 60);
    
    
}

#pragma mark ---leftBarButtonAction

- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ---LazyLoading

-(UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , _headerView.frame.origin.y + CGRectGetHeight(_headerView.frame) , CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame) - CGRectGetHeight(_headerView.frame) - 64 )];
        
        _scrollView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
        
        [self.view addSubview:_scrollView];
        
        [self.view bringSubviewToFront:self.headerView];
        
    }
    
    return _scrollView;
    
}

-(EquipDetailsModel *)model{
    
    if (_model == nil) {
        
        _model = [[EquipDetailsModel alloc]init];
        
    }
    
    return _model;
    
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

#pragma mark ---当前viewcontroller支持哪些转屏方向

-(NSUInteger)supportedInterfaceOrientations{
    
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark ---设置电池条前景部分样式类型 (白色)

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}


@end
