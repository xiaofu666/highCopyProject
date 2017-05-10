//
//  WRCommunityGongLueViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityGongLueViewController.h"
#import "AppDelegate.h"
#import "RequestModel.h"
#import "Path.h"
#import "WRCommunityGongLueCell.h"
#import "WRCommunitySheQuSelectView.h"
#import "MJRefresh.h"

@interface WRCommunityGongLueViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo>
{
    UITableView *table;
    NSMutableArray *dataSource;
    BOOL isRefreshing;
    BOOL isLoading;
    int currentPage;
    NSString* _path;
    BOOL _isAll;
    BOOL _isJinghua;
    BOOL _isYouji;
    BOOL _isGonglue;
}
@end

@implementation WRCommunityGongLueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource=[[NSMutableArray alloc]init];
    currentPage=1;
    _path=[NSString stringWithFormat:GONGLUEQUANBU1@"%@"GONGLUEQUANBU3@"%@",self.gonglueID,GONGLUEQUANBU2,currentPage,GONGLUEQUANBU4];
    [self createUI];
    [self loadRequestInfo];
    [self isLoadingAndRefreshing];
    }

-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    UIView *view=[[UIView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:35]];
    view.backgroundColor=[UIColor grayColor];
    view.alpha=0.3;
    [self.view addSubview:view];
    
    NSArray *array=@[@"全部",@"精华",@"游记",@"攻略"];
    for (int i=0; i<4; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:70+70*i andY:0 andWidth:44 andHeight:35]];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=100+100*i;
        [view addSubview:button];
        
        table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:35 andWidth:375 andHeight:410]];
        table.delegate=self;
        table.dataSource=self;
        table.rowHeight=100;
        [self.view addSubview:table];
    }
}

-(void)pressButton:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==100) {
        _path=[NSString stringWithFormat:GONGLUEQUANBU1@"%@"GONGLUEQUANBU3@"%@",self.gonglueID,GONGLUEQUANBU2,currentPage,GONGLUEQUANBU4];
         _isAll = YES;
        _isJinghua = NO;
         _isYouji = NO;
        _isGonglue = NO;
        currentPage = 1;
        [self loadRequestInfo];

    }
    else if (button.tag==200){
        _path=[NSString stringWithFormat:GONGLUEJINGHUA1@"%@",self.gonglueID,currentPage,GONGLUEJINGHUA2];
        _isAll = NO;
        _isJinghua = YES;
        _isYouji = NO;
        _isGonglue = NO;
        currentPage = 1;
        [self loadRequestInfo];
    }
    else if (button.tag==300){
        _path=[NSString stringWithFormat:GONGLUEYOUJI1@"%@",self.gonglueID,currentPage,GONGLUEYOUJI2];
        _isAll = NO;
        _isJinghua = NO;
        _isYouji = YES;
        _isGonglue = NO;
        currentPage = 1;
        [self loadRequestInfo];
    }
    else {
        _path=[NSString stringWithFormat:GONGLUEGONGLUE1@"%@",self.gonglueID,currentPage,GONGLUEGONGLUE2];
        _isAll = NO;
        _isJinghua = NO;
        _isYouji = NO;
        _isGonglue =YES;
        currentPage = 1;
        [self loadRequestInfo];
    }
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    if (_isAll) {
        _path=[NSString stringWithFormat:GONGLUEQUANBU1@"%@"GONGLUEQUANBU3@"%@",self.gonglueID,GONGLUEQUANBU2,currentPage,GONGLUEQUANBU4];
    }else if(_isJinghua){
     _path=[NSString stringWithFormat:GONGLUEJINGHUA1@"%@",self.gonglueID,currentPage,GONGLUEJINGHUA2];
    
    }else if (_isYouji){
    _path=[NSString stringWithFormat:GONGLUEYOUJI1@"%@",self.gonglueID,currentPage,GONGLUEYOUJI2];
    }else{
    _path=[NSString stringWithFormat:GONGLUEGONGLUE1@"%@",self.gonglueID,currentPage,GONGLUEGONGLUE2];
    }
    
    request.path=_path;
    request.delegate=self;
    [request startRequestInfo];
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    if (currentPage>1){
    }else{
    [dataSource removeAllObjects];
    }
    NSArray *array=message[@"data"][@"entry"];
    [dataSource addObjectsFromArray:array];
    [table reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"string";
    WRCommunityGongLueCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[WRCommunityGongLueCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    if (dataSource.count>0) {
        cell.titleLabel.text=dataSource[indexPath.row][@"title"];
        cell.readLabel.text=dataSource[indexPath.row][@"views"];
        cell.commenLabel.text=dataSource[indexPath.row][@"replys"];
        NSString *timeString=dataSource[indexPath.row][@"publish_time"];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd "];
        NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString intValue]];
        cell.dataLabel.text=[NSString stringWithFormat:@"%@|%@",dataSource[indexPath.row][@"username"],[formatter stringFromDate:confromTimesp]];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
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
        NSLog(@"%d",currentPage);
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
