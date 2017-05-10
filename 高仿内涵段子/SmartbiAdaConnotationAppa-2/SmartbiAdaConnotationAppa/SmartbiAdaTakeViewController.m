//
//  SmartbiAdaTakeViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaTakeViewController.h"
#import "JGProgressHUD.h"
#import "AFNetworking.h"
#import "config__api.h"

#import "SmartbiAdaPersonViewController.h"
#import "SmartbiAdaWriteViewController.h"
#import "SmartbiAdaNavigationController.h"
#import "SmartbiAdaFind.h"
#import "SmartbiAdaFindTableViewCell.h"
#import "SmartbiAdaTakeDetailViewController.h"
#import "SmartbiAdaNavWhite.h"
#import "SmartbiAdaFind+SmartbiAdaDatabaseOperation.h"



@interface SmartbiAdaTakeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


//@property (strong, nonatomic)  UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) JGProgressHUD *messageHUD;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong)  NSMutableArray *bannerSource;
@property (nonatomic, assign) NSInteger message_cursor;
@property (nonatomic, assign) BOOL isDown;


@property (nonatomic,strong) UIScrollView *scView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger page;

@end

@implementation SmartbiAdaTakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f==%f",kScreenWidth,kScreenHeight);
    [SmartbiAdaFind fetchApplicationsFromDatabaseComplection:^(NSArray *results) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:results];
        [self.tableView reloadData];
    }];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SmartbiAdaFindTableViewCell" bundle:nil] forCellReuseIdentifier:@"findCell"];
    
    [self createUI];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchDataFromServer];
}

-(void)createUI{
    //导航条的内容
//    UIColor *titleColor = [UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
   
//    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"defaulthead"] style:UIBarButtonItemStylePlain target:self     action:@selector(person)];
//    [left setImage:[[UIImage imageNamed:@"defaulthead"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    left.tintColor=titleColor;
//    self.navigationItem.leftBarButtonItem=left;
    
    
    
//    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"submission"] style:UIBarButtonItemStylePlain target:self     action:@selector(write)];
//    right.tintColor=titleColor;
//    //    [right setImage:[UIImage imageNamed:@"submission"]];
//    self.navigationItem.rightBarButtonItem=right;
    
    //    self.view.backgroundColor=[UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"发现";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0]}];
    
 
    
//    NSArray *arr=@[@"http://p3.pstatp.com/origin/2b600261133753188c4",@"http://p3.pstatp.com/origin/2b700261500919464a9"];
//    NSArray *imageArr=@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.bannerSource[1] banner_url]]]],[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.bannerSource[0] banner_url]]]],[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.bannerSource[1] banner_url]]]],[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.bannerSource[0] banner_url]]]]];
    
    NSArray *arr=@[@"http://s0.pstatp.com/site/image/joke_zone/makeup_841828.jpg",@"http://p3.pstatp.com/origin/2b700261500919464a9"];
    NSArray *imageArr=@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arr[1]]]],[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arr[0]]]],[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arr[1]]]],[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arr[0]]]]];
    
    for (NSInteger i=0; i<4; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 200)];
        imageView.image=imageArr[i];
        [self.scView addSubview:imageView];

    }
    self.scView.contentSize=CGSizeMake(4*kScreenWidth, 200);
    [self.scView setContentOffset:CGPointMake(kScreenWidth, 0)];
    self.scView.pagingEnabled=YES;
    self.scView.bounces=NO;
    self.scView.delegate=self;
    self.scView.showsHorizontalScrollIndicator=NO;
    self.scView.showsVerticalScrollIndicator=NO;

    [self.tableView addSubview:self.scView];//UIEdgeInsets
    [self.tableView sendSubviewToBack:self.scView];
    self.tableView.contentInset = UIEdgeInsetsMake(264, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.pageControl.numberOfPages=2;
    self.pageControl.currentPage=0;
    self.pageControl.backgroundColor=[UIColor clearColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    [self.pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
 
//    [self.tableView addSubview:self.pageControl];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    self.page=1;
 }

-(void)timer:(NSTimer*)t
{
    self.page++;
    if (self.page>2) {
        self.page=1;
        //归零
        [self.scView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    [self.scView setContentOffset:CGPointMake(_page *kScreenWidth, 0) animated:YES];
    //修改页码
    _pageControl.currentPage = self.page - 1;
}

//如果有timer timer让scrollView滚动的时候 是不会走这个代理方法的,所以要手动调用这个方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        return;
    }
    
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    if(index < 1)
    {
        //到了第一页,回到最后一页
        [scrollView setContentOffset:CGPointMake(kScreenWidth * 2, 0) animated:NO];
    }
    if(index > 2)
    {
        //到了最后一页,回到第一页
        [scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    }
    //因为位置发生改变,所以要再取一次
    int offsetIndex2 = scrollView.contentOffset.x / kScreenWidth;
    _pageControl.currentPage = offsetIndex2 - 1;
}


-(void)pageClick:(UIPageControl*)p{
    //    NSLog(@"%ld",p.currentPage);
    [self.scView setContentOffset:CGPointMake(p.currentPage * [UIScreen mainScreen].bounds.size.width+[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
}

-(void)person{
    SmartbiAdaPersonViewController *personVC=[[SmartbiAdaPersonViewController alloc]init];
    //    SmartbiAdaNavigationController *nav=[[SmartbiAdaNavigationController alloc]initWithRootViewController:personVC];
    [self presentViewController:personVC animated:YES completion:nil];
}
-(void)write{
    SmartbiAdaWriteViewController *writeVC=[[SmartbiAdaWriteViewController alloc]init];
    SmartbiAdaNavigationController *nav=[[SmartbiAdaNavigationController alloc]initWithRootViewController:writeVC];
    // [self.navigationController pushViewController:writeVC animated:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 3.0;
    //    NSLog(@"self.dataSource.count:%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    SmartbiAdaFind *home=self.dataSource[indexPath.row];
//    return home.contentSize.height+ home.pictureSize+home.videoSize.height + 145;
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaFindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"findCell" forIndexPath:indexPath];
    
    SmartbiAdaFind *itemData = self.dataSource[indexPath.row];
    [cell refreshUI:itemData];
    
    //    cell.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1.0f];
    //    cell.textLabel.text=@"123";
    return cell;
}
// 点击Cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaTakeDetailViewController *takeDetail=[[SmartbiAdaTakeDetailViewController alloc]init];
    takeDetail.find=self.dataSource[indexPath.row];
//    SmartbiAdaNavWhite *whiteNav=[[SmartbiAdaNavWhite alloc]initWithRootViewController:takeDetail];
//     [self presentViewController:whiteNav animated:YES completion:nil];
    [self.navigationController pushViewController:takeDetail animated:YES];
//    self.navigationController.navigationBarHidden=YES;
//    SmartbiAdaHomeDetailViewController *homeDetailVC=[[SmartbiAdaHomeDetailViewController alloc]init];
//    
//    homeDetailVC.shareUrl=[self.dataSource[indexPath.row] share_url];
//    [self.navigationController pushViewController:homeDetailVC animated:YES];
    // 跳转
    //    QFAppDetailViewController *detailVC = [[QFAppDetailViewController alloc] initWithNibName:@"QFAppDetailViewController" bundle:nil];
    // 跳转到详情页之后隐藏Tabbar
    //    detailVC.hidesBottomBarWhenPushed = YES;
    
    // 把点击行对应的App的模型传给下一个页面
    //    detailVC.app = self.dataSource[indexPath.row];
    
    //    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - Helper Methods

- (void)fetchDataFromServer
{
    CGRect destRect = self.view.frame;
    destRect.origin = CGPointMake(0, -64);
    destRect.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+64);
    [self.messageHUD showInRect:destRect inView:self.view animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:@"%@",FIND__CELL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        for(NSDictionary *key in jsonObj[@"data"][@"rotate_banner"][@"banners"]){
            SmartbiAdaFind *find=[SmartbiAdaFind bannerInitWithDictionry:key];
            if(find.banner_title.length>0)
            {
                [self.bannerSource addObject:find];
            }
        }
        [SmartbiAdaFind deleteAllComplection:^(BOOL results) {
//             NSLog(@"SmartbiAdaFind只能存储30条数据");
        }];
        for (NSDictionary *key in jsonObj[@"data"][@"categories"][@"category_list"]) {
            SmartbiAdaFind *find=[SmartbiAdaFind initWithDictionry:key];
            if(find.name.length>0){
                [self.dataSource addObject:find];
                [find saveToDatabaseComplection:^(BOOL ret) {
                    if (ret==YES) {
//                        NSLog(@"find数据模型保存到数据库成功");
                    }
                }];
            }
        }
        
        [self.tableView reloadData];
        [self.messageHUD dismissAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [self.messageHUD dismissAnimated:YES];
    }];
}


#pragma mark - Getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}
-(NSMutableArray *)bannerSource
{
        if(_bannerSource==nil)
        {
            _bannerSource=[[NSMutableArray alloc]init];
        }
    return _bannerSource;
}

- (JGProgressHUD *)messageHUD
{
    if (_messageHUD == nil) {
        _messageHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
        _messageHUD.textLabel.text = @"正在加载数据...";
    }
    
    return _messageHUD;
}
//-(UITableView *)tableView{
//    if (_tableView == nil) {
//        _tableView=[[UITableView alloc]initWithFrame:kScreenBounds];
//    }
//    return _tableView;
//}

-(UIScrollView *)scView{
    if (_scView ==nil) {
        _scView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -200, kScreenWidth, 200)];
        
    }
    return _scView;
}
-(UIPageControl *)pageControl{
    if (_pageControl ==nil) {
        _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth-120, 68, 160, 40)];
    }
    return _pageControl;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
