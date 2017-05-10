//
//  Union_Hero_Details_ViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Hero_Details_ViewController.h"

#import "UIView+Shadow.h"

#import "NSString+URL.h"

#import "DataCache.h"

#import "Hero_Details_HeaderView.h"

#import "TabView.h"

#import "LXContextMenuTableView.h"

#import "Hero_Details_DetailsView.h"

#import "Hero_Details_EquipSelectListView.h"

#import "Hero_Details_VideoListView.h"

#import "Hero_Details_RankingListView.h"

#import "EquipSelectDetailsViewController.h"

#import "Hero_Details_BasicModel.h"

#import "Hero_Details_DataModel.h"

#import "Hero_Details_SkillModel.h"

#import "Hero_Details_LikeANDHateModel.h"


#define kContentViewY 200

@interface Union_Hero_Details_ViewController ()<LXContextMenuTableViewDelegate , UIScrollViewDelegate>


@property (nonatomic , retain ) NSMutableDictionary *dataDic;//数据源字典

@property (nonatomic , retain ) UIImageView *backgroundImageView;//背景图片

@property (nonatomic , retain ) UIButton *backButton;//返回按钮

@property (nonatomic , retain ) UIButton *menuButton;//菜单按钮

@property (nonatomic, retain) LXContextMenuTableView* contextMenuTableView;



@property (nonatomic , retain ) Hero_Details_HeaderView *headerView;//顶部视图

@property (nonatomic , retain ) UIImageView *gearBackgroundImageView;//齿轮背景图片视图

@property (nonatomic , retain ) UIImageView *picImageView;//英雄图片视图

@property (nonatomic , retain ) TabView *tabView; //标签导航栏视图

@property (nonatomic , retain ) UIButton *showHeaderButton;//显示顶部视图按钮

@property (nonatomic , assign ) BOOL isShowHeader;//顶部视图是否显示 (YES为显示 NO为已收起)

@property (nonatomic , assign ) BOOL isDismiss;//是否已退出 YES为已经退出 NO为未退出



@property (nonatomic , retain ) UIScrollView *contentView;//内容滑动视图

@property (nonatomic , retain ) Hero_Details_DetailsView *detailsView;//资料详情视图

@property (nonatomic , retain ) Hero_Details_EquipSelectListView *equipSelectListView;//装备选择列表视图

@property (nonatomic , retain ) Hero_Details_RankingListView *rankingListView;//排行列表视图

@property (nonatomic , retain ) Hero_Details_VideoListView *videoListView;//视频列表视图


@property (nonatomic , retain ) AFHTTPRequestOperationManager *manager;//AFNetWorking


@property (nonatomic , retain ) Union_Hero_Details_ViewController *heroDetailsVC; //英雄详情视图控制器

@property (nonatomic , retain) EquipSelectDetailsViewController *equipSelectDetailsVC;//装备选择(出装)详情视图控制器

@end

@implementation Union_Hero_Details_ViewController

-(void)dealloc{
    
    [_enHeroName release];
    
    [_dataDic release];
    
    [_backgroundImageView release];
    
    [_backButton release];
    
    [_menuButton release];
    
    [_contextMenuTableView release];
    
    [_headerView release];
    
    [_gearBackgroundImageView release];
    
    [_picImageView release];
    
    [_tabView release];
    
    [_showHeaderButton release];
    
    [_contentView release];
    
    [_detailsView release];
    
    [_equipSelectListView release];
    
    [_rankingListView release];
    
    [_videoListView release];
    
    [_manager release];
    
    [_heroDetailsVC release];
    
    [_equipSelectDetailsVC release];
    
    [super dealloc];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化设置退出状态默认值
        
        _isDismiss = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //设置默认属性
    
    _isShowHeader = YES;
    
    //加载顶部视图
    
    [self loadHeaderView];
    
    //加载返回按钮
    
    [self loadBackButton];
    
    //加载菜单按钮
    
    [self loadMenuButton];
    
    //加载标签导航视图
    
    [self loadTabView];
    
    //加载英雄头像图片视图部分
    
    [self loadHeroPicImageView];
    
    //加载资料视图
    
    [self loadContentView];
    
    //加载资料详情视图
    
    [self loadDetailsView];
    
    //加载出装列表视图
    
    [self loadEquipSelectListView];
    
    //加载视频列表视图
    
    [self loadVideoListView];
    
    //加载排行列表视图
    
    [self loadRankingListView];
    
    
    [self.view addSubview:self.backgroundImageView];
    
    [self.view sendSubviewToBack:self.backgroundImageView];
    
}

#pragma mark ---加载返回按钮

- (void)loadBackButton{
    
    //初始化返回按钮
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton.backgroundColor = [UIColor clearColor];
    
    _backButton.tintColor = [UIColor whiteColor];
    
    [_backButton setImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    _backButton.frame = CGRectMake(0, 20, 80, 44);
    
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_backButton];
    
}

- (void)backButtonAction:(UIButton *)button{
    
    //判断是否未收起顶部视图
    
    if (_isShowHeader) {
        
        [self endAnimations];
        
        //延迟秒
        
        __block typeof(self) Self = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [Self dismissViewControllerAnimated:NO completion:^{
                
                //执行初始化数据操作
                
                [_headerView initData];
                
            }];
            
        });
        
    } else {
        
        __block typeof(self) Self = self;
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [Self endAnimations];
            
            //执行初始化数据操作
            
            [_headerView initData];
            
        }];
        
    }
    
    //设置已退出状态
    
    _isDismiss = YES;

}

#pragma mark ---加载菜单按钮

- (void)loadMenuButton{
    
    //初始化返回按钮
    
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _menuButton.backgroundColor = [UIColor clearColor];
    
    _menuButton.tintColor = [UIColor whiteColor];
    
    [_menuButton setImage:[[UIImage imageNamed:@"iconfont-gengduo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    _menuButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 80, 20, 80, 44);
    
    [_menuButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_menuButton];

    
}

- (void)menuButtonAction:(UIButton *)button{
    
    // 初始化 LXContextMenuTableView tableView
    
    if (!_contextMenuTableView) {
        
        _contextMenuTableView = [[LXContextMenuTableView alloc]init];
        
        _contextMenuTableView.animationDuration = 0.15;
        
        //设置代理
        
        _contextMenuTableView.LXDelegate = self;
        
        _contextMenuTableView.menuTitles = @[@"",
                            @"英雄皮肤",
                            @"英雄对比",
                            @"英雄改动",
                            @"一周数据",
                            @"英雄配音"];
        
        _contextMenuTableView.menuIcons = @[[[UIImage imageNamed:@"iconfont-guanbianniu"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate],
                           [[UIImage imageNamed:@"iconfont-yingxiongpifu"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate],
                           [[UIImage imageNamed:@"iconfont-yingxiongduibi"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate],
                           [[UIImage imageNamed:@"iconfont-yingxionggaidong"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate],
                           [[UIImage imageNamed:@"iconfont-yingxiongyizhoutubiao"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate],
                           [[UIImage imageNamed:@"iconfont-yingxiongpeiyin"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];

        
    }
    
    // 设置动画 显示
    
    [_contextMenuTableView showInView:self.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
    
}

#pragma mark ---加载顶部视图

- (void)loadHeaderView{
    
    _headerView = [[Hero_Details_HeaderView alloc]initWithFrame:CGRectMake(0 , 0 , CGRectGetWidth(self.view.frame), 64)];

    [self.view addSubview:_headerView];
    
}

#pragma mark ---加载标签导航视图

- (void)loadTabView{
    
    NSArray * tabArray = @[@"资料",@"出装",@"视频",@"排行"];
    
    _tabView = [[TabView alloc]initWithFrame:CGRectMake(100 - self.view.frame.size.width - 100, 160, self.view.frame.size.width - 100, 40)];
    
    _tabView.dataArray = tabArray;
    
    _tabView.backgroundColor = [UIColor whiteColor];
    
    //添加阴影
    
    [_tabView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:[UIColor darkGrayColor] opacity: 0.6];
    
    [self.view addSubview:_tabView];
    
    //block回调
    
    _tabView.returnIndex = ^(NSInteger selectIndex){
        
        //获取选中的下标 并设置内容视图相应的页面显示
        
        _contentView.contentOffset = CGPointMake(CGRectGetWidth(_contentView.frame) * selectIndex, 0);
        
    };
    
    //初始化显示顶部视图按钮
    
    _showHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _showHeaderButton.frame = CGRectMake(self.view.frame.size.width, _tabView.frame.origin.y, 50, 40);
    
    [_showHeaderButton setImage:[[UIImage imageNamed:@"iconfont-hero-details-xia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    _showHeaderButton.tintColor = [UIColor whiteColor];
    
    _showHeaderButton.backgroundColor = [UIColor redColor];
    
    [_showHeaderButton addTarget:self action:@selector(showHeaderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_showHeaderButton];
    
}

//显示顶部视图按钮点击事件

- (void)showHeaderButtonAction:(UIButton *)sender{
    
    //显示顶部视图
    
    [self startShowHeaderViewAnimations];
    
}

#pragma mark ---加载英雄头像图片视图部分

- (void)loadHeroPicImageView{
    
    //齿轮背景图片视图
    
    _gearBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 -20 - 140  , - 6 , 140, 140)];
    
    _gearBackgroundImageView.image = [[UIImage imageNamed:@"GearBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _gearBackgroundImageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_gearBackgroundImageView];
    
    //英雄图片视图
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(picImageViewLongPressAction:)];
    
    longPress.minimumPressDuration=0.5f;//最小时间
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picImageViewTapAction:)];
    
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 82, 82)];
    
    _picImageView.center = _gearBackgroundImageView.center;
    
    _picImageView.backgroundColor = [UIColor lightGrayColor];
    
    _picImageView.clipsToBounds = YES;
    
    _picImageView.layer.cornerRadius = 41;
    
    _picImageView.userInteractionEnabled = YES;
    
    _picImageView.image = [[UIImage imageNamed:@"poluoimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    _picImageView.tintColor = [UIColor lightGrayColor];
    
    [_picImageView addGestureRecognizer:longPress];
    
    [_picImageView addGestureRecognizer:tap];
    
    [self.view addSubview:_picImageView];
    
}

//英雄头像点击响应事件

- (void)picImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //收起顶部视图
    
    [self startHiddenHeaderViewAnimations];
    
}

//英雄头像长按响应事件

- (void)picImageViewLongPressAction:(UILongPressGestureRecognizer *)longPress{
    
    
    
}


#pragma mark ---加载内容视图

- (void)loadContentView{
    
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame), kContentViewY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kContentViewY)];
    
    _contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    _contentView.contentSize = CGSizeMake(CGRectGetWidth(_contentView.frame) * 4, CGRectGetHeight(_contentView.frame));
    
    _contentView.pagingEnabled=YES;
    
    _contentView.directionalLockEnabled=YES;
    
    _contentView.showsHorizontalScrollIndicator=NO;
    
    _contentView.delegate = self;
    
    [self.view addSubview:_contentView];
    
    [self.view sendSubviewToBack:_contentView];
    
}

#pragma mark ---加载资料详情视图

-(void)loadDetailsView{
    
    __block typeof(self) Self = self;
    
    _detailsView = [[Hero_Details_DetailsView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame)) style:UITableViewStylePlain];
    
    _detailsView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    _detailsView.selectedHeroToHeroDetails = ^(NSString *enHeroName){
        
        //跳转英雄详情视图控制器
        
        [Self presentViewController:Self.heroDetailsVC animated:NO completion:^{
            
            Self.heroDetailsVC.enHeroName = enHeroName;
        
        }];
        
    };
    
    [_contentView addSubview:_detailsView];
    
}

#pragma mark ---加载出装列表视图

-(void)loadEquipSelectListView{
    
    __block typeof(self) Self = self;
    
    _equipSelectListView = [[Hero_Details_EquipSelectListView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_contentView.frame) , 0, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame)) style:UITableViewStylePlain];
    
    _equipSelectListView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    _equipSelectListView.selectedEquipSelectDetailsBlock = ^(EquipSelectModel *model){
        
        //模态样式 (判断版本 IOS8.0以上 用UIModalPresentationOverCurrentContext)
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            
            Self.equipSelectDetailsVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }else{
            
            Self.modalPresentationStyle=UIModalPresentationCurrentContext;
            
        }
        
        //传递数据模型 和技能数据数组 跳转出装详情视图控制器
        
        [Self presentViewController:Self.equipSelectDetailsVC animated:NO completion:^{
            
            Self.equipSelectDetailsVC.skillDataArray = [Self.dataDic valueForKey:@"skillArray"];
            
            Self.equipSelectDetailsVC.model = model;

        }];

    };
    
    [_contentView addSubview:_equipSelectListView];
    
}

#pragma mark ---加载视频列表视图

-(void)loadVideoListView{
    
    _videoListView = [[Hero_Details_VideoListView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_contentView.frame) * 2 , 0, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame))];

    _videoListView.rootVC = self;
    
    [_contentView addSubview:_videoListView];

}

#pragma mark ---加载排行列表视图

-(void)loadRankingListView{
    
    _rankingListView = [[Hero_Details_RankingListView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_contentView.frame) * 3 , 0, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame))];
    
    _rankingListView.backgroundColor = [UIColor whiteColor];
    
    [_contentView addSubview:_rankingListView];

}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    //清空内存中的图片缓存
    
    [[SDImageCache sharedImageCache] clearMemory];

}

#pragma mark ---数据处理

-(void)setEnHeroName:(NSString *)enHeroName{
    
    if (_enHeroName != enHeroName) {
        
        [_enHeroName release];
        
        _enHeroName = [enHeroName retain];
        
    }
    
    
    
    //非空判断
    
    if (enHeroName != nil) {
        
        //隐藏详情资料视图
        
        _detailsView.hidden = YES;
        
        //加载缓存数据
        
        [self loadLocallData];
        
        //处理数据
        
        //SDWebImage异步加载英雄头像
        
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:kUnion_Ency_HeroImageURL , enHeroName] URLEncodedString]] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
        
        
        //加载英雄详情数据
        
        [self loadData];
        
        //加载英雄出装列表数据
        
        _equipSelectListView.enHeroName = enHeroName;
        
        //加载视频列表数据
        
        _videoListView.enHeroName = enHeroName;
        
        //加载英雄排行数据
        
        _rankingListView.enHeroName = enHeroName;
        
    }
    
}

#pragma mark ---加载缓存数据

- (void)loadLocallData{
    
    //查询本地缓存 指定数据名
    
    id caCheData = [[DataCache shareDataCache] getDataForDocumentWithDataName:[NSString stringWithFormat:@"HeroDetailsData[%@]" , _enHeroName] Classify:@"Hero"];
    
    if (caCheData == nil) {
        
        
    } else {
        
        //解析数据
        
        [self JSONAnalyticalWithData:caCheData];
        
    }
    
}

#pragma mark ---加载数据

- (void)loadData{
    
    __block typeof(self) Self = self;
    
    //清除之前所有请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作

    [self.manager GET:[[NSString stringWithFormat:kUnion_Ency_HeroDetailsURL , self.enHeroName] URLEncodedString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //解析数据
            
            [Self JSONAnalyticalWithData:responseObject];

            //将数据缓存到本地 指定数据名
            
            [[DataCache shareDataCache] saveDataForDocumentWithData:responseObject DataName:[NSString stringWithFormat:@"HeroDetailsData[%@]" , _enHeroName] Classify:@"Hero"];

            
        } else {
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //重新加载数据
        
        [Self loadData];
        
    }];
    
    
}

#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(id)data{
    
    if (data != nil) {
        
        //清空数据源字典
        
        [self.dataDic removeAllObjects];
        
        NSDictionary *tempDic = data;
        
        //创建基本模型===============
        
        Hero_Details_BasicModel *basicModel = [[Hero_Details_BasicModel alloc]init];
        
        basicModel.hid = [[tempDic valueForKey:@"id"] retain];
        
        basicModel.tags = [[tempDic valueForKey:@"tags"] retain];
        
        basicModel.name = [[tempDic valueForKey:@"name"] retain];
        
        basicModel.title = [[tempDic valueForKey:@"title"] retain];
        
        basicModel.displayName = [[tempDic valueForKey:@"displayName"] retain];
        
        basicModel.price = [[tempDic valueForKey:@"price"] retain];
        
        basicModel.ratingAttack = [[tempDic valueForKey:@"ratingAttack"] retain];
        
        basicModel.ratingDefense = [[tempDic valueForKey:@"ratingDefense"] retain];
        
        basicModel.ratingMagic = [[tempDic valueForKey:@"ratingMagic"] retain];
        
        basicModel.ratingDifficulty = [[tempDic valueForKey:@"ratingDifficulty"] retain];
        
        basicModel.heroDescription = [[tempDic valueForKey:@"description"] retain];
        
        basicModel.tips = [[tempDic valueForKey:@"tips"] retain];
        
        basicModel.opponentTips = [[tempDic valueForKey:@"opponentTips"] retain];
        
        //创建技能数组===============
        
        NSMutableArray *skillArray = [[NSMutableArray alloc]init];
        
        //创建技能临时数组
        
        NSArray *tempSkillArray = @[@"B",@"Q",@"W",@"E",@"R"];
        
        //技能解析
        
        for (NSString *tempSkillItem in tempSkillArray) {
            
            NSString *key = [NSString stringWithFormat:@"%@_%@" , [tempDic valueForKey:@"name"] , tempSkillItem];
            
            NSDictionary *skillDic = [tempDic valueForKey: key];
            
            //创建技能模型
            
            Hero_Details_SkillModel *skillModel = [[Hero_Details_SkillModel alloc]init];
            
            skillModel.sid = [[skillDic valueForKey:@"id"] retain];
            
            skillModel.key = [key retain];
            
            skillModel.name = [[skillDic valueForKey:@"name"] retain];
            
            skillModel.cost = [[skillDic valueForKey:@"cost"] retain];
            
            skillModel.cooldown = [[skillDic valueForKey:@"cooldown"] retain];
            
            skillModel.skillDescription = [[skillDic valueForKey:@"description"] retain];
            
            skillModel.range = [[skillDic valueForKey:@"range"] retain];
            
            skillModel.effect = [[skillDic valueForKey:@"effect"] retain];
            
            //添加到技能数组中
            
            [skillArray addObject:skillModel];
            
        }
        
        
        //创建数据模型===============
        
        Hero_Details_DataModel *dataModel = [[Hero_Details_DataModel alloc]init];
        
        dataModel.range = [[tempDic valueForKey:@"range"] retain];
        
        dataModel.moveSpeed = [[tempDic valueForKey:@"moveSpeed"] retain];
        
        dataModel.armorBase = [[tempDic valueForKey:@"armorBase"] retain];
        
        dataModel.armorLevel = [[tempDic valueForKey:@"armorLevel"] retain];
        
        dataModel.manaBase = [[tempDic valueForKey:@"manaBase"] retain];
        
        dataModel.manaLevel = [[tempDic valueForKey:@"manaLevel"] retain];
        
        dataModel.criticalChanceBase = [[tempDic valueForKey:@"criticalChanceBase"] retain];
        
        dataModel.criticalChanceLevel = [[tempDic valueForKey:@"criticalChanceLevel"] retain];
        
        dataModel.manaRegenBase = [[tempDic valueForKey:@"manaRegenBase"] retain];
        
        dataModel.manaRegenLevel = [[tempDic valueForKey:@"manaRegenLevel"] retain];
        
        dataModel.healthRegenBase = [[tempDic valueForKey:@"healthRegenBase"] retain];
        
        dataModel.healthRegenLevel = [[tempDic valueForKey:@"healthRegenLevel"] retain];
        
        dataModel.magicResistBase = [[tempDic valueForKey:@"magicResistBase"] retain];
        
        dataModel.magicResistLevel = [[tempDic valueForKey:@"magicResistLevel"] retain];
        
        dataModel.healthBase = [[tempDic valueForKey:@"healthBase"] retain];
        
        dataModel.healthLevel = [[tempDic valueForKey:@"healthLevel"] retain];
        
        dataModel.attackBase = [[tempDic valueForKey:@"attackBase"] retain];
        
        dataModel.attackLevel = [[tempDic valueForKey:@"attackLevel"] retain];
        
        
        //创建最佳搭档数组===============
        
        NSMutableArray *likeArray = [[NSMutableArray alloc]init];
        
        for (NSDictionary *templikeDic in [tempDic valueForKey:@"like"]) {
            
            //创建最佳搭档模型
            
            Hero_Details_LikeANDHateModel *likeModel = [[Hero_Details_LikeANDHateModel alloc]init];
            
            likeModel.partner = [[templikeDic valueForKey:@"partner"] retain];
            
            likeModel.des = [[templikeDic valueForKey:@"des"] retain];
            
            [likeArray addObject:likeModel];
            
        }
        
        //创建最佳克制数组===============
        
        NSMutableArray *hateArray = [[NSMutableArray alloc]init];
        
        for (NSDictionary *templikeDic in [tempDic valueForKey:@"hate"]) {
            
            //创建最佳搭档模型
            
            Hero_Details_LikeANDHateModel *hateModel = [[Hero_Details_LikeANDHateModel alloc]init];
            
            hateModel.partner = [[templikeDic valueForKey:@"partner"] retain];
            
            hateModel.des = [[templikeDic valueForKey:@"des"] retain];
            
            [hateArray addObject:hateModel];
            
        }

        
        //添加数据源字典
        
        [self.dataDic setValue:basicModel forKey:@"basicModel"];
        
        [self.dataDic setValue:skillArray forKey:@"skillArray"];
        
        [self.dataDic setValue:dataModel forKey:@"dataModel"];
        
        [self.dataDic setValue:likeArray forKey:@"likeArray"];
        
        [self.dataDic setValue:hateArray forKey:@"hateArray"];
        
        
        //向控件添加数据
        
        [self addDataToViews];
        
        //显示详情资料视图
        
        _detailsView.hidden = NO;
        
    }
    
}

#pragma mark ---向控件添加数据

- (void)addDataToViews{
    
    _headerView.basicModel = [self.dataDic valueForKey:@"basicModel"];
    
    _detailsView.dataDic = self.dataDic;
    
}


#pragma mark ---END数据处理

#pragma mark - LXContextMenuTableViewDelegate

- (void)contextMenuTableView:(LXContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    
    //所选中的菜单选项
    
    switch (indexPath.row) {
        case 0:
            
            //关闭
            
            break;
            
        case 1:
            
            //英雄皮肤
            
            break;
            
        case 2:
            
            //英雄对比
            
            break;
            
        case 3:
            
            //英雄改动
            
            break;
            
        case 4:
            
            //一周数据
            
            break;
            
        case 5:
            
            //英雄配音
            
            break;
            
            
        default:
            
            //未知选项
            
            break;
    }
    
}


#pragma mark - UIScrollViewDelegate

//滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //设置相应的标签导航视图的选中下标
    
    self.tabView.selectIndex = page;
    
}




#pragma mark ---LazyLoading

-(NSMutableDictionary *)dataDic{
    
    if (_dataDic == nil) {
        
        _dataDic = [[NSMutableDictionary alloc]init];
        
    }
    
    return _dataDic;
    
}

-(Union_Hero_Details_ViewController *)heroDetailsVC{
    
    if (_heroDetailsVC == nil) {
        
        _heroDetailsVC = [[Union_Hero_Details_ViewController alloc]init];
        
    }
    
    return _heroDetailsVC;
    
}

-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 16 * 9)];
        
        _backgroundImageView.image = [UIImage imageNamed:@"lollogo"];
        
        _backgroundImageView.alpha = 0.7;
     
        _backgroundImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
        
    }
    
    return _backgroundImageView;
    
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

-(EquipSelectDetailsViewController *)equipSelectDetailsVC{
    
    if (_equipSelectDetailsVC == nil) {
        
        _equipSelectDetailsVC = [[EquipSelectDetailsViewController alloc]init];
        
    }
    
    return _equipSelectDetailsVC;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ---视图即将出现时

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_isDismiss) {
        
        //设置默认显示详情资料视图
        
        if (_tabView != nil) {
            
            _tabView.selectIndex = 0;
            
        }
        
        
        
    }
    
}

#pragma mark ---视图已经出现时

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //判断是否已退出 如果已退出 加载动画 如果未退出 不加载动画
    
    if (_isDismiss) {
        
        [self startAnimations];
        
        //设置未退出状态
        
        _isDismiss = NO;
        
    }
    
    
}

#pragma mark ---视图消失时

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    
}


#pragma mark ---开始动画

- (void)startAnimations{
    
    //设置返回按钮不可点
    
    _backButton.enabled = NO;
    
    _isShowHeader = YES;
    
    __block typeof(self) Self = self;
    
    //顺时针运行齿轮
    
    [_gearBackgroundImageView.layer addAnimation:[self rotationGear: M_PI * 3.0 RepeatCount:2] forKey:@"Rotation"];
    
    [UIView animateWithDuration:0.2f animations:^{
        
        _gearBackgroundImageView.frame = CGRectMake(0 -20 , - 6 , 140, 140);
        
        _picImageView.center = _gearBackgroundImageView.center;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            //推出顶部视图 齿轮旋转随顶部视图移动
            
            _headerView.frame = CGRectMake(0 , 0 , CGRectGetWidth(Self.view.frame), 160);
            
            _gearBackgroundImageView.frame = CGRectMake(0 -20 , CGRectGetHeight(_headerView.frame) - CGRectGetHeight(_gearBackgroundImageView.frame) / 2, 140, 140);
            
            _picImageView.center = _gearBackgroundImageView.center;
            
        } completion:^(BOOL finished) {
            
            //清除顺时针旋转动画 添加逆时针旋转动画
            
            [_gearBackgroundImageView.layer removeAnimationForKey:@"Rotation"];
            
            //逆时针运行齿轮
            
            [_gearBackgroundImageView.layer addAnimation:[Self rotationGear: - M_PI * 3.0 RepeatCount:2] forKey:@"Rotation"];
            
            [UIView animateWithDuration:0.5f animations:^{
                
                //推出标签导航栏
                
                _tabView.frame = CGRectMake(100, 160, Self.view.frame.size.width - 100, 40);
                
                //推出内容视图
                
                _contentView.frame = CGRectMake(0, kContentViewY, CGRectGetWidth(Self.view.frame), CGRectGetHeight(Self.view.frame) - kContentViewY);
                
                _contentView.contentSize = CGSizeMake(CGRectGetWidth(_contentView.frame) * 4, CGRectGetHeight(_contentView.frame));

                //内容视图-资料详情视图尺寸更新
                
                _detailsView.frame = CGRectMake(_detailsView.frame.origin.x, _detailsView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
                
                //内容视图-装备选择视图尺寸更新
                
                _equipSelectListView.frame = CGRectMake(_equipSelectListView.frame.origin.x, _equipSelectListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
                
                //内容视图-视频列表视图尺寸更新
                
                _videoListView.frame = CGRectMake(_videoListView.frame.origin.x, _videoListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
                
                //内容视图-排行列表视图尺寸更新
                
                _rankingListView.frame = CGRectMake(_rankingListView.frame.origin.x, _rankingListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
                
                
            } completion:^(BOOL finished) {
                
                //清除旋转动画
                
                [_gearBackgroundImageView.layer removeAnimationForKey:@"Rotation"];
                
                //设置返回按钮可点
                
                _backButton.enabled = YES;
                
                
            }];
            
        }];
        
        
    }];
    
    
    
}

#pragma mark ---结束动画

- (void)endAnimations{
    
    __block typeof(self) Self = self;
    
    //顺时针运行齿轮
    
    [_gearBackgroundImageView.layer addAnimation:[self rotationGear: M_PI * 3.0 RepeatCount:2] forKey:@"Rotation"];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        //收回标签导航栏
        
        _tabView.frame = CGRectMake(100 - Self.view.frame.size.width - 100 , 160, Self.view.frame.size.width - 100, 40);
        
        //标签导航栏阴影
        
        [_tabView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:[UIColor darkGrayColor] opacity: 0.6];
        
        //收回内容视图
        
        _contentView.frame = CGRectMake(CGRectGetWidth(Self.view.frame), kContentViewY, CGRectGetWidth(Self.view.frame), CGRectGetHeight(Self.view.frame) - kContentViewY);
        
        _contentView.contentSize = CGSizeMake(CGRectGetWidth(_contentView.frame) * 4, CGRectGetHeight(_contentView.frame));
        
        //内容视图-资料详情视图尺寸更新
        
        _detailsView.frame = CGRectMake(_detailsView.frame.origin.x, _detailsView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
        //内容视图-装备选择视图尺寸更新
        
        _equipSelectListView.frame = CGRectMake(_equipSelectListView.frame.origin.x, _equipSelectListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
        //内容视图-视频列表视图尺寸更新
        
        _videoListView.frame = CGRectMake(_videoListView.frame.origin.x, _videoListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
        //内容视图-排行列表视图尺寸更新
        
        _rankingListView.frame = CGRectMake(_rankingListView.frame.origin.x, _rankingListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
    } completion:^(BOOL finished) {
       
        //清除顺时针旋转动画 添加逆时针旋转动画
        
        [_gearBackgroundImageView.layer removeAnimationForKey:@"Rotation"];
        
        //逆时针运行齿轮
        
        [_gearBackgroundImageView.layer addAnimation:[Self rotationGear: - M_PI * 3.0 RepeatCount:2] forKey:@"Rotation"];
        
        [UIView animateWithDuration:0.3f animations:^{
           
            //收回顶部视图以及齿轮视图
            
            _headerView.frame = CGRectMake(0 , 0 , CGRectGetWidth(Self.view.frame), 64);
            
            _gearBackgroundImageView.frame = CGRectMake(0 -20 , - 6 , 140, 140);
            
            _picImageView.center = _gearBackgroundImageView.center;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f animations:^{
                
                _gearBackgroundImageView.frame = CGRectMake(0 -20 - 140 , - 6 , 140, 140);
                
                _picImageView.center = _gearBackgroundImageView.center;
                
            } completion:^(BOOL finished) {
                
                //清除旋转动画
                
                [_gearBackgroundImageView.layer removeAnimationForKey:@"Rotation"];
                
                //显示顶部视图按钮移出
                
                _showHeaderButton.frame = CGRectMake(CGRectGetWidth(Self.view.frame), _tabView.frame.origin.y, CGRectGetWidth(_showHeaderButton.frame), CGRectGetHeight(_tabView.frame));
                
            }];

            
        }];
        
    }];

    
}

#pragma mark ---旋转齿轮动画

-(CABasicAnimation *)rotationGear:(CGFloat)degree RepeatCount:(CGFloat)repeatCount{
    
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat: degree ];
    
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    rotationAnimation.duration = 2;
    
    rotationAnimation.repeatCount = repeatCount;//设置重复次数
    
    rotationAnimation.cumulative = NO;
    
    rotationAnimation.removedOnCompletion = NO;
    
    rotationAnimation.fillMode = kCAFillModeForwards;
    
    return rotationAnimation;
    
}

#pragma mark ---开始收起顶部视图动画

- (void)startHiddenHeaderViewAnimations{
    
    _isShowHeader = NO;
    
    //逆时针运行齿轮
    
    [_gearBackgroundImageView.layer addAnimation:[self rotationGear: - M_PI * 3.0 RepeatCount:2] forKey:@"Rotation"];
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        //齿轮头像移出屏幕
        
        _gearBackgroundImageView.frame = CGRectMake(0 - 140 , CGRectGetHeight(_headerView.frame) - CGRectGetHeight(_gearBackgroundImageView.frame) / 2 , 140, 140);
        
        _picImageView.center = _gearBackgroundImageView.center;
        
        //标签导航栏加长
        
        _tabView.frame = CGRectMake(0 , CGRectGetHeight(_headerView.frame), CGRectGetWidth(Self.view.frame) - CGRectGetWidth(_showHeaderButton.frame) , CGRectGetHeight(_tabView.frame));
        
        //标签导航栏阴影
        
        [_tabView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:[UIColor darkGrayColor] opacity: 0.6];
        
        //显示顶部视图按钮出现
        
        _showHeaderButton.frame = CGRectMake(CGRectGetWidth(Self.view.frame) - CGRectGetWidth(_showHeaderButton.frame), 160, CGRectGetWidth(_showHeaderButton.frame), CGRectGetHeight(_tabView.frame));
        
        
    } completion:^(BOOL finished) {
        
        //清除旋转动画
        
        [_gearBackgroundImageView.layer removeAnimationForKey:@"Rotation"];

        
        [UIView animateWithDuration:0.3f animations:^{
            
            //收回顶部视图
            
            _headerView.frame = CGRectMake(0 , 0 , CGRectGetWidth(Self.view.frame), 64);
            
            //标签导航栏位置升高
            
            _tabView.frame = CGRectMake(0 , CGRectGetHeight(_headerView.frame), CGRectGetWidth(Self.view.frame) - CGRectGetWidth(_showHeaderButton.frame) , CGRectGetHeight(_tabView.frame));
            
            //标签导航栏阴影
            
            [_tabView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:[UIColor darkGrayColor] opacity: 0.6];
            
            //显示顶部视图按钮随标签导航视图升高
            
            _showHeaderButton.frame = CGRectMake(CGRectGetWidth(Self.view.frame) - CGRectGetWidth(_showHeaderButton.frame), CGRectGetHeight(_headerView.frame), CGRectGetWidth(_showHeaderButton.frame), CGRectGetHeight(_tabView.frame));
            
            //内容视图尺寸加长
            
            _contentView.frame = CGRectMake(0 , 104, CGRectGetWidth(Self.view.frame), CGRectGetHeight(Self.view.frame) - 104);
            
            _contentView.contentSize = CGSizeMake(CGRectGetWidth(_contentView.frame) * 4, CGRectGetHeight(_contentView.frame));
            
            //内容视图-资料详情视图尺寸更新
            
            _detailsView.frame = CGRectMake(_detailsView.frame.origin.x, _detailsView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
            
            //内容视图-装备选择视图尺寸更新
            
            _equipSelectListView.frame = CGRectMake(_equipSelectListView.frame.origin.x, _equipSelectListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
            
            //内容视图-视频列表视图尺寸更新
            
            _videoListView.frame = CGRectMake(_videoListView.frame.origin.x, _videoListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
            
            //内容视图-排行列表视图尺寸更新
            
            _rankingListView.frame = CGRectMake(_rankingListView.frame.origin.x, _rankingListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
            
            
        } completion:^(BOOL finished) {
           
            
        }];
        
    }];
    
    
    
}

#pragma mark ---开始推出顶部视图动画

- (void)startShowHeaderViewAnimations{
    
    _isShowHeader = YES;
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        //推出顶部视图
        
        _headerView.frame = CGRectMake(0 , 0 , CGRectGetWidth(Self.view.frame), 160);
        
        //标签导航栏位置降低
        
        _tabView.frame = CGRectMake(0 , CGRectGetHeight(_headerView.frame), CGRectGetWidth(Self.view.frame) - CGRectGetWidth(_showHeaderButton.frame) , CGRectGetHeight(_tabView.frame));
        
        //标签导航栏阴影
        
        [_tabView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:[UIColor darkGrayColor] opacity: 0.6];
        
        //显示顶部视图按钮随标签导航视图降低
        
        _showHeaderButton.frame = CGRectMake(CGRectGetWidth(Self.view.frame) - CGRectGetWidth(_showHeaderButton.frame), CGRectGetHeight(_headerView.frame), CGRectGetWidth(_showHeaderButton.frame), CGRectGetHeight(_tabView.frame));
        
        //内容视图尺寸缩短
        
        _contentView.frame = CGRectMake(0 , kContentViewY, CGRectGetWidth(Self.view.frame), CGRectGetHeight(Self.view.frame) - kContentViewY);
        
        _contentView.contentSize = CGSizeMake(CGRectGetWidth(_contentView.frame) * 4, CGRectGetHeight(_contentView.frame));
        
        //内容视图-资料详情视图尺寸更新
        
        _detailsView.frame = CGRectMake(_detailsView.frame.origin.x, _detailsView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
        //内容视图-装备选择视图尺寸更新
        
        _equipSelectListView.frame = CGRectMake(_equipSelectListView.frame.origin.x, _equipSelectListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
        //内容视图-视频列表视图尺寸更新
        
        _videoListView.frame = CGRectMake(_videoListView.frame.origin.x, _videoListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
        //内容视图-排行列表视图尺寸更新
        
        _rankingListView.frame = CGRectMake(_rankingListView.frame.origin.x, _rankingListView.frame.origin.y, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
        
    } completion:^(BOOL finished) {
        
        //顺时针运行齿轮
        
        [_gearBackgroundImageView.layer addAnimation:[self rotationGear: M_PI * 3.0 RepeatCount:2] forKey:@"Rotation"];
        
        [UIView animateWithDuration:0.3f animations:^{
            
            //齿轮头像出现屏幕
            
            _gearBackgroundImageView.frame = CGRectMake(0 - 20 , CGRectGetHeight(_headerView.frame) - CGRectGetHeight(_gearBackgroundImageView.frame) / 2 , 140, 140);
            
            _picImageView.center = _gearBackgroundImageView.center;
            
            //标签导航栏缩短
            
            _tabView.frame = CGRectMake(100 , CGRectGetHeight(_headerView.frame), CGRectGetWidth(Self.view.frame) - 100, CGRectGetHeight(_tabView.frame));
            
            //标签导航栏阴影
            
            [_tabView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:[UIColor darkGrayColor] opacity: 0.6];
            
            //显示顶部视图按钮移出
            
            _showHeaderButton.frame = CGRectMake(CGRectGetWidth(Self.view.frame), _tabView.frame.origin.y, CGRectGetWidth(_showHeaderButton.frame), CGRectGetHeight(_tabView.frame));
            
            
            
        } completion:^(BOOL finished) {
            
            //清除旋转动画
            
            [_gearBackgroundImageView.layer removeAnimationForKey:@"Rotation"];

            
        }];
        
        
    }];
    
}

#pragma mark ---当前viewcontroller支持哪些转屏方向

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark ---设置电池条前景部分样式类型 (白色)

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}


@end
