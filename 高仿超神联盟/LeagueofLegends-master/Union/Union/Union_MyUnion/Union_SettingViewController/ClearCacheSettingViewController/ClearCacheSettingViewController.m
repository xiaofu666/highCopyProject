//
//  ClearCacheSettingViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ClearCacheSettingViewController.h"

#import "ClearCacheSettingCell.h"

#import "DataCache.h"

#import <MBProgressHUD.h>

#import <SDImageCache.h>

@interface ClearCacheSettingViewController ()<UITableViewDelegate , UITableViewDataSource , MBProgressHUDDelegate>

@property (nonatomic , retain ) DataCache *dataCache;

@property (nonatomic , retain ) UITableView *tableView;

@property (nonatomic , retain ) NSMutableDictionary *clearDic;

@property (nonatomic , retain ) UIButton *clearButton;


@property (nonatomic , assign ) CGFloat heroSize;

@property (nonatomic , assign ) CGFloat equipSize;

@property (nonatomic , assign ) CGFloat imageSize;

@property (nonatomic , assign ) CGFloat newsSize;

@end

@implementation ClearCacheSettingViewController

-(void)dealloc{
    
    [_tableView release];
    
    [_clearButton release];
    
    [super dealloc];
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dataCache = [DataCache shareDataCache];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"清空缓存设置";
    
    _clearDic = [[NSMutableDictionary alloc]init];
    
    //初始化表视图
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[ClearCacheSettingCell class] forCellReuseIdentifier:@"cell"];

    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame) , 44)];
    
    footView.backgroundColor = [UIColor clearColor];
    
    _tableView.tableFooterView = footView;
    
    
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _clearButton.frame = CGRectMake(20 , 0 , CGRectGetWidth(self.view.frame) - 40 , 44);
    
    _clearButton.backgroundColor = [UIColor colorWithRed:250/255.0 green:85/255.0 blue:88/255.0 alpha:1];
    
    _clearButton.clipsToBounds = YES;
    
    _clearButton.layer.cornerRadius = 5.0f;
    
    [_clearButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [_clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_clearButton addTarget:self  action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:_clearButton];
    
    
    
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];

}


#pragma mark ---视图已经出现

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [_tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---清空按钮响应事件

- (void)clearButtonAction:(UIButton *)sender{
    
    //英雄资料清空判断
    
    if ([[_clearDic valueForKey:@"HeroCell"] isClear]) {
        
        [[DataCache shareDataCache] removeClassifyCacheWithClassify:@"Hero"];
        
        [[_clearDic valueForKey:@"HeroCell"] setDetailStr:@"0.00KB"];
        
    }
    
    //物品资料清空判断
    
    if ([[_clearDic valueForKey:@"EquipCell"] isClear]) {
        
        [[DataCache shareDataCache] removeClassifyCacheWithClassify:@"Equip"];
        
        [[_clearDic valueForKey:@"EquipCell"] setDetailStr:@"0.00KB"];
        
    }
    
    //图片清空判断
    
    if ([[_clearDic valueForKey:@"ImageCell"] isClear]) {
        
        //清空内存中所有图片
        
        [[SDImageCache sharedImageCache]clearMemory];
        
        //清空磁盘所有图片
        
        [[SDImageCache sharedImageCache]clearDisk];
        
        [[_clearDic valueForKey:@"ImageCell"] setDetailStr:@"0.00KB"];
        
    }
    
    //资讯资料清空判断
    
    if ([[_clearDic valueForKey:@"NewsCell"] isClear]) {
        
        [[DataCache shareDataCache] removeClassifyCacheWithClassify:@"News"];
        
        [[_clearDic valueForKey:@"NewsCell"] setDetailStr:@"0.00KB"];
        
    }
    
    //提示视图
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.delegate = self;
    
    hud.labelText = @"成功清空缓存";
    
    [hud show:YES];
    
    [hud hide:YES afterDelay:2.0f];
    
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    //提示框隐藏时 删除提示框视图
    
    [hud removeFromSuperview];
    
    [hud release];
    
    hud = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ---UITableViewDataSource,UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClearCacheSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
            
        case 0:
        {
            
            cell.titleStr = @"英雄资料缓存";
            
            cell.detailStr = [self.dataCache getKBorMBorGBWith:self.heroSize];
            
            cell.isClear = NO;
            
            [_clearDic setObject:cell forKey:@"HeroCell"];
            
        }
            break;
            
        case 1:
        {
            
            cell.titleStr = @"物品资料缓存";
            
            cell.detailStr = [self.dataCache getKBorMBorGBWith:self.equipSize];
            
            cell.isClear = NO;
            
            [_clearDic setObject:cell forKey:@"EquipCell"];
            
        }
            break;
            
        case 2:
        {
            
            cell.titleStr = @"图片缓存";
            
            cell.detailStr = [self.dataCache getKBorMBorGBWith:self.imageSize];
            
            cell.isClear = YES;
            
            [_clearDic setObject:cell forKey:@"ImageCell"];
            
        }
            break;
            
        case 3:
        {
            
            cell.titleStr = @"资讯缓存";
            
            cell.detailStr = [self.dataCache getKBorMBorGBWith:self.newsSize];
            
            cell.isClear = NO;
            
            [_clearDic setObject:cell forKey:@"NewsCell"];
            
        }
            break;
            
        default:
        {
            
            
        }
            break;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            //英雄资料缓存
            
            
            break;
            
        case 1:
            
            //物品资料缓存
            
            break;
            
        case 2:
            
            //图片缓存
            
            break;
            
        case 3:
            
            //资讯缓存
            
            
            
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

-(CGFloat)heroSize{
    
    return [self.dataCache getCacheSizeWithClassify:@"Hero"];
    
}

-(CGFloat)equipSize{
    
    return [self.dataCache getCacheSizeWithClassify:@"Equip"];
    
}

-(CGFloat)imageSize{
    
    return (CGFloat)[[SDImageCache sharedImageCache] getSize];
    
}

-(CGFloat)newsSize{
    
    return [self.dataCache getCacheSizeWithClassify:@"News"];
    
}


#pragma mark ---获取全部缓存大小

- (NSString *)getAllCacheSizeString{
    
    CGFloat allSize = self.heroSize + self.equipSize + self.imageSize + self.newsSize;
    
    return [self.dataCache getKBorMBorGBWith:allSize];
    
}


@end
