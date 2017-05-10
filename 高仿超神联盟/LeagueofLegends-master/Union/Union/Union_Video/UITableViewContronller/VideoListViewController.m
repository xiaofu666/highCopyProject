//
//  SecondViewController.m
//  Union
//
//  Created by lanou3g on 15-7-21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "VideoListViewController.h"

#import "VideoListTableViewCell.h"

#import "Networking.h"

#import "PCH.h"

#import "VideoListModel.h"

#import "GearPowered.h"

#import "UIImageView+WebCache.h"

@interface VideoListViewController ()<UITableViewDataSource,UITableViewDelegate,GearPoweredDelegate>

@property (nonatomic ,retain) UITableView *tableView;

@property (nonatomic ,retain) NSMutableArray *secondArray;//数据原数组

@property (nonatomic ,retain) GearPowered *gearPowered;//齿轮刷新

@end

@implementation VideoListViewController

-(void)dealloc{
    
    [_tableView release];

    [_secondArray release];

    [_gearPowered release];
    
    [_string release];
    
    [_name release];
    
    [_searchName release];
    
    [super dealloc];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加导航栏左按钮
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    leftBarButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;

    

//   导航控制器标头
    
    self.title = self.name;
    
//    视图背景色
    
    self.view.backgroundColor = [UIColor whiteColor];
//    声明tableView
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    
//    设置代理
    
    self.tableView.delegate = self;

    self.tableView.dataSource = self;
    
//    将tableView添加到视图上
    
    [self.view addSubview:self.tableView];
    
//    注册cell
    
    [self.tableView registerClass:[VideoListTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
//     初始化设置齿轮刷新
    
    _gearPowered = [[GearPowered alloc]init];
    
    _gearPowered.scrollView = self.tableView;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
    
    _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
    
    _gearPowered.delegate = self;//设置代理
    

 
}

//懒加载

-(NSMutableArray *)secondArray{

    if (_secondArray == nil) {
        
        _secondArray = [[NSMutableArray alloc]init];
    }

    return _secondArray;
    
}

//加载数据

-(void)loadData{
    
    //判断是搜索请求还是正常请求
    
    NSString *URL =  nil;
    
    if (_string != nil) {
        
        URL = [NSString stringWithFormat:kUnion_Video_URL , self.string];
        
    } else {
        
        URL = [NSString stringWithFormat:kUnion_Video_SearchURL , self.searchName];
        
    }
    
    //   导航控制器标头
    
    self.title = self.name;
    
    //设置上拉刷新
    
    _gearPowered.url = [NSURL URLWithString:URL];
    
    
    __block VideoListViewController *Self =self;

    [[Networking shareNetworking] networkingGetWithURL:URL Block:^(id object) {
   
        //调用解析方法
    
        [Self NSJSONSerializationWithData:object];
    
    }];
    
    _string = nil;
    
    _searchName = nil;

}

#pragma mark  ---解析数据

-(void)NSJSONSerializationWithData:(NSData *)data{

    //解析前清空数据原数组
    
    [self.secondArray removeAllObjects];
    
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
        
        [self.secondArray addObject:vlModel];
        
    }
    
    //刷新数据
    
    [self.tableView reloadData];


}

#pragma mark---实现UITableViewDataSource，UITableViewDelegate方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.secondArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    //    给cell的数据模型赋值
    
    cell.Model = self.secondArray[indexPath.row];
    
   
    NSURL *picUrl = [NSURL URLWithString:[self.secondArray[indexPath.row] cover_url]];
    
    [cell.cover_url sd_setImageWithURL:picUrl];
    
    cell.frame = CGRectMake(0,0,CGRectGetWidth(self.view.frame), 90);


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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    //跳转视频播放
    

}


#pragma mark ---leftBarButtonAction

- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
