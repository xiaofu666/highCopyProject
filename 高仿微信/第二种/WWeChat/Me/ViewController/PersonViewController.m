//
//  PersonViewController.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/3.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PersonViewController.h"

#import "UserInfoManager.h"

#import "ChangeDataViewController.h"

@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSArray * titleArr;

@property(nonatomic,copy)NSArray * valueArr;

@end

@implementation PersonViewController
{
    UIImage * _avaterImg;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self preData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self preData];
}

- (void)preData
{
    _titleArr = @[
                  @[
                      @"头像",
                      @"名字",
                      @"微信号",
                      @"我的二维码",
                      @"我的地址"
                      ]
                      ,
                  @[
                      @"性别",
                      @"地区",
                      @"个性签名"
                      ]

                  ];
    
    _valueArr = @[
                  @[
                      [[UserInfoManager manager]avaterUrl],
                      [[UserInfoManager manager]userName],
                      [[UserInfoManager manager]wxID],
                      @"me_wm",
                      @""
                      ]
                  ,
                  @[
                      [[UserInfoManager manager]sex]==YES?@"男":@"女",
                      @"上海 杨浦",
                      [[UserInfoManager manager]sign]
                      ]
                  
                  ];
    
    if (_tableView)
    {
        [_tableView reloadData];
    }
    else
    {
        [self createTableView];
    }
}

- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);;
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

#pragma mark -- tableView --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = _titleArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"PersonCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(220), (cell.frame.size.height - WGiveHeight(64))/2.0, WGiveHeight(64), WGiveHeight(64))];
        
            [imageView setImageWithURL:[NSURL URLWithString:_valueArr[indexPath.section][indexPath.row]] placeholderImage:[[UserInfoManager manager] avater] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                _avaterImg = image;
                
                [[UserInfoManager manager]saveImgDataWithImg:image];
            }];
        
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 0 && indexPath.row == 3)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(270), (cell.frame.size.height - WGiveHeight(18))/2.0, WGiveHeight(18), WGiveHeight(18))];
        
        imageView.image = [UIImage imageNamed:@"me_wm"];

        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        UILabel * signLabel = [[UILabel alloc]initWithFrame:CGRectMake(WGiveWidth(148), 0, WGiveWidth(145), cell.frame.size.height)];
        signLabel.text = [[UserInfoManager manager]sign];
        signLabel.textAlignment = NSTextAlignmentRight;
        signLabel.textColor = [UIColor grayColor];
        signLabel.numberOfLines = 0;
        [cell.contentView addSubview:signLabel];
    }
    else
    {
        NSLog(@"font%@  color%@",cell.textLabel.font,cell.textLabel.textColor);
        cell.detailTextLabel.text = _valueArr[indexPath.section][indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return WGiveHeight(80);
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        return [self giveMeHeightWithStr:[[UserInfoManager manager]sign]]<WGiveHeight(44)?WGiveHeight(44):[self giveMeHeightWithStr:[[UserInfoManager manager]sign]];
    }
    else
    {
        return WGiveHeight(44);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(15);
    }
    else
    {
        return WGiveHeight(20);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //修改头像
        if (indexPath.row == 0)
        {
            ChangeDataViewController * changeDataVC = [[ChangeDataViewController alloc]initWithType:ChangeAvater];
            changeDataVC.avaterView.image = [[UserInfoManager manager]avater];
            [self.navigationController pushViewController:changeDataVC animated:YES];
        }
        //修改用户名
        else if(indexPath.row == 1)
        {
            [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeNickName] animated:YES];
        }
        //微信号（不能修改）
        else if(indexPath.row == 2)
        {
            
        }
        //二维码 
        else if(indexPath.row == 3)
        {
            
        }
        //地址
        else if(indexPath.row == 4)
        {
             [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeAddress] animated:YES];
        }
    }
    else
    {
        //性别
        if (indexPath.row == 0)
        {
             [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeSex] animated:YES];
        }
        //地区
        else if(indexPath.row == 1)
        {
             [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangePath] animated:YES];
        }
        //个性签名
        else if(indexPath.row == 2)
        {
             [self.navigationController pushViewController:[[ChangeDataViewController alloc]initWithType:ChangeSign] animated:YES];
        }
    }
}

- (CGFloat)giveMeHeightWithStr:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(WGiveWidth(145), MAXFLOAT)
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize.height;
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
