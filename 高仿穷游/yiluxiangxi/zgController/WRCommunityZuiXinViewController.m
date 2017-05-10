//
//  WRCommunityZuiXinViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityZuiXinViewController.h"
#import "WRCommunityZuiXinCell.h"
#import "RequestModel.h"
#import "AppDelegate.h"
#import "Path.h"
#import "UIImageView+WebCache.h"
#import "WRCommunitySheQuSelectView.h"
#import "MJRefresh.h"

@interface WRCommunityZuiXinViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo>
{
    UITableView *table;
    NSMutableArray *dataSource;
    BOOL isRefreshing;
    BOOL isLoading;
    int currentPage;
}
@end

@implementation WRCommunityZuiXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource=[[NSMutableArray alloc]init];
    
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:430]];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=120;
    [self.view addSubview:table];
    
    [self loadRequestInfo];
    
    currentPage=1;
    [self isLoadingAndRefreshing];
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    NSString *path=[NSString stringWithFormat:COMMUNITYDETAIL1@"%@",self.zuixinID,currentPage,COMMUNITYDETAIL2];
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
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"string";
    WRCommunityZuiXinCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[WRCommunityZuiXinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    if (dataSource.count>0) {
        NSString *imageName=dataSource[indexPath.row][@"photo"];
        [cell.headImageView setImageWithURL:[NSURL URLWithString:imageName]];
        cell.nameLabel.text=dataSource[indexPath.row][@"username"];
        cell.detailLabel.text=dataSource[indexPath.row][@"title"];
        cell.numLabel.text=dataSource[indexPath.row][@"replys"];
        NSString *timeString=dataSource[indexPath.row][@"publish_time"];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString intValue]];
        cell.dataLabel.text=[formatter stringFromDate:confromTimesp];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WRCommunitySheQuSelectView *select=[[WRCommunitySheQuSelectView alloc]init];
    select.url=dataSource[indexPath.row][@"view_url"];
    [self
     .navigationController pushViewController:select animated:YES];
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
