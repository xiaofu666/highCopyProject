//
//  WRCommunityJieBanViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityJieBanViewController.h"
#import "AppDelegate.h"
#import "RequestModel.h"
#import "Path.h"
#import "WRCommunityJieBanCell.h"
#import "WRCommunitySheQuSelectView.h"
#import "MJRefresh.h"
@interface WRCommunityJieBanViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo>
{
    UITableView *table;
    NSMutableArray *dataSuorce;
    BOOL isRefreshing;
    BOOL isLoading;
    int currentPage;

    
}
@end

@implementation WRCommunityJieBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    dataSuorce=[[NSMutableArray alloc]init];
    [self createUI];
    [self loadRequestInfo];
    [self isLoadingAndRefreshing];
}

-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;

    UIView *view=[[UIView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:20   ]];
    view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"屏幕快照 2015-11-06 下午2.30.58.png"]];
    [self.view addSubview:view];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:192 andY:0 andWidth:2 andHeight:20]];
    imageView.backgroundColor=[UIColor whiteColor];
    [view addSubview:imageView];
    NSArray *array=@[@"筛选时间",@"筛选目的地"];
    for (int i=0; i<2; i++) {
                UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:25+165*i andY:0 andWidth:160 andHeight:20]];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    
    table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:20 andWidth:375 andHeight:430]];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    [self.view addSubview:table];

}
-(void)pressButton:(id)sender{

}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    NSString *path=[NSString stringWithFormat:SHEQUJIEBAN1@"%@",self.jiebanID,currentPage,SHEQUJIEBAN2];
        request.path=path;
    request.delegate=self;
    [request startRequestInfo];
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSArray *array=message[@"data"];
    [dataSuorce addObjectsFromArray:array];
    for (NSDictionary *dic in array) {
        [dataSuorce addObject:dic];
    }
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSuorce.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"string";
    WRCommunityJieBanCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[WRCommunityJieBanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    if (dataSuorce.count>0) {
        NSString *views=[NSString stringWithFormat:@"%@",dataSuorce[indexPath.row][@"views"]];
        cell.ReadLabel.text=views;
        NSString *replays=[NSString stringWithFormat:@"%@",dataSuorce[indexPath.row][@"replys"]];
        cell.commenLabel.text=replays;
        cell.detailLabel.text=dataSuorce[indexPath.row][@"title"];
        
        NSString *publish_time=[NSString stringWithFormat:@"%@",dataSuorce[indexPath.row][@"publish_time"]];
        NSString *start_time=[NSString stringWithFormat:@"%@",dataSuorce[indexPath.row][@"start_time"]];
        NSString *end_time=[NSString stringWithFormat:@"%@",dataSuorce[indexPath.row][@"end_time"]];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd "];
        NSDate *pushconfromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[publish_time intValue]];
        NSDate *startconfromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[start_time intValue]];
        NSDate *endconfromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[end_time intValue]];
        cell.titleLabel.text=[NSString stringWithFormat:@"%@-%@|%@",[formatter stringFromDate:startconfromTimesp],[formatter stringFromDate:endconfromTimesp],dataSuorce[indexPath.row][@"citys_str"]];
        
        cell.dataLabel.text=[NSString stringWithFormat:@"%@|%@",dataSuorce[indexPath.row][@"username"],[formatter stringFromDate:pushconfromTimesp]];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        

    }
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WRCommunitySheQuSelectView *select=[[WRCommunitySheQuSelectView alloc]init];
    select.url=dataSuorce[indexPath.row][@"appview_url"];
    [self.navigationController pushViewController:select animated:YES];

}

-(void)isLoadingAndRefreshing{
    [table  addHeaderWithCallback:^{
        [dataSuorce removeAllObjects];
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
