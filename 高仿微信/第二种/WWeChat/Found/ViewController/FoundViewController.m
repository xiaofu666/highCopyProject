//
//  FoundViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "FoundViewController.h"

#import "QuanViewController.h"
@interface FoundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSArray * dataArr;

@property(nonatomic,copy)NSArray * imgArr;

@end

@implementation FoundViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self preData];
    
    [self createTableView];
}

//准备数据
- (void)preData
{
    
    _dataArr = @[@[@"朋友圈"],
                 @[@"扫一扫",@"摇一摇"],
                 @[@"附近的人"],
                 @[@"购物",@"游戏"]
                 ];
    
    _imgArr = @[@[@"found_refresh"],
                @[@"found_saoyisao",@"found_yao"],
                @[@"found_nearby"],
                @[@"found_shop",@"found_game"]];
    
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
    static NSString * identifier = @"foundCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //右侧小箭头
       cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.imageView.image = [UIImage imageNamed:_imgArr[indexPath.section][indexPath.row]];
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
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

#pragma mark --选中Cell的方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //朋友圈
        if (indexPath.row == 0)
        {
            QuanViewController * quan = [[QuanViewController alloc]init];
            quan.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:quan animated:YES];
        }
    }
    else if(indexPath.section == 1)
    {
        //扫一扫
        if (indexPath.row == 0)
        {
            
        }
        //摇一摇
        else if(indexPath.row == 1)
        {
        
        }
    }
    else if(indexPath.section == 2)
    {
        //附近的人
        if (indexPath.row == 0)
        {
            
        }
    }
    else if(indexPath.section == 3)
    {
        //购物
        if (indexPath.row == 0)
        {
            
        }
        //游戏
        else if(indexPath.row == 1)
        {
            
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
