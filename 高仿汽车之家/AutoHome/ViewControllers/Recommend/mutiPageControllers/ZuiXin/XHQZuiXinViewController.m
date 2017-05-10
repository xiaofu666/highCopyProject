//
//  XHQFoundViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQZuiXinViewController.h"

#import "XHQZuiXinModel.h"
#import "XHQZuiXinTableViewCell.h"
#import "XHQZUIXINCilcel.h"
#import "XHQDaoGoDescViewController.h"

#import "XHQFoundDescViewController.h"

#import "XHQCilcelModel.h"



@interface XHQZuiXinViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger page;
/**存储图片*/
@property(nonatomic,strong)NSMutableArray  *CirleArr;

@end

@implementation XHQZuiXinViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
      
    [self refreshData];
    
 // [self setRefreshView];
    
  
    
}


#pragma mark-------上拉加载和下拉刷新
//下拉刷新
-(void)refreshData
{
    
    _page = 1;
    [self customData];
}

//上拉加载
-(void)loadMoreData
{
    
    _page +=1;
    [self customData];
    
  
}
//设置上拉加载和下拉刷新
-(void)setRefreshView
{
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshData];
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"松手刷新" forState:MJRefreshStatePulling];
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
    
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        
        }];
    [self.tableView.footer beginRefreshing];
}


#pragma mark----------数据请求和解析------------
- (void)customData
{
    
    NSString *path = [NSString stringWithFormat:MAIN,self.page];
   
    [self request:@"GET" url:path para:nil];
    
    
}
//重载父类的解析方法，解析请求回来的数据
-(void) parserData:(id)data{
    //下拉刷新
  
    if(_page == 1)
    {
        [self.dataSource removeAllObjects];
        [self.CirleArr removeAllObjects];
        
    }
   
//轮播图
    
    NSArray *clile = data[@"focus"];
    for(NSDictionary *dic in clile)
    {
        XHQCilcelModel *model = [[XHQCilcelModel alloc]initWithDictionary:dic error:nil];
        [self.CirleArr addObject:model];
    }

 //首页数据
    
    NSArray * items = data[@"data"];
    for(NSDictionary *dict in items)
    {
        XHQZuiXinModel * model = [[XHQZuiXinModel alloc] initWithDictionary:dict error:nil];
        [self.dataSource addObject:model];
   }
    
    
    //重新刷新表
    [self.tableView reloadData];
    
    
    //结束上拉和下拉刷新
    if (_page == 1) {
        [self.tableView.header endRefreshing];
    }
    if (_page > 1) {
        [self.tableView.footer endRefreshing];
    }
   // [self setRefreshView];
    NSLog(@"%ld,💐%ld",self.dataSource.count,self.CirleArr.count);
    
    //[self setRefreshView];
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


- (void)didSelectedLocalImage:(NSString *)url
{
   
    XHQFoundDescViewController *desc = [[XHQFoundDescViewController alloc]init];
     desc.url = url;
    
    desc.hidesBottomBarWhenPushed = YES;
 
    [self.navigationController pushViewController:desc animated:YES];
   
}
#pragma mark -- 轮播图相关 ----
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
  
       CGRect frame = CGRectMake(0, 0, XHQ_SCRWIDTH, HEIGHTOFHEARD);
   
    NSLog(@"❤️ahua%@",self.CirleArr);

    XHQZUIXINCilcel *cilcelView = [[XHQZUIXINCilcel alloc]initWithFrame:frame andCircleArray:self.CirleArr];
     cilcelView.deletage = self;
    return cilcelView;
    //return nil;
    
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
    return HEIGHTOFHEARD;
 
 
}
#pragma mark -- 懒加载
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        CGRect frame = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 114;
       [self.view addSubview:_tableView];
#pragma mark -- 真机崩溃
     //   _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self  setRefreshView];
        //注册cell
        UINib *Nib = [UINib nibWithNibName:@"XHQZuiXinTableViewCell" bundle:nil];
        [_tableView registerNib:Nib forCellReuseIdentifier:@"ZUIXINCELL"];

        
    }
    return _tableView;
}
- (NSMutableArray *)CirleArr
{
    if(_CirleArr == nil)
    {
        _CirleArr = [[NSMutableArray alloc]init];
    }
    return _CirleArr;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com