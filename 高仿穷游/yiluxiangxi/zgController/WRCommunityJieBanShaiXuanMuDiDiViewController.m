//
//  WRCommunityJieBanShaiXuanMuDiDiViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/7.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityJieBanShaiXuanMuDiDiViewController.h"
#import "AppDelegate.h"
#import "Path.h"
#import "RequestModel.h"
#import "WRCommunityShaiXuanMuDiDiCell.h"

@interface WRCommunityJieBanShaiXuanMuDiDiViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo>
{
    UITableView *table;
    NSMutableArray *dataSource;
    NSMutableArray *mutArray;
    NSMutableArray *array;
}
@end

@implementation WRCommunityJieBanShaiXuanMuDiDiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    dataSource=[[NSMutableArray alloc]init];
    mutArray=[[NSMutableArray alloc]init];
    array=[[NSMutableArray alloc]init];
    [self createUI];
    [self loadRequestInfo];
}
-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    UINavigationBar *navigation=[[UINavigationBar alloc]initWithFrame:[delegate createFrimeWithX:0 andY:22 andWidth:375 andHeight:120]];
    [navigation setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2015-11-06 下午2.30.58.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:navigation];
    
    UIButton *button=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:15 andY:15 andWidth:35 andHeight:35]];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_webview_back.png"] forState:UIControlStateNormal];
    button.tag=600;
    //button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
    [navigation addSubview:button];
    
    UILabel *label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:60 andY:15 andWidth:100 andHeight:35]];
    label.text=@"选择结伴城市";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor whiteColor];
    [navigation addSubview:label];
    
    UIButton *button1=[[UIButton alloc]initWithFrame:[delegate createFrimeWithX:280 andY:10 andWidth:50 andHeight:35]];
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.titleLabel.font=[UIFont systemFontOfSize:13];
    [button1 addTarget:self  action:@selector(pressButton1:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag=800;
    [navigation addSubview:button1];
    
    UISearchBar *search=[[UISearchBar alloc]initWithFrame:[delegate createFrimeWithX:20 andY:80 andWidth:335 andHeight:30]];
    search.placeholder=@"搜索你想要结伴的城市或国家(中/英)";
    [navigation addSubview:search];
    
    table=[[UITableView alloc]initWithFrame:[delegate createFrimeWithX:30 andY:142 andWidth:355 andHeight:510]];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=50;
    [self.view addSubview:table];
}
-(void)pressButton1:(id)sender{
    UIButton *button=(UIButton *)sender;
    if (button.tag==600) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
    
    }
}
-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    request.path=SHAIXUNMUDIDI;
    request.delegate=self;
    [request startRequestInfo];
    
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSArray *array=message[@"data"][@"citys"];
    [dataSource addObjectsFromArray:array];
    [table reloadData];
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"string";
    WRCommunityShaiXuanMuDiDiCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[WRCommunityShaiXuanMuDiDiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    cell.chineseLabel.text=dataSource[indexPath.row][@"cnname"];
    cell.englishLabel.text=dataSource[indexPath.row][@"enname"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WRCommunityShaiXuanMuDiDiCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
       NSNumber *number=[NSNumber numberWithInteger:indexPath.row];
    for (NSNumber *num in mutArray) {
        if (num==number) {
            cell.chineseLabel.textColor=[UIColor blackColor];
            cell.englishLabel.textColor=[UIColor blackColor];
            cell.rightImageView=nil;
           
            [mutArray removeObject:num];
        }
        else{
            cell.chineseLabel.textColor=[UIColor greenColor];
            cell.englishLabel.textColor=[UIColor greenColor];
            cell.rightImageView.image=[UIImage imageNamed:@"category_selected@2x.png"];
            
            [mutArray addObject:number];
        }
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
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
