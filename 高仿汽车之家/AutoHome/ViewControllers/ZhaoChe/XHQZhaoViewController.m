//
//  XHQFoundCarViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQZhaoViewController.h"
#import "XHQFoundCarModel.h"
#import "XHQZhaoTableViewCell.h"
@interface XHQZhaoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation XHQZhaoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [ self  GETData];
    
    [self tableView];
}




- (void)GETData
{
    [self request:@"GET"url:WEBCARS_GETALLBRANDLIST para:nil];
}
- (void)parserData:(id)data
{
    NSArray *array = data[@"ListContents"];
    for(NSDictionary *dict in array)
    {
        XHQFoundCarModel *model = [[XHQFoundCarModel alloc]initWithDictionary:dict error:nil];
        [self.dataSource addObject:model];
    }
   
    [self.tableView reloadData];
}
#pragma mark --tableView的代理方法 --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XHQFoundCarModel *model =  self.dataSource[section];
    return model.GroupCount;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    XHQFoundCarModel *model = self.dataSource[section];
    return model.PinYin;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHQZhaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
  
   
    XHQFoundCarModel *model = self.dataSource[indexPath.section];
    
    NSDictionary *dict = model.GroupInfo[indexPath.row];
   
    cell.name.text= [dict objectForKey:@"MainBrandName"];
    
    
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"imgURL"]];
    [cell.icon sd_setImageWithURL: url];
   
    
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *array = @[@"A", @"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];//背景色
    self.tableView.sectionIndexColor = [UIColor blueColor];//字体色
    return array;
}
//索引点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
   
    NSLog(@"点击了第%ld个",index);
    return 20;
}

#pragma mark -- 懒加载 --
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain  ];
        _tableView.rowHeight = 70;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        UINib *nib = [UINib nibWithNibName:@"XHQZhaoTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"CELL"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com