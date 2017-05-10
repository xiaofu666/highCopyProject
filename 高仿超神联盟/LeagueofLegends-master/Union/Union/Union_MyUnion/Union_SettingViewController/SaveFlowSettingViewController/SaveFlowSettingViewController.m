//
//  SaveFlowSettingViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SaveFlowSettingViewController.h"

#import "SaveFlowSettingCell.h"

@interface SaveFlowSettingViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , retain ) NSMutableArray *dataArray;

@property (nonatomic , retain ) UITableView *tableView;

@property (nonatomic , retain) UIButton *confirmButton;

@end

@implementation SaveFlowSettingViewController

-(void)dealloc{
    
    [_dataArray release];
    
    [_tableView release];
    
    [_confirmButton release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"图片自动加载设置";
    
    //初始化数据源数组
    
    _dataArray = [[NSMutableArray alloc]initWithArray:@[@"所有网络",@"仅WiFi网络",@"关闭图片加载"]];
    
    
    //初始化表视图
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[SaveFlowSettingCell class] forCellReuseIdentifier:@"cell"];
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(_tableView.frame) , 100)];
    
    footView.backgroundColor = [UIColor clearColor];
    
    _tableView.tableFooterView = footView;
    
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _confirmButton.frame = CGRectMake(20 , CGRectGetHeight(footView.frame) - 44 , CGRectGetWidth(self.view.frame) - 40 , 44);
    
    _confirmButton.backgroundColor = [UIColor colorWithRed:105/255.0 green:149/255.0 blue:246/255.0 alpha:1];
    
    _confirmButton.clipsToBounds = YES;
    
    _confirmButton.layer.cornerRadius = 5.0f;
    
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_confirmButton addTarget:self  action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:_confirmButton];
    
    
    
}

#pragma mark ---确认按钮响应事件

- (void)confirmButtonAction:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark ---UITableViewDelegate , UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SaveFlowSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.titleStr = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    //本地获取选中选项的下标
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([[defaults objectForKey:@"setting_saveflow_selectedindexpath"] integerValue] == indexPath.row) {
        
        cell.isSelected = YES;
        
    } else {
        
        cell.isSelected = NO;
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //循环设置所有cell为未选中样式
    
    for (NSIndexPath *indexPathItem in self.tableView.indexPathsForVisibleRows) {
        
        SaveFlowSettingCell *cell = (SaveFlowSettingCell *)[tableView cellForRowAtIndexPath:indexPathItem];
        
        cell.isSelected = NO;
        
    }
    
    //设置选中cell为选中样式
    
    SaveFlowSettingCell *cell = (SaveFlowSettingCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.isSelected = YES;
    
    //将设置内容持久化
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"setting_saveflow_selectedindexpath"];
    
    [defaults synchronize];
    
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
