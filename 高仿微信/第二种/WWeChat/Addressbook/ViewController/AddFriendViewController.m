//
//  AddFriendViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/17.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "AddFriendViewController.h"
#import "UserInfoManager.h"
#import "SearchFriendViewController.h"
#import "AddressBookViewController.h"
@interface AddFriendViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSArray * dataArr;


@end

@implementation AddFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加好友";
    
    [self preData];
    
    [self createTableView];
}

- (void)preData
{
    _dataArr = @[
                 @{
                    @"title":@"雷达加好友",
                    @"detail":@"添加身边的好友",
                    @"img":@"add_friend_icon_reda.png"
                     },
                 @{
                     @"title":@"面对面建群",
                     @"detail":@"与身边的朋友进入同一个群聊",
                     @"img":@"add_friend_icon_addgroup.png"
                     },
                 @{
                     @"title":@"扫一扫",
                     @"detail":@"扫描二维码名片",
                     @"img":@"add_friend_icon_scanqr.png"
                     },
                 @{
                     @"title":@"手机联系人",
                     @"detail":@"添加或邀请通讯录中的朋友",
                     @"img":@"add_friend_icon_contacts.png"
                     },
                 @{
                     @"title":@"公众号",
                     @"detail":@"获取更多的资讯与服务",
                     @"img":@"add_friend_icon_offical.png"
                     }
                 ];
}

- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        
        tableView.dataSource= self;
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

#pragma mark --tableView--
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//每组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return _dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"addFriendCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
        if (cell == nil)
        {
            if(indexPath.section == 0)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            else
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                //右侧小箭头
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        return cell;
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        cell.imageView.image = [UIImage imageNamed:@"add_friend_searchicon"];
        cell.textLabel.text = @"微信号/手机号";
        cell.textLabel.textColor = [UIColor grayColor];
        
    }
    else
    {
        NSDictionary * dic = _dataArr[indexPath.row];
        cell.textLabel.text = dic[@"title"];
        cell.detailTextLabel.text = dic[@"detail"];
        cell.imageView.image = [UIImage imageNamed:dic[@"img"]];
    }
}

//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return WGiveHeight(46);
    }
    else
    {
        return WGiveHeight(58);
    }
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(15);
    }
    else
    {
        return WGiveHeight(60);
    }
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, WGiveHeight(60))];
        
        UILabel * wxLabel = [[UILabel alloc]initWithFrame:CGRectMake(WGiveWidth(70), 0, WGiveWidth(68), WGiveHeight(30))];
        wxLabel.text = [NSString stringWithFormat:@"我的微信号:"];
        wxLabel.font = [UIFont systemFontOfSize:14];
        [headerView addSubview:wxLabel];
        
        
        UILabel * wxIDLabel = [[UILabel alloc]initWithFrame:CGRectMake(wxLabel.frame.size.width + wxLabel.frame.origin.x, 0, WGiveWidth(75), WGiveHeight(30))];
        wxIDLabel.text = [NSString stringWithFormat:@"%@",[[UserInfoManager manager]wxID]];
        wxIDLabel.textAlignment = NSTextAlignmentCenter;
        wxIDLabel.font = [UIFont systemFontOfSize:14];
        [headerView addSubview:wxIDLabel];
        
        
        UIImageView * qrImgView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(213), WGiveHeight(8), WGiveHeight(16), WGiveHeight(16))];
        qrImgView.image = [UIImage imageNamed:@"add_friend_myQR"];
        [headerView addSubview:qrImgView];
        
        return headerView;
    }
    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
//        [self presentViewController:[[SearchFriendViewController alloc]init] animated:YES completion:^{
//            
//        }];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
