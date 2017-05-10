//
//  SecondViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "VideoListViewController.h"

#import "VideoListTableViewCell.h"

#import "Networking.h"

#import "PCH.h"

#import "VideoListModel.h"

#import "GearPowered.h"

#import "UIImageView+WebCache.h"

#import "Union_Video_VideoListTableView.h"


@interface VideoListViewController ()

@property (nonatomic , retain ) Union_Video_VideoListTableView *tableView;

@property (nonatomic , retain ) NSMutableArray *secondArray;//数据原数组

@end

@implementation VideoListViewController

-(void)dealloc{
    
    [_tableView release];

    [_secondArray release];
    
    [_string release];
    
    [_name release];
    
    [_searchName release];
    
    [super dealloc];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航控制器标头
    
    self.title = self.name;

    
}




//加载数据

-(void)loadData{
    
    //判断是搜索请求还是正常请求
    
    NSString *URL =  nil;
    
    if (_string != nil) {
        
        URL = [NSString stringWithFormat:kUnion_Video_URL , @"%ld" , self.string ];
        
    } else {
        
        URL = [NSString stringWithFormat:kUnion_Video_SearchURL , self.searchName , @"%ld" ];
        
    }
    
    //导航控制器标头
    
    self.title = self.name;
    
    //设置URL
    
    self.tableView.urlStr = URL;
    

}






#pragma mark ---leftBarButtonAction

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    //清空请求参数
    
    _string = nil;
    
    _searchName = nil;
    
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

#pragma mark ---LazyLoading

-(Union_Video_VideoListTableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[Union_Video_VideoListTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 ) style:UITableViewStylePlain];
        
        _tableView.rootVC = self;
        
        //添加视频列表视图
        
        [self.view addSubview:self.tableView];
        
    }
    
    return _tableView;
}


-(NSMutableArray *)secondArray{
    
    if (_secondArray == nil) {
        
        _secondArray = [[NSMutableArray alloc]init];
    }
    
    return _secondArray;
    
}


@end
