//
//  WRCommunitySheQuWenDaViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/6.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunitySheQuWenDaViewController.h"
#import "AppDelegate.h"
#import "RequestModel.h"
#import "Path.h"
#import "WRCommunityHuiDaCell.h"
#import "WRCommunitySheQuWenDaZuixInViewController.h"
#import "WRCommunityHuiDaSearchBarView.h"

@interface WRCommunitySheQuWenDaViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo,UISearchBarDelegate>
{
    UITableView *table;
    NSMutableArray *dataSource;
    BOOL isRefreshing;
    BOOL isLoading;
    int currentPage;
    UISearchBar *search;
}
@end

@implementation WRCommunitySheQuWenDaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    currentPage=1;
    dataSource=[[NSMutableArray alloc]init];
    [self createUI];
    [self loadRequestInfo];
    [self isLoadingAndRefreshing];

    // Do any additional setup after loading the view.
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
    label.text=@"回答";
    label.textColor=[UIColor whiteColor];
    [navigation addSubview:label];
    
    search=[[UISearchBar alloc]initWithFrame:[delegate createFrimeWithX:20 andY:90 andWidth:335 andHeight:20]];
    search.placeholder=@"输入你想问的问题";
    search.delegate=self;
    [navigation addSubview:search];
    
    NSArray *array=@[@"最新问答",@"我的问题",@"我的回答"];
    for (int i=0; i<3; i++) {
        UIButton *button1=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:20+120*i andY:142 andWidth:80 andHeight:30]];
        [button1 setTitle:array[i] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.titleLabel.font=[UIFont systemFontOfSize:13];
        [button1 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:168 andWidth:375 andHeight:2]];
        imageView.backgroundColor=[UIColor grayColor];
        [self.view addSubview:imageView];
        
        table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:170 andWidth:375 andHeight:490]];
        table.delegate=self;
        table.dataSource=self;
        table.rowHeight=100;
        [self.view addSubview:table];
        
        
    }
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    WRCommunityHuiDaSearchBarView *search=[[WRCommunityHuiDaSearchBarView alloc]init];
    [self presentViewController:search animated:YES completion:nil];
}
-(void)pressButton:(UIButton *)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==100) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    request.path=[NSString stringWithFormat:WENDAZUIXINHUIDA1@"%@",currentPage,WENDAZUIXINHUIDA2];
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
    
    return cell;
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
