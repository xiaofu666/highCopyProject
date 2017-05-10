


//
//  XHQFavViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQFavViewController.h"
#import "XHQZUIXINDatabase.h"
#import "XHQDaoGoDescViewController.h"
#import "XHQZuiXinTableViewCell.h"

#import "XHQFoundDescViewController.h"
@interface XHQFavViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation XHQFavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self customData];
}
#pragma mark----------数据请求和解析------------
- (void)customData
{
    
    
    
    [self.dataSource addObjectsFromArray:[[XHQZUIXINDatabase sharedManager]findAll]];
    if(self.dataSource.count == 0)
    {
        
        [XHQAuxiliary alertWithTitle:@"温馨提示"  message:@"您还没有任何收藏" button:1 done:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        return;
    }
    [self.view addSubview:self.tableView];
   // [self.tableView reloadData];
    
    
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
    
    
    
    XHQFoundDescViewController *desc = [[XHQFoundDescViewController alloc]init];
    XHQZuiXinModel *model = self.dataSource[indexPath.row];
    desc.url = model.url;
    
    desc.hidesBottomBarWhenPushed = YES;
   
    [self.navigationController pushViewController:desc animated:YES];
    
    
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHQZuiXinModel *model = self.dataSource [indexPath.row];
    [self.dataSource removeObject:model];
    [[XHQZUIXINDatabase sharedManager]deleteRecord:model];
    [self.tableView reloadData   ];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"走你";
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
        _tableView.tableFooterView = [[UIView alloc]init];
        //;
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