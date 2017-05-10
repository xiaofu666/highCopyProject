//
//  SettingViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SettingViewController.h"

#import "SettingCell.h"


#import "MessagePushSettingViewController.h"

#import "SaveFlowSettingViewController.h"

#import "ClearCacheSettingViewController.h"


#import <MobClick.h>

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , retain ) UITableView *tableView;


@property (nonatomic , retain ) MessagePushSettingViewController *messagePushSettingVC;//消息推送设置视图控制器

@property (nonatomic , retain ) SaveFlowSettingViewController *saveFlowSettingVC;//省流量设置视图控制器

@property (nonatomic , retain ) ClearCacheSettingViewController *clearCacheSettingVC;//清空缓存设置视图控制器


@end

@implementation SettingViewController

-(void)dealloc {
    
    [_tableView release];
    
    [_messagePushSettingVC release];
    
    [_saveFlowSettingVC release];
    
    [_clearCacheSettingVC release];
    
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    //初始化表视图
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"cell"];
    
    
}

#pragma mark ---视图出现时

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //视图出现时 刷新表视图
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---UITableViewDataSource,UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return 3;
            
            break;
            
        case 1:
        {
            
            //获取在线参数判断是否显示下载相关
            
            BOOL isShowDownLoad = [[MobClick getConfigParams:@"isShowDownLoad"] boolValue];
            
            if (isShowDownLoad) {
                
                return 1;
                
            } else {
                
                return 0;
                
            }
            
        }
            break;
            
        default:
            
            return 0;
            
            break;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    switch (indexPath.section) {
        case 0:
            
            switch (indexPath.row) {
                case 0:
                {
                    
                    cell.titleStr = @"消息推送设置";
                    
                    cell.style = SettingCellStyleLabel;
                    
                }
                    break;
                    
                case 1:
                {
                    
                    cell.titleStr = @"省流量";
                    
                    cell.detailStr = @"资讯图片自动加载设置";
                    
                    cell.style = SettingCellStyleLabel;
                    
                }
                    break;
                    
                case 2:
                {
                    
                    cell.titleStr = @"清除缓存";
                    
                    cell.detailStr = [self.clearCacheSettingVC getAllCacheSizeString];
                    
                    cell.style = SettingCellStyleLabel;
                    
                }
                    break;
                    
                default:
                {
                    
                    
                }
                    break;
            }

            
            break;
            
        case 1:
            
            cell.titleStr = @"隐藏缓存气泡";
            
            cell.style = SettingCellStyleSwitch;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            cell.isOpen = [[defaults objectForKey:@"settingDownloadviewHiddenOrShow"] boolValue];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            break;
            
        default:
            break;
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            switch (indexPath.row) {
                case 0:
                    
                    //消息推送设置
                    
                    [self.navigationController pushViewController:self.messagePushSettingVC animated:YES];
                    
                    break;
                    
                case 1:
                    
                    //省流量
                    
                    [self.navigationController pushViewController:self.saveFlowSettingVC animated:YES];
                    
                    break;
                    
                case 2:
                    
                    //清除缓存
                    
                    [self.navigationController pushViewController:self.clearCacheSettingVC animated:YES];
                    
                    break;
                    
                default:
                    break;
            }

            
            break;
            
        case 1:
            
            //隐藏缓存气泡cell
            
            break;
            
        default:
            break;
    }
    
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

-(MessagePushSettingViewController *)messagePushSettingVC{
    
    if (_messagePushSettingVC == nil) {
        
        _messagePushSettingVC = [[MessagePushSettingViewController alloc]init];
        
    }
    
    return _messagePushSettingVC;
    
}

-(SaveFlowSettingViewController *)saveFlowSettingVC{
    
    if (_saveFlowSettingVC == nil) {
        
        _saveFlowSettingVC = [[SaveFlowSettingViewController alloc]init];
        
    }
    
    return _saveFlowSettingVC;
    
}

-(ClearCacheSettingViewController *)clearCacheSettingVC{
    
    if (_clearCacheSettingVC == nil) {
        
        _clearCacheSettingVC = [[ClearCacheSettingViewController alloc]init];
        
    }
    
    return _clearCacheSettingVC;
    
}


@end
