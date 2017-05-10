//
//  MeViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "MeViewController.h"
#import "PersonCell.h"
#import "PersonModel.h"

#import "UserInfoManager.h"
#import "SettingViewController.h"
#import "PersonViewController.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSArray * dataArr;

@property(nonatomic,copy)NSArray * imgArr;

@property(nonatomic,strong)PersonModel * model;

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self preData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createTableView];
}

//准备数据
- (void)preData
{
    
    _dataArr = @[@[@""],
                 @[@"相册",@"收藏",@"钱包"],
                 @[@"表情"],
                 @[@"设置"]
                 ];
    
    _imgArr = @[@[@""],
                @[@"me_photo",@"me_collect",@"me_money"],
                @[@"me_smail"],
                @[@"me_setting"]
                ];
    
    _model = [[PersonModel alloc]init];
    _model.avater = [[UserInfoManager manager]avaterUrl];
    _model.nickName = [[UserInfoManager manager]userName];
    _model.weID = [[UserInfoManager manager]wxID];
    
    if(_tableView)
    {
        [_tableView reloadData];
    }
}

//创建tableView
- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) style:UITableViewStyleGrouped];
        
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
    if (indexPath.section == 0)
    {
        PersonCell * cell = [[PersonCell alloc]init];
        return cell;
    }
    else
    {
        static NSString * identifier = @"meCell";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                //右侧小箭头
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
  
    
    
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.section == 0)
   {
       PersonCell * personCell = (PersonCell *)cell;
       [personCell setModel:_model];
   }
   else
   {
        cell.imageView.image = [UIImage imageNamed:_imgArr[indexPath.section][indexPath.row]];
        cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
   }
}

//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return WGiveHeight(87);
    }
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

#pragma mark --选中Cell的方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //个人中心
        if (indexPath.row == 0)
        {
            PersonViewController * personVC = [[PersonViewController alloc]init];
             personVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personVC animated:YES];
        }
    }
    else if(indexPath.section == 1)
    {
        //相册
        if (indexPath.row == 0)
        {
            
        }
        //收藏
        else if(indexPath.row == 1)
        {
            
        }
        //钱包
        else if(indexPath.row == 21)
        {
            
        }
    }
    else if(indexPath.section == 2)
    {
        //表情
        if (indexPath.row == 0)
        {
            
        }
    }
    else if(indexPath.section == 3)
    {
        //设置
        if (indexPath.row == 0)
        {
            SettingViewController * settingVC = [[SettingViewController alloc]init];
            settingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
        }
    }
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
