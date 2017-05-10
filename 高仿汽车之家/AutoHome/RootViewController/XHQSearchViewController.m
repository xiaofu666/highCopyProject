



//
//  XHQSearchViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQSearchViewController.h"

@interface XHQSearchViewController ()< UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UISearchController *search;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation XHQSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self creatSearchController];
    
    
}
- (void)creatSearchController
{
    _search = [[UISearchController alloc]initWithSearchResultsController:nil];
    _search.searchBar.frame = CGRectMake(10, 20, XHQ_SCRWIDTH - 250, 40);
    _search.dimsBackgroundDuringPresentation = YES;
    _search. hidesNavigationBarDuringPresentation = NO;
    _search.searchBar.placeholder = @"请输入关键字";
    _search.searchBar.delegate = self;
 
 
    self.navigationItem.titleView = self.search.searchBar;

}
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        CGRect frame = CGRectMake(0, 64, XHQ_SCRWIDTH, XHQ_SCRHEIGTH - 64);
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    NSString *str = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"暂无%@相关数据",str];
    return cell;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *str = searchBar.text;
    [self.dataSource addObject:str];
   
    [self .tableView reloadData];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com