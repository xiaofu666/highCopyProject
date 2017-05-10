//
//  Union_EncyViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/6/30.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_EncyViewController.h"

#import "EncyModel.h"

#import "EncyItemView.h"

#import "PictureCycleModel.h"

#import "PictureCycleView.h"


#import "Union_News_Details_ViewController.h"

#import "Union_Hero_ViewController.h"

#import "Union_Equip_Type_List_ViewController.h"

#import "Union_RunesViewController.h"



#define kLightGrayColor [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]


@interface Union_EncyViewController ()

@property (nonatomic , retain) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain) NSMutableArray *itemViewArray;//Item视图数组

@property (nonatomic , retain) UIScrollView *scrollView;//滑动视图

@property (nonatomic , retain) NSMutableArray *pictureArray;//图片数据数组

@property (nonatomic , retain) PictureCycleView *pictureCycleView;//图片轮播视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking


@property (nonatomic , retain) Union_News_Details_ViewController *detailsVC;//资讯详情视图控制器

@property (nonatomic , retain) Union_Hero_ViewController *heroVC;//英雄视图控制器

@property (nonatomic , retain) Union_Equip_Type_List_ViewController *equipTypeListVC;//装备类型列表视图控制器

@property (nonatomic , retain) Union_RunesViewController *runesVC;//符文视图控制器



@end

@implementation Union_EncyViewController

-(void)dealloc{
    
    [_dataArray release];
    
    [_itemViewArray release];
    
    [_scrollView release];
    
    [_pictureCycleView release];
    
    [_pictureArray release];
    
    [_manager release];
    
    [_heroVC release];
    
    [_equipTypeListVC release];
    
    [_detailsVC release];
    
    [_runesVC release];
    
    //移除所有通知监控
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
    
}

//初始化

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //注册通知 获取轮播图片数据数组
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureDataArray:) name:@"PictureDataArray" object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //加载轮播视图
    
    [self loadPictureCycleView];
    
    //加载菜单数据
    
    [self loadMenuData];

}

-(void)setPictureArray:(NSMutableArray *)pictureArray{
    
    if (_pictureArray != pictureArray) {
        
        [_pictureArray release];
        
        _pictureArray = [pictureArray retain];
        
    }
    
    if (pictureArray != nil) {
        
        if (_pictureCycleView != nil) {
            
            //为图片轮播视图添加数据数组
            
            self.pictureCycleView.dataArray = self.pictureArray;
            
        }
    }
    
    
}

//加载轮播视图

- (void)loadPictureCycleView{
    
    //为图片轮播视图添加数据数组
    
    self.pictureCycleView.dataArray = self.pictureArray;

    
    __block typeof(self) Self = self;
    
    self.pictureCycleView.selectedPictureBlock = ^(PictureCycleModel *model){
        
        //跳转相应的详情页面
        
        Self.detailsVC.urlString = [NSString stringWithFormat:@"%@%@",News_WebViewURl,model.pid];
        
        [Self.navigationController pushViewController:Self.detailsVC animated:YES];

    };

    [self.scrollView addSubview:self.pictureCycleView];
    
    //隐藏tabBar
    
    self.detailsVC.hidesBottomBarWhenPushed = YES;
    
}

//发送消息之后  会响应的方法

- (void)pictureDataArray:(NSNotification *)notification
{
    
    self.pictureArray = [notification.userInfo objectForKey:@"pictureArray"];
    
}

//加载菜单数据

- (void)loadMenuData{
    
    
    NSArray *nameArray = @[@"英雄",@"装备",@"天赋",@"符文",@"最佳阵容",@"召唤师技能"];
    
    NSArray *iconArray = @[@"ency_demaxiya",@"ency_nuokesasi",@"ency_aiouniya",@"ency_zhanzhengxueyuan",@"ency_bierjiwote",@"ency_zuoen"];
    
    for (int i = 0 ; i < nameArray.count ; i++) {
        
        EncyModel *encyModel = [[EncyModel alloc]initWithName:nameArray[i] IconName:iconArray[i]];
        
        [self.dataArray addObject:encyModel];
        
    }

    //加载Item视图
    
    [self loadItemView];
    
}

//加载Item视图

- (void)loadItemView{
    
    NSInteger index = 0;
    
    CGFloat itemWidth = (CGRectGetWidth(self.scrollView.frame)) / 3;
    
    CGFloat x = 0;
    
    CGFloat y = CGRectGetHeight(self.pictureCycleView.frame);
    
    for (EncyModel *model in self.dataArray) {
        
        //创建点击手势
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(EncyItemAction:)];
        
        //创建Item视图
        
        EncyItemView *itemView = [[EncyItemView alloc]init];
        
        itemView.model = model;
        
        [itemView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:itemView];
        
        [self.itemViewArray addObject:itemView];
        
        itemView.frame = CGRectMake(x, y, itemWidth, itemWidth);
        
        if (index %2 != 0 ) {
            
            itemView.backgroundColor = kLightGrayColor;
        }
        
        //计算设置位置
        
        if (index == 0) {
            
            itemView.frame = CGRectMake(x, y, itemWidth * 2 , itemWidth * 2);
            
            x += itemWidth * 2;
            
        } else if(index == 1){
            
            y +=itemWidth;
            
        } else {
            
            if (index % 3 == 2) {
                
                x = 0;
                
                y += itemWidth;
                
            } else {
                
                x += itemWidth;
                
            }
            
        }
        
        [itemView release];
        
        index ++;
        
        
    }
    
    //设置滑动视图contentSize
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), y );
    
}


#pragma mark ---Item视图点击响应事件

- (void)EncyItemAction:(UITapGestureRecognizer *)tap{
    
    switch ([self.itemViewArray indexOfObject:tap.view]) {
            
        case 0:
            //英雄
            
            self.heroVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
            
            [self.navigationController pushViewController:self.heroVC animated:YES];
            
            break;
        case 1:
            //装备
            
            self.equipTypeListVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:self.equipTypeListVC animated:YES];
            
            break;
        case 2:
            //天赋
            break;
        case 3:
            //符文
            
            self.runesVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:self.runesVC animated:YES];
            
            break;
        case 4:
            //最佳阵容
            break;
        case 5:
            //召唤师技能
            break;
            
        default:
            break;
    }

    
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



#pragma mark ---LazyLoading

-(UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 113)];
        
        [self.view addSubview:_scrollView];
        
    }
    
    return _scrollView;
    
}

-(NSMutableArray *)itemViewArray{
    
    if (_itemViewArray == nil) {
        
        _itemViewArray = [[NSMutableArray alloc]init];
        
    }
    
    return _itemViewArray;
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
}

-(PictureCycleView *)pictureCycleView{
    
    if (_pictureCycleView == nil) {
        
        //初始化图片轮播视图
        
        _pictureCycleView = [[PictureCycleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetWidth(self.scrollView.frame) / 7 * 4)];
        
        _pictureCycleView.timeInterval = 3.0f;
        
        _pictureCycleView.isPicturePlay = YES;
        
    }
    
    return _pictureCycleView;
    
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

-(Union_News_Details_ViewController *)detailsVC{
    
    if (_detailsVC == nil) {
        
        _detailsVC = [[Union_News_Details_ViewController alloc]init];
        
    }
    
    return _detailsVC;
    
}

-(Union_Hero_ViewController *)heroVC{
    
    if (_heroVC == nil) {
        
        _heroVC = [[Union_Hero_ViewController alloc]init];
        
    }
    
    return _heroVC;
}

-(Union_Equip_Type_List_ViewController *)equipTypeListVC{
    
    if (_equipTypeListVC == nil) {
        
        _equipTypeListVC = [[Union_Equip_Type_List_ViewController alloc]init];
        
    }
    
    return _equipTypeListVC;
    
}

-(Union_RunesViewController *)runesVC{
    
    if (_runesVC == nil) {
        
        _runesVC = [[Union_RunesViewController alloc]init];
        
    }
    
    return _runesVC;
    
}

@end
