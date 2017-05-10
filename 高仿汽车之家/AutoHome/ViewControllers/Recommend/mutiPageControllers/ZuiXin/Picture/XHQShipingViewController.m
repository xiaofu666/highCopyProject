//
//  XHQShipingViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQShipingViewController.h"
#import "XHQPictModel.h"
#import "XHQPictTableViewCell.h"

#import "XHQPictShowViewController.h"

@interface XHQShipingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation XHQShipingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self GETData];
    [self tableView];
}
- (void)GETData
{
    [self request:@"POST" url:PICTURE para:nil];
    
}
- (void)parserData:(id)data
{
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    

    NSArray *array = dict[@"groups"];
    for(NSDictionary *dict in array)
    {
        XHQPictModel *model = [[XHQPictModel alloc]initWithDictionary:dict error:nil];
        [self.dataSource addObject:model ];
    }
    [self.tableView reloadData];
    
}


#pragma mark -- tableview的代理方法
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHQPictTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    XHQPictModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHQPictModel *model = self.dataSource[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"你已选择%@",model.name];
    //[XHQAuxiliary alertWithTitle:@"温馨提示" message:str button:0 done:nil];
    XHQPictShowViewController *show = [[XHQPictShowViewController alloc]init];
    show.url = model.cover;
    [self pushNextWithType:@"cube" Subtype:@"fromLeft" Viewcontroller:show];
}
#pragma mark -- 懒加载 --
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 188;
        UINib *nib = [UINib nibWithNibName:@"XHQPictTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"CELL"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com