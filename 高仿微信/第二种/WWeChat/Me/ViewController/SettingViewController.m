//
//  SettingViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/8.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "SettingViewController.h"
#import "WWeChatApi.h"
#import "PreViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)NSArray * dataArr;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preData];
}
//准备数据
- (void)preData
{
    
    _dataArr = @[@[@"帐号与安全"],
                 @[@"新消息通知",@"隐私",@"通用"],
                 @[@"帮助与反馈",@"关于微信"],
                 @[@"退出登录"]
                 ];
    
    if(_tableView)
    {
        [_tableView reloadData];
    }
    else
    {
        [self createTableView];
    }
}

//创建tableView
- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        //调整下分隔线位置
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

#pragma mark --tableView--
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

//每组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rowArr = _dataArr[section];
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"settingCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _dataArr.count -1)
    {
        UILabel * backLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
        backLabel.text = _dataArr[indexPath.section][indexPath.row];
        backLabel.font = [UIFont systemFontOfSize:17];
        backLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:backLabel];
    }
    else
    {
        cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
        //右侧小箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
}

//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WGiveHeight(43);
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(15);
    }
    return WGiveHeight(10);
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WGiveHeight(10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == _dataArr.count -1)
    {
        MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WWeChatApi giveMeApi]LogoutAndSuccess:^(id response) {
            NSLog(@"退出登录成功");
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [muDic setValue:nil forKey:@"mid"];
            [muDic setValue:nil forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
            [[NSUserDefaults standardUserDefaults]synchronize];
        
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            PreViewController * preVC = [storyBoard instantiateViewControllerWithIdentifier:@"PreViewController"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].keyWindow.rootViewController = preVC;
                [hub hideAnimated:YES];
            });
        } andFailure:^{
            NSLog(@"退出登录失败");
        } andError:^(NSError *error) {
            NSLog(@"退出登录错误");
        }];
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

@end
