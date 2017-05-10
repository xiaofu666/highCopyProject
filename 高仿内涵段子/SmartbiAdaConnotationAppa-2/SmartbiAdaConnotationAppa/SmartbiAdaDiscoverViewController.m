//
//  SmartbiAdaDiscoverViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//
#import "SmartbiAdaHomeViewController.h"
#import "JGProgressHUD.h"
#import "SmartbiAdaHome.h"
#import "SmartbiAdaDiscoverTableViewCell.h"
#import "AFNetworking.h"
#import "config__api.h"
#import "SmartbiAdaWriteViewController.h"
#import "SmartbiAdaNavigationController.h"
#import "SmartbiAdaPersonViewController.h"
#import "SmartbiAdaDiscoverViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SmartbiAdaDiscoverDetailViewController.h"
#import "SmartbiAdaHome+SmartbiAdaDatabaseOperationVideo.h"
#import "MJRefresh.h"


@interface SmartbiAdaDiscoverViewController ()<UITableViewDataSource,UITableViewDelegate,SmartbiAdaDiscoverTableViewCellDeledate>

@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) JGProgressHUD *messageHUD;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger message_cursor;
@property (nonatomic,assign) BOOL isDown;

@end

@implementation SmartbiAdaDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [SmartbiAdaHome fetchApplicationsFromDatabaseVideoComplection:^(NSArray *results) {
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
    //    self.title = @"发现";
    self.title=@"视频";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0]}];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SmartbiAdaDiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"discoverCell"];
    
    
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

    
}
-(void)cell:(SmartbiAdaDiscoverTableViewCell *)cell buttonDidClicked:(UIButton *)btn index:(NSInteger)btnIndex{
    
    NSString *str = cell.mp4_url;
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //AVPlayer
    //AVPlayViewController
    //音频 视频
//    NSLog(@"###%@",str);
    MPMoviePlayerViewController *mediaPlayerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:str]];
    [self presentViewController:mediaPlayerVC animated:YES completion:^{
        
    }];
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 3.0;
    //    NSLog(@"self.dataSource.count:%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SmartbiAdaHome *home=self.dataSource[indexPath.row];
    return [home.contentSize floatValue]+ [home.video_height floatValue] + 154;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaDiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discoverCell" forIndexPath:indexPath];
    cell.delegate=self;
    SmartbiAdaHome *itemData = self.dataSource[indexPath.row];
    [cell refreshUI:itemData];
    
    //    cell.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1.0f];
    //    cell.textLabel.text=@"123";
    return cell;
}
// 点击Cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaDiscoverDetailViewController *discoverDetailVC=[[SmartbiAdaDiscoverDetailViewController alloc]init];
    
    discoverDetailVC.shareUrl=[self.dataSource[indexPath.row] share_url];
    [self.navigationController pushViewController:discoverDetailVC animated:YES];
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
    
    [manager GET:[NSString stringWithFormat:@"%@%ld%@",HOME__VIDEO,self.message_cursor,HOME__VIDEO__SUB] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //停止加载动画
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.isDown==YES) {
            self.isDown=NO;
            [self.dataSource removeAllObjects];
        }
        
        [SmartbiAdaHome deleteAllVideoComplection:^(BOOL results) {
//             NSLog(@"SmartbiAdaHomeVideo只能存储30条数据");
        }];
        for (NSDictionary *key in jsonObj[@"data"][@"data"]) {
            SmartbiAdaHome *home=[SmartbiAdaHome initWithDictionry:key];
            if(home.name.length>0){
                if (home.large_cover.length>0) {
                    [self.dataSource addObject:home];
                    [home saveToDatabaseVideoComplection:^(BOOL ret) {
                        if (ret==YES) {
//                            NSLog(@"home数据模型保存到数据库成功");
                        }
                    }];
                }
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


