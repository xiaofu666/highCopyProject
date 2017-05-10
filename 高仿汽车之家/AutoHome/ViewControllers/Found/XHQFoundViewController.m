//
//  XHQFoundViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQFoundViewController.h"

#import "XHQFoundModel.h"
#import "XHQFoundTableViewCell.h"

#import "XHQFoundDescViewController.h"

#import "XHQFoundMoreViewController.h"

@interface XHQFoundViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation XHQFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    [self GetData];
    
    
    
}
- (void)createNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"area_indicator_blue@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(Localself)];
}
- (void)Localself
{
    XHQFoundMoreViewController *more = [[XHQFoundMoreViewController alloc]init];
    [self pushNextWithType:@"suckEffect" Subtype:@"fromLeft" Viewcontroller:more];
}
- (void)GetData
{
    [self request:@"GET" url:SEARCHDDETAILFORUM para:nil];
}
- (void)parserData:(id)data

{
    NSArray *array = data[@"topicList"];
    
    for(NSDictionary *dict in array)
    {
        XHQFoundModel *model = [[XHQFoundModel alloc]initWithDictionary:dict error:nil];
        [self.dataSource addObject:model];
    }
    
    [self.tableView reloadData  ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    XHQFoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.model = self.dataSource[indexPath.row];
      return cell;
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    XHQFoundDescViewController *desc = [[XHQFoundDescViewController alloc]init];
    XHQFoundModel *model = self.dataSource[indexPath.row];
    desc.url = model.uri;
    
    desc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:desc animated:YES];
    
    
    
}
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 152;
        
        UINib *nib = [UINib nibWithNibName:@"XHQFoundTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"CELL"];
       
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com