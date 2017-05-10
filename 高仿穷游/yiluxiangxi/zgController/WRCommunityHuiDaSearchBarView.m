//
//  WRCommunityHuiDaSearchBarView.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityHuiDaSearchBarView.h"
#import "AppDelegate.h"
#import "Path.h"
#import "RequestModel.h"
#import "WRCommunityHuiDaCell.h"
#import "WRCommunitySheQuWenDaZuixInViewController.h"
#import "MJRefresh.h"

@interface WRCommunityHuiDaSearchBarView ()<UISearchBarDelegate,sendRequestInfo,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *search;
    NSMutableArray *dataSource;
    UITableView *table;
    BOOL isRefreshing;
    BOOL isLoading;
    int currentPage;
}
@end

@implementation WRCommunityHuiDaSearchBarView

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    dataSource=[[NSMutableArray alloc]init];
    [self createUI];
    [self isLoadingAndRefreshing];
    
}
-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
    UINavigationBar *navgation=[[UINavigationBar alloc]initWithFrame:[delegate createFrimeWithX:0 andY:22 andWidth:375 andHeight:42]];
    [navgation setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2015-11-06 下午2.30.58.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:navgation];
    
    UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:10 andY:5 andWidth:40 andHeight:34]];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_webview_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [navgation addSubview:button];
    
    search=[[UISearchBar alloc]initWithFrame:[delegate createFrimeWithX:60 andY:5 andWidth:300 andHeight:34]];
    search.placeholder=@"输入你想问的问题";
    search.delegate=self;
    [navgation addSubview:search];
    
    table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:64 andWidth:375 andHeight:600]];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    [self.view addSubview:table];
}
-(void)pressBackButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self loadRequestInfo];
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    request.path=[NSString stringWithFormat:WENDASOUSUO1@"%@",search.text,currentPage, WENDASOUSUO2];
    request.delegate=self;
    [request startRequestInfo];
    
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSArray *array=message[@"data"];
    [dataSource addObjectsFromArray:array];
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"string";
    WRCommunityHuiDaCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[WRCommunityHuiDaCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:string];
    }
    if (dataSource.count>0) {
        cell.titleLabel.text=dataSource[indexPath.row][@"title"];
        cell.detailLabel.text=dataSource[indexPath.row][@"content"]
        ;
        
        NSString *askNum=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"ask_num"]];
        cell.ReadLabel.text=askNum;
        NSString *answer_num=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"answer_num"]];
        cell.commenLabel.text=answer_num;
        
        
        NSString *timeString=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"add_time"]];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd "];
        NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString intValue]];
        cell.dataLabel.text=[NSString stringWithFormat:@"%@|%@",dataSource[indexPath.row][@"author"],[formatter stringFromDate:confromTimesp]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WRCommunitySheQuWenDaZuixInViewController *zuixin=[[WRCommunitySheQuWenDaZuixInViewController alloc]init];
    zuixin.zuixinpath=dataSource[indexPath.row][@"appview_url"];
    [self presentViewController:zuixin animated:YES completion:nil];
}
-(void)isLoadingAndRefreshing{
    [table  addHeaderWithCallback:^{
        [dataSource removeAllObjects];
        if (isRefreshing) {
            return ;
        }
        isRefreshing=YES;
        currentPage=1;
        [self loadRequestInfo];
        isRefreshing=NO;
        [table headerEndRefreshing];
    }];
    [table addFooterWithCallback:^{
        if (isLoading) {
            return ;
        }
        isLoading=YES;
        currentPage++;
        [self loadRequestInfo];
        isLoading=NO;
        [table footerEndRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
