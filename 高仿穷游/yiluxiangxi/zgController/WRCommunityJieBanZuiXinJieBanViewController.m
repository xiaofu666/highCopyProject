//
//  WRCommunityJieBanZuiXinJieBanViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/7.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityJieBanZuiXinJieBanViewController.h"
#import "AppDelegate.h"
#import "Path.h"
#import "RequestModel.h"
#import "WRCommunityJieBanCell.h"
#import "WRCommunitySheQuSelectView.h"
#import "WRCommunityJieBanShaiXuanMuDiDiViewController.h"
@interface WRCommunityJieBanZuiXinJieBanViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo>
{
    NSMutableArray *dataSource;
    UITableView *table;
    BOOL isLoading;
    BOOL isRefreshing;
    int currentPage;
}


@end

@implementation WRCommunityJieBanZuiXinJieBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    dataSource=[[NSMutableArray alloc]init];
    [self createUI];
    [self loadRequestInfo];
    [self isLoadingAndRefreshing];
}
-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    UINavigationBar *navigation=[[UINavigationBar alloc]initWithFrame:[delegate createFrimeWithX:0 andY:22 andWidth:375 andHeight:120]];
    
    [navigation setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2015-11-06 下午2.30.58.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:navigation];
    
    UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:15 andY:15 andWidth:35 andHeight:35]];
    
    [button setBackgroundImage:[UIImage imageNamed:@"btn_webview_back.png"] forState:UIControlStateNormal];
    button.tag=100;
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [navigation addSubview:button];
    
    UILabel *label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:60 andY:15 andWidth:50 andHeight:35]];
    
    label.text=@"结伴";
    label.textColor=[UIColor whiteColor];
    [navigation addSubview:label];
    
    NSArray *array=@[@"筛选时间",@"筛选目的地"];
    for (int i=0; i<2; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:25+165*i andY:80 andWidth:160 andHeight:20]];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=200+100*i;
        [self.view addSubview:button];
    }
    
    NSArray *array1=@[@"最新结伴",@"我发布的结伴"];
    for (int i=0; i<2; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:20+165*i andY:142 andWidth:160 andHeight:25]];
        //button.backgroundColor=[UIColor grayColor];
        [button setTitle:array1[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=400+100*i;
        [self.view addSubview:button];
    }
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:167 andWidth:375 andHeight:2]];
    imageView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:imageView];
    
    
    table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:170 andWidth:375 andHeight:490]];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    [self.view addSubview:table];
    
}
-(void)pressButton:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==100) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (button.tag==300){
        WRCommunityJieBanShaiXuanMuDiDiViewController *mudidi=[[WRCommunityJieBanShaiXuanMuDiDiViewController alloc]init];
        [self.navigationController pushViewController:mudidi animated:YES];
    }
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    request.path=[NSString stringWithFormat:SHEQUJIEBANZUIXINJIEBAN1@"%@",currentPage,SHEQUJIEBANZUIXINJIEBAN2];
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
    WRCommunityJieBanCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[WRCommunityJieBanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    if (dataSource.count>0) {
        NSString *views=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"views"]];
        cell.ReadLabel.text=views;
        NSString *replays=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"replys"]];
        cell.commenLabel.text=replays;
        cell.detailLabel.text=dataSource[indexPath.row][@"title"];
        
        NSString *publish_time=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"publish_time"]];
        NSString *start_time=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"start_time"]];
        NSString *end_time=[NSString stringWithFormat:@"%@",dataSource[indexPath.row][@"end_time"]];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd "];
        NSDate *pushconfromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[publish_time intValue]];
        NSDate *startconfromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[start_time intValue]];
        NSDate *endconfromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[end_time intValue]];
        cell.titleLabel.text=[NSString stringWithFormat:@"%@-%@|%@",[formatter stringFromDate:startconfromTimesp],[formatter stringFromDate:endconfromTimesp],dataSource[indexPath.row][@"citys_str"]];
        
        cell.dataLabel.text=[NSString stringWithFormat:@"%@|%@",dataSource[indexPath.row][@"username"],[formatter stringFromDate:pushconfromTimesp]];
    }
    
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
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

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    self.tabBarController.tabBar.hidden=YES;
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
