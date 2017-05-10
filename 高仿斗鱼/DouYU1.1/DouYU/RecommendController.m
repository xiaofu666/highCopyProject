//
//  RecommendController.m
//  DouYU
//
//  Created by Alesary on 15/10/29.
//  Copyright © 2015年 Alesary. All rights reserved.
//

//http://www.douyutv.com/api/v1/room/299113?aid=ios&auth=e63c643bdb9b88f9d30b867c3982a309&client_sys=ios&time=1447041300
#import "RecommendController.h"
#import "URL.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import "RecommendTableCell.h"
#import "RecommendHeadView.h"
#import "NewShowViewCell.h"
#import "MoreViewController.h"
#import "NSString+Times.h"
#import "NetworkSingleton.h"
#import "TOPdata.h"
#import "NewShowData.h"
#import "ChanelData.h"
#import "PlayerController.h"
#import "SDRotationLoopProgressView.h"
#import "PlayerController.h"

#define TABBAR_H self.tabBarController.tabBar.frame.size.height


@interface RecommendController () <SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,RecommendTableCellDelegate>
{
    UITableView *_tableView;
    
     SDCycleScrollView *_headView;
     SDRotationLoopProgressView *_LoadView;
    
    RecommendHeadView *_CellHeadView;
    
    MoreViewController *_moreVC;
    
    NSMutableArray *_topDataArray;
    NSMutableArray *_imageArray;
    NSMutableArray *_titleArray;
    
    NSMutableArray *_NewDataArray;
    
    NSMutableArray *_ChanelDataArray;
    NSMutableArray *_ChanelDatas;
    
}

@end

@implementation RecommendController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
   
    [self loadChanelData];
    
    [self loadTopData];
    [self loadNewShowData];
    
    [self initHeadView];
    [self initTableView];
    
    _topDataArray=[NSMutableArray array];
    _imageArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    _NewDataArray=[NSMutableArray array];
    
    _ChanelDataArray=[NSMutableArray array];
    _ChanelDatas=[NSMutableArray array];

    

};

-(void)loadNewShowData
{
    NSString *url=[NSString stringWithFormat:@"%@%@",NEW_URl,[NSString GetNowTimes]];
    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url successBlock:^(id responseBody) {
        
    _NewDataArray=[NewShowData objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
        
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];//刷新
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } failureBlock:^(NSString *error) {
        
    }];
}

-(void)loadChanelData
{
    [self showLoadView];
    NSString *url=[NSString stringWithFormat:@"%@%@",CHANEL_URl,[NSString GetNowTimes]];
    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url successBlock:^(id responseBody) {
        
        _ChanelDatas=[responseBody objectForKey:@"data"];
        
        for (NSDictionary *dic in _ChanelDatas) {
            
            NSMutableArray *array=[NSMutableArray array];
            [array addObject:[dic objectForKey:@"title"]];
            [array addObject:[dic objectForKey:@"cate_id"]];
            
            [array addObject:[ChanelData objectArrayWithKeyValuesArray:[dic objectForKey:@"roomlist"]]];
            [_ChanelDataArray addObject:array];
        }
        
    
       
        [self hidenLoadView];
             [self.view addSubview:_tableView];
        
    } failureBlock:^(NSString *error) {
        
    }];

}
-(void)loadTopData
{

    NSDictionary *parameteiDic=@{@"aid":@"ios",@"auth":@"97d9e4d3e9dfab80321d11df5777a107",@"client_sys":@"ios",@"time":[NSString GetNowTimes]};
    
    [[NetworkSingleton sharedManager] getResultWithParameter:parameteiDic url:TOP_URl successBlock:^(id responseBody) {
        
        _topDataArray=[TOPdata objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
        
        
        for (TOPdata *topdata in _topDataArray) {
            
            [_imageArray addObject:topdata.pic_url];
            
            [_titleArray addObject:topdata.title];
        }
        
        _headView.imageURLStringsGroup=_imageArray;
        _headView.titlesGroup=_titleArray;
        
    } failureBlock:^(NSString *error) {
        
    }];

}
-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64-TABBAR_H) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableHeaderView=_headView;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    
}
-(void)initHeadView
{
    
    _headView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screen_width, 200*KWidth_Scale) imagesGroup:_imageArray];
    _headView.titlesGroup=_titleArray;
    _headView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _headView.delegate=self;
    _headView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _headView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _headView.titleLabelTextFont=[UIFont systemFontOfSize:17];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_ChanelDataArray.count) {
        
        return _ChanelDataArray.count;
    }else{
    
        return 1;
    }
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 145;
    }else{
    
        return 280*KWidth_Scale;
    }
    
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section==0) {
        
        static NSString *identfire=@"NewShowViewCell";
        
        NewShowViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell=[[NewShowViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        
        [cell setContentView:_NewDataArray];
        
        return cell;
    }else{
        
        static NSString *identfire=@"RecommendTableCell";
        
        RecommendTableCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell=[[RecommendTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        NSArray *array=_ChanelDataArray[indexPath.section-1];
        
        cell.modelArray=array[2];
        cell.delegate=self;
        cell.tags=(int)indexPath.section-1;

        return cell;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _CellHeadView=[[RecommendHeadView alloc]init];
    _CellHeadView.tag=section;
    
    if (section==0) {
        
        _CellHeadView.more.hidden=YES;
        _CellHeadView.moreimage.hidden=YES;
    }else{
    
        NSArray *array=_ChanelDataArray[section-1];
        _CellHeadView.Title.text=[array firstObject];
        UITapGestureRecognizer *tapHeadView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadView:)];
        tapHeadView.delegate=self;
        [_CellHeadView addGestureRecognizer:tapHeadView];
    }
    
    return _CellHeadView;
}

-(void)tapHeadView:(UIGestureRecognizer*)sender
{
    
    NSArray *array=_ChanelDataArray[sender.view.tag-1];
    

    _moreVC=[[MoreViewController alloc]init];
    _moreVC.title=array[0];
    _moreVC.Cate_id=array[1];
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:_moreVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isMemberOfClass:[UIButton class]]) {
        
        return YES;
    }
    
    return YES;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    TOPdata *topdata=_topDataArray[index];
    
    PlayerController *playVC=[[PlayerController alloc]init];
    
    NSLog(@"%@",[topdata.room objectForKey:@"hls_url"]);
    
    playVC.Hls_url=[topdata.room objectForKey:@"hls_url"];
    
    [self setHidesBottomBarWhenPushed:YES];
    [self presentViewController:playVC animated:YES completion:nil];

    
}
-(void)hidenLoadView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [_LoadView removeFromSuperview];
        
    }];
}

-(void)showLoadView
{
    _LoadView=[SDRotationLoopProgressView progressView];
    
    _LoadView.frame=CGRectMake(0, 0, 100*KWidth_Scale, 100*KWidth_Scale);
    
    _LoadView.center=self.view.center;
    
    [self.view addSubview: _LoadView ];
    
}


-(void)TapRecommendTableCellDelegate:(ChanelData *)chaneldata
{
    PlayerController *playVC=[[PlayerController alloc]init];
    
    NSLog(@"%@",chaneldata.room_name);
    
    [self setHidesBottomBarWhenPushed:YES];
    
    [self presentViewController:playVC animated:YES completion:nil];
    

}
@end
