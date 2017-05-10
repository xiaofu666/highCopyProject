//
//  WRCommunityHuiDaViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityHuiDaViewController.h"
#import "Path.h"
#import "AppDelegate.h"
#import "RequestModel.h"
#import "WRCommunityHuiDaCell.h"
#import "WRCommunitySheQuSelectView.h"
#import "WRCommunityHuiDaSearchBarView.h"
@interface WRCommunityHuiDaViewController ()<UITableViewDelegate,UITableViewDataSource,sendRequestInfo,UISearchBarDelegate>
{
    UITableView *table;
    NSMutableArray *dataSource;
    BOOL isRefreshing;
    BOOL isLoading;
    int currentPage;

}
@end

@implementation WRCommunityHuiDaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource=[[NSMutableArray alloc]init];
    currentPage=1;
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    UISearchBar *search=[[UISearchBar alloc]initWithFrame:[delegate createFrimeWithX:10 andY:10 andWidth:355 andHeight:25]];
    search.placeholder=@"输入你想问的问题";
    search.layer.borderWidth=0.3;
    search.delegate=self;
    [self.view addSubview:search];
    
    table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:45 andWidth:375 andHeight:410]];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    [self.view addSubview:table];
    [self loadRequestInfo];
    [self isLoadingAndRefreshing];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    WRCommunityHuiDaSearchBarView *search=[[WRCommunityHuiDaSearchBarView alloc]init];
    [self presentViewController:search animated:YES completion:nil];
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    NSString *path=[NSString stringWithFormat:SHEQUWENDA1@"%@",self.huidaID,currentPage,SHEQUWENDA2];

    request.path=path;
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
        cell=[[WRCommunityHuiDaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    if (dataSource.count>0) {
        cell.titleLabel.text=dataSource[indexPath.row][@"title"];
        cell.detailLabel.text=dataSource[indexPath.row][@"content"];
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
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WRCommunitySheQuSelectView *select=[[WRCommunitySheQuSelectView alloc]init];
    select.url=dataSource[indexPath.row][@"appview_url"];
    [self.navigationController pushViewController:select animated:YES];

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
