//
//  WRCommunityZhuanRangViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityZhuanRangViewController.h"
#import "AppDelegate.h"
#import "RequestModel.h"
#import "WRCommunityGongLueCell.h"
#import "Path.h"
#import "WRCommunitySheQuSelectView.h"
#import "MJRefresh.h"
@interface WRCommunityZhuanRangViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo>
{
    NSMutableArray *dataSource;
    UITableView *table;
    BOOL isRefreshing;
    BOOL isLoading;
    int currentPage;

}

@end

@implementation WRCommunityZhuanRangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource=[[NSMutableArray alloc]init];
    currentPage=1;
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:450]];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    [self.view addSubview:table];
    [self loadRequestInfo];
    [self isLoadingAndRefreshing];
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    NSString *path=[NSString stringWithFormat:SHEQUZHUNRANG1@"%@",self.zhuanrangID,currentPage,SHEQUZHUNRANG2];
    request.path=path;
    request.delegate=self;
    [request startRequestInfo];
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSArray *array=message[@"data"][@"entry"];
    [dataSource addObjectsFromArray:array];
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"string";
    WRCommunityGongLueCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[WRCommunityGongLueCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    if (dataSource.count>0) {
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.titleLabel.text=dataSource[indexPath.row][@"title"];
        cell.readLabel.text=dataSource[indexPath.row][@"views"];
        cell.commenLabel.text=dataSource[indexPath.row][@"replys"];
        NSString *timeString=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"publish_time"]];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd "];
        NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString intValue]];
        cell.dataLabel.text=[NSString stringWithFormat:@"%@|%@",dataSource[indexPath.row][@"username"],[formatter stringFromDate:confromTimesp]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WRCommunitySheQuSelectView *select=[[WRCommunitySheQuSelectView alloc]init];
    select.url=dataSource[indexPath.row][@"view_url"];
    
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
