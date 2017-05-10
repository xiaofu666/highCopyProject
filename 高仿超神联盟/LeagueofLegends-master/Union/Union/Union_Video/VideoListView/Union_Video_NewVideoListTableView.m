//
//  Union_Video_NewCollectionView.m
//  Union
//
//  Created by lanou3g on 15-7-19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Video_NewVideoListTableView.h"

#import "VideoListTableViewCell.h"

#import "Networking.h"

#import "PCH.h"

#import "VideoListModel.h"



#import "GearPowered.h"

@interface Union_Video_NewVideoListTableView ()<UITableViewDataSource,UITableViewDelegate,GearPoweredDelegate>

@property (nonatomic ,retain) NSMutableArray *tableArray;//数据原数组

@property (nonatomic ,retain) GearPowered *gearPowered;//齿轮刷新

@end


@implementation Union_Video_NewVideoListTableView
-(void)dealloc{

    [_tableArray release];
    
    [_gearPowered release];

    [super dealloc];
}


//初始化
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        
        //背景色
        self.backgroundColor = [UIColor whiteColor];
        
        //设置代理
        
        self.delegate = self;
        
        self.dataSource =self;
        
        //注册cell
        
        [self registerClass:[VideoListTableViewCell class] forCellReuseIdentifier:@"CELL"];
        
        //初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        _gearPowered.url = [NSURL URLWithString:kUnion_Video_NewURL];//设置上拉刷新

        //加载数据
        
        [self loadData];
    
    }

    return self;

}

#pragma mark ---LazyLoading

-(NSMutableArray *)tableArray{
   
    if (_tableArray == nil) {
    
        _tableArray = [[NSMutableArray alloc]init];
    
    }
    
    return _tableArray;
}

//加载数据

-(void)loadData{

    //请求数据
    
    __block Union_Video_NewVideoListTableView *Self =self;
    
    [[Networking shareNetworking] networkingGetWithURL:kUnion_Video_NewURL Block:^(id object) {

        //调用解析方法
       
        [Self NSJSONSerializationWithData:object];
        
    }];


}

//解析数据

-(void)NSJSONSerializationWithData:(NSData *)data{

    //    解析前清空数据原数组
    [self.tableArray removeAllObjects];

    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dic in array) {
       
        VideoListModel *vlModel = [[VideoListModel alloc]init];
        
        NSString *uploadTime = [[dic valueForKey:@"upload_time"] substringWithRange:NSMakeRange(5, 5)];
        
        //在字典中找到key取值  转换成NSInteger
        
        NSInteger videoLength = [[dic valueForKey:@"video_length"] integerValue];
        
        vlModel.video_length = [[self getStringWithTime:videoLength] retain];
        
        vlModel.vid = [[dic valueForKey:@"vid"] retain];
        
        vlModel.cover_url = [[dic valueForKey:@"cover_url"] retain];
        
        vlModel.title = [[dic valueForKey:@"title"] retain];
        
        vlModel.upload_time = [uploadTime retain];
        
        [self.tableArray addObject:vlModel];
        
    }
    
    //刷新数据
    
    [self reloadData];

}

#pragma mark---实现UITableViewDataSource，UITableViewDelegate方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    //给cell的数据模型赋值
    
    cell.Model = self.tableArray[indexPath.row];
    
    cell.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 90);
        
    
    
    return cell;
}


#pragma mark-----设置cell的高度

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 90;

}

#pragma mark ---时间格式转换 将秒转换成指定格式字符串

- (NSString *)getStringWithTime:(NSInteger)time{
    
    NSString *timeString = nil;
    
    NSInteger MM = 0;
    
    NSInteger HH = 0;
    
    if (59 < time) {
        
        MM = time / 60 ;
        
        timeString = [NSString stringWithFormat:@"%.2ld:%.2ld",MM,time - MM * 60];
        
        if (3599 < time) {
            
            HH = time / 3600 ;
            
            timeString = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld", HH , MM > 59 ? MM - 60 : MM ,time - MM * 60];
            
        }
        
    }
    
    return timeString;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //调用齿轮刷新的滑动事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //调用齿轮刷新的拖动结束事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
}

#pragma mark ---GearPoweredDelegate

-(void)didLoadData:(NSData *)data{
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //调用数据解析方法
    
    [self NSJSONSerializationWithData:data];
    
}





@end
