//
//  SmartbiAdaHomeViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/16.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaHomeViewController.h"
#import "JGProgressHUD.h"
#import "SmartbiAdaHome.h"
#import "SmartbiAdaHomeTableViewCell.h"
#import "AFNetworking.h"
#import "config__api.h"
#import "SmartbiAdaWriteViewController.h"
#import "SmartbiAdaNavigationController.h"
#import "SmartbiAdaPersonViewController.h"
#import "MJRefresh.h"
#import "SmartbiAdaHomeDetailViewController.h"
#import "SmartbiAdaPerson.h"
#import "SmartbiAdaPerson+SmartbiAdaDatabaseOperation.h"
#import "UIImageView+WebCache.h"
#import "SmartbiAdaHome+SmartbiAdaDatabaseOperation.h"

@interface SmartbiAdaHomeViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) JGProgressHUD *messageHUD;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger message_cursor;
@property (nonatomic,assign) BOOL isDown;

@property (nonatomic,strong) SmartbiAdaPerson * person;
@property (nonatomic,strong) UIBarButtonItem *left;
@end

@implementation SmartbiAdaHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SmartbiAdaHome fetchApplicationsFromDatabaseComplection:^(NSArray *results) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:results];
        [self.tableView reloadData];
    }];
    [self createUI];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self fetchDataFromServer];
}

-(void)createUI{
    //导航条的内容
    UIColor *titleColor = [UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
   self.left =[[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self     action:@selector(personDetail)];
    [self.left setImage:[[UIImage imageNamed:@"defaulthead"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.left.tintColor=titleColor;
    
    self.navigationItem.leftBarButtonItem=self.left;
    
    
    
//    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"submission"] style:UIBarButtonItemStylePlain target:self     action:@selector(write)];
//    right.tintColor=titleColor;
//    //    [right setImage:[UIImage imageNamed:@"submission"]];
//    self.navigationItem.rightBarButtonItem=right;
    
    //    self.view.backgroundColor=[UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"首页";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0]}];
    
    
    
    
    //tableView的内容
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SmartbiAdaHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
  
    
    //上拉、下拉的有关刷新
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //获取最新的数据  偏移量设置成0
        self.message_cursor = 0;
        
        //设置下拉标识 YES为下拉  NO为上拉
        self.isDown = YES;
        
        [self fetchDataFromServer];
    }];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.message_cursor+=30;
        self.isDown=NO;
        [self fetchDataFromServer];
    }];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(revMsg) name:@"SmartbiAdaPerson" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)revMsg
{

    [SmartbiAdaPerson fetchApplicationsFromDatabaseComplection:^(NSArray *results) {
        if (results.count >0) {
            self.person=results[0];
        }
    }];
    if ((unsigned long)self.person.nickname.length > 0) {
        [self.left setImage:[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.person.figureurl_qq_1]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else
    {
        UIColor *titleColor = [UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
        [self.left setImage:[[UIImage imageNamed:@"defaulthead"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        self.left.tintColor=titleColor;
    }
    
//      NSLog(@"我收到通知了");
}
-(void)personDetail{
    self.tabBarController.selectedIndex=3.0;
//    SmartbiAdaPersonViewController *personVC=[[SmartbiAdaPersonViewController alloc]init];
//    SmartbiAdaNavigationController *nav=[[SmartbiAdaNavigationController alloc]initWithRootViewController:personVC];
//    [self presentViewController:personVC animated:YES completion:nil];
}
-(void)write{
    SmartbiAdaWriteViewController *writeVC=[[SmartbiAdaWriteViewController alloc]init];
     SmartbiAdaNavigationController *nav=[[SmartbiAdaNavigationController alloc]initWithRootViewController:writeVC];
// [self.navigationController pushViewController:writeVC animated:YES];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 3.0;
    NSLog(@"self.dataSource.count:%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SmartbiAdaHome *home=self.dataSource[indexPath.row];
    return [home.contentSize floatValue]+ [home.pictureSize floatValue]+[home.videoSize floatValue] + 154;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    SmartbiAdaHome *itemData = self.dataSource[indexPath.row];
    [cell refreshUI:itemData];
    
    return cell;
}
// 点击Cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaHomeDetailViewController *homeDetailVC=[[SmartbiAdaHomeDetailViewController alloc]init];
    
    homeDetailVC.shareUrl=[self.dataSource[indexPath.row] share_url];
//    NSLog(@"homeDetailVC.shareUrl==%@",homeDetailVC.shareUrl);
    [self.navigationController pushViewController:homeDetailVC animated:YES];
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
    
    [manager GET:[NSString stringWithFormat:@"%@%ld%@",HOME__PICTURE,self.message_cursor,HOME_PICTURE_SUB] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //停止加载动画
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.isDown==YES) {
            self.isDown=NO;
            [self.dataSource removeAllObjects];
        }
        [SmartbiAdaHome deleteAllComplection:^(BOOL results) {
//            NSLog(@"只能存储30条数据");
        }];
        for (NSDictionary *key in jsonObj[@"data"][@"data"]) {
            SmartbiAdaHome *home=[SmartbiAdaHome initWithDictionry:key];
            if(home.name.length>0){
                [self.dataSource addObject:home];
                [home saveToDatabaseComplection:^(BOOL ret) {
//                    if (ret==YES) {
//                        NSLog(@"home数据模型保存到数据库成功");
//                    }
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

- (JGProgressHUD *)messageHUD
{
    if (_messageHUD == nil) {
        _messageHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
        _messageHUD.textLabel.text = @"正在加载数据...";
    }
    
    return _messageHUD;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _tableView;
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

