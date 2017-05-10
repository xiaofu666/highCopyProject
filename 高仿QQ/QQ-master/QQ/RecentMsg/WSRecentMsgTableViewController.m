//
//  WSRecentMsgTableViewController.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSRecentMsgTableViewController.h"
#import "WSRecentMsgTableViewCell.h"
#import "WSChatTableViewController.h"
#import "ODRefreshControl.h"


#define kReusedID        (@"reused")

#define kHeightTableViewCell  (60)

#define kSetTableView(tableView)   {\
  [tableView registerClass:[WSRecentMsgTableViewCell class] forCellReuseIdentifier:kReusedID];\
   tableView.rowHeight = kHeightTableViewCell;\
   tableView.separatorStyle = UITableViewCellSeparatorStyleNone;}

#define kTintColorSegement     ([UIColor colorWithRed:0.831 green:0.941 blue:0.980 alpha:1])


@interface WSRecentMsgTableViewController ()<UISearchDisplayDelegate>
{
    UISearchDisplayController *msearchDisplay;
    
    /**
     *  @brief  下拉刷新控件
     */
    ODRefreshControl *mRefreshControl;
}

@property(nonatomic,strong)NSMutableArray *DataSource;

@end

@implementation WSRecentMsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    for (int i=0; i<20; i++)
    {
        [self.DataSource addObject:@""];
    }
    
    self.title = @"消息";
    
    mRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    
    [mRefreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    searchBar.placeholder = @"搜索";

    self.tableView.tableHeaderView = searchBar;
    
     msearchDisplay= [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    msearchDisplay.searchResultsDataSource = self;
    msearchDisplay.searchResultsDelegate = self;
   
    kSetTableView(msearchDisplay.searchResultsTableView);

    kSetTableView(self.tableView);
    
    
    UISegmentedControl *segement = [[UISegmentedControl alloc]initWithItems:@[@" 消息 ",@" 电话 "]];
    segement.tintColor = kTintColorSegement;
    [segement addTarget:self action:@selector(seggementValueChanged) forControlEvents:UIControlEventValueChanged];
    segement.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segement;
    
}

-(void)dropViewDidBeginRefreshing:(ODRefreshControl*)refresh
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
    
        [mRefreshControl endRefreshing];

    });
}

/**
 *  @brief  Segement 变化
 */
-(void)seggementValueChanged
{
    
}

#pragma mark --TableView Delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataSource.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSRecentMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedID forIndexPath:indexPath];


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatTableViewController *chat = [[WSChatTableViewController alloc]init];
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSMutableArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    _DataSource = @[].mutableCopy;
    
    return _DataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
