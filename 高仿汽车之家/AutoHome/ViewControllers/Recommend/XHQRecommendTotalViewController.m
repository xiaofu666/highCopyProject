//
//  XHQYoujiViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQRecommendTotalViewController.h"

#import "XHQZuiXinModel.h"
#import "XHQZuiXinTableViewCell.h"
#import "XHQDaoGoDescViewController.h"

@interface XHQRecommendTotalViewController ()<UITableViewDataSource,UITableViewDelegate>





@end

@implementation XHQRecommendTotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRefresh];
}
- (void)refreshData
{

    self.page = 1;
    [self customData];
}
- (void)loadMore
{
    self.page += 1;
    [self customData];
}
#pragma mark----------数据请求和解析------------
- (void)customData
{
   
    
    NSString *url = [NSString stringWithFormat:self.path,self.page];
    
    [self request:@"GET" url:url para:nil];
    
    
}
- (void)addRefresh
{
    MJRefreshNormalHeader *heard = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshData];
    }];
    [heard setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [heard setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    [heard setTitle:@"刷新完成" forState:MJRefreshStatePulling];
    
    self.tableView.header = heard;
    [self.tableView.header beginRefreshing];
    
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
    self.tableView.footer = footer;
    [self.tableView.footer beginRefreshing];
}
//重载父类的解析方法，解析请求回来的数据
-(void) parserData:(id)data{
    
    
    
    
    if(self.page == 1)
    {
        [self.dataSource removeAllObjects];
    }
    
    NSArray * items = data[@"data"];
    for(NSDictionary *dict in items)
    {
        XHQZuiXinModel * model = [[XHQZuiXinModel alloc] initWithDictionary:dict error:nil];
        [self.dataSource addObject:model];
    }
    
    //重新刷新表
    [self.tableView reloadData];
    if(self.page == 1)
    {
        [self.tableView.header endRefreshing];
    }
    if(self.page > 1)
    {
        [self.tableView.footer endRefreshing];
    }
   
}


#pragma mark-------表处理--------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count ;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    XHQZuiXinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZUIXINCELL"];
    XHQZuiXinModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    XHQDaoGoDescViewController *desc = [[XHQDaoGoDescViewController alloc]init];
    XHQZuiXinModel *model = self.dataSource[indexPath.row];
    desc.model = model;
    
    desc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:desc animated:YES];
    
    
    
}

//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }];
}


#pragma mark -- 懒加载
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        CGRect frame = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 114;
        [self.view addSubview:_tableView];
#pragma mark -- 真机崩溃
        //   _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册cell
        UINib *Nib = [UINib nibWithNibName:@"XHQZuiXinTableViewCell" bundle:nil];
        [_tableView registerNib:Nib forCellReuseIdentifier:@"ZUIXINCELL"];
        
        
    }
    return _tableView;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com