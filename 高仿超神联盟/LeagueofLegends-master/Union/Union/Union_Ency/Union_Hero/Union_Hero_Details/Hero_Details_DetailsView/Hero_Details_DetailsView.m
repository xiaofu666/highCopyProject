//
//  Hero_Details_DetailsView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_DetailsView.h"

#import <UITableView+FDTemplateLayoutCell.h>


#import "Hero_Details_Details_SkillCell.h"

#import "Hero_Details_Details_TipsCell.h"

#import "Hero_Details_Details_LikeANDHateCell.h"

#import "Hero_Details_Details_DataCell.h"

#import "Hero_Details_BasicModel.h"

#import "Hero_Details_DataModel.h"


@interface Hero_Details_DetailsView ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain ) NSMutableDictionary *cellHeightDic;//

@end

@implementation Hero_Details_DetailsView

-(void)dealloc{
    
    [_cellHeightDic release];
    
    [_dataDic release];
    
    [super dealloc];
    
}

//初始化

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        //初始化CELL高度字典
        
        _cellHeightDic = [[NSMutableDictionary alloc]init];
        
        //添加初始值
        
        for (int i = 0; i < 7; i++) {
            
            [_cellHeightDic setValue:[NSNumber numberWithFloat:300.0f] forKey:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        //设置代理
        
        self.delegate = self;
        
        self.dataSource = self;
        
        //注册技能cell
        
        [self registerClass:[Hero_Details_Details_SkillCell class] forCellReuseIdentifier:@"skillcell"];
        
        //注册搭档克制cell
        
        [self registerClass:[Hero_Details_Details_LikeANDHateCell class] forCellReuseIdentifier:@"likehatecell"];
        
        //注册技巧cell
        
        [self registerClass:[Hero_Details_Details_TipsCell class] forCellReuseIdentifier:@"tipscell"];
        
        //注册数据cell
        
        [self registerClass:[Hero_Details_Details_DataCell class] forCellReuseIdentifier:@"datacell"];
        
        //设置表视图样式无cell分隔线
        
        self.separatorStyle=UITableViewCellSeparatorStyleNone;

        
    }
    
    return self;
    
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if (_dataDic != dataDic) {
        
        [_dataDic release];
        
        _dataDic = [dataDic retain];
        
    }
    
    self.contentOffset = CGPointMake(0, 0);
    
    [self reloadData];
    
}


#pragma mark ---UITableViewDataSource , UITableViewDelegate

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [[self.cellHeightDic valueForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]] floatValue];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
            
        case 0:
        {
            //技能cell
            
            Hero_Details_Details_SkillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skillcell"];
            
            cell.title = @"技能介绍";
            
            cell.indexpath = indexPath;
            
            cell.dataArray = [self.dataDic valueForKey:@"skillArray"];
            
            cell.changeCellHeight = ^(NSIndexPath *indexpath , CGFloat height){
                
                [_cellHeightDic setValue:[NSNumber numberWithFloat:height] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
                
                [tableView reloadData];
                
            };
            
            return cell;
            
        }
            break;
            
        case 1:
        {
            
            //使用技巧cell
            
            Hero_Details_Details_TipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipscell"];
            
            cell.title = @"使用技巧";
            
            cell.indexpath = indexPath;
            
            Hero_Details_BasicModel *model = [self.dataDic valueForKey:@"basicModel"];
            
            cell.content = model.tips;
            
            [_cellHeightDic setValue:[NSNumber numberWithFloat:CGRectGetHeight(cell.frame)] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            
            return cell;
        }
            break;
            
        case 2:
        {
            //应对技巧cell
            
            Hero_Details_Details_TipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipscell"];
            
            cell.title = @"应对技巧";
            
            cell.indexpath = indexPath;
            
            Hero_Details_BasicModel *model = [self.dataDic valueForKey:@"basicModel"];
            
            cell.content = model.opponentTips;
            
            [_cellHeightDic setValue:[NSNumber numberWithFloat:CGRectGetHeight(cell.frame)] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];

            
            return cell;
        }
            break;
            
        case 3:
        {
            
            //数据cell
            
            Hero_Details_Details_DataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"datacell"];
            
            cell.title = @"英雄数据";
            
            cell.indexpath = indexPath;
            
            cell.model = [self.dataDic valueForKey:@"dataModel"];
            
            [_cellHeightDic setValue:[NSNumber numberWithFloat:CGRectGetHeight(cell.frame)] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            
            return cell;
        }
            break;
            
        case 4:
        {
            //最佳搭档cell
            
            Hero_Details_Details_LikeANDHateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"likehatecell"];
            
            cell.title = @"最佳搭档";
            
            cell.indexpath = indexPath;
            
            cell.dataArray = [self.dataDic valueForKey:@"likeArray"];
            
            [_cellHeightDic setValue:[NSNumber numberWithFloat:CGRectGetHeight(cell.frame)] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            
            __block typeof(self) Self = self;
            
            cell.selectedHeroToHeroDetails = ^(NSString *enHeroName){
                
                //传递选中的英雄英文名
                
                Self.selectedHeroToHeroDetails(enHeroName);
                
            };
            
            return cell;
        }
            break;
            
        case 5:
        {
            //最佳克制cell
            
            Hero_Details_Details_LikeANDHateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"likehatecell"];
            
            cell.title = @"最佳克制";
            
            cell.indexpath = indexPath;
            
            cell.dataArray = [self.dataDic valueForKey:@"hateArray"];
            
            [_cellHeightDic setValue:[NSNumber numberWithFloat:CGRectGetHeight(cell.frame)] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            
            __block typeof(self) Self = self;
            
            cell.selectedHeroToHeroDetails = ^(NSString *enHeroName){
                
                //传递选中的英雄英文名
                
                Self.selectedHeroToHeroDetails(enHeroName);
                
            };
            
            return cell;
        }
            break;
            
        case 6:
        {
            //英雄背景cell
            
            Hero_Details_Details_TipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipscell"];
            
            cell.title = @"背景故事";
            
            cell.indexpath = indexPath;
            
            Hero_Details_BasicModel *model = [self.dataDic valueForKey:@"basicModel"];
            
            cell.content = model.heroDescription;
            
            [_cellHeightDic setValue:[NSNumber numberWithFloat:CGRectGetHeight(cell.frame)] forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            
            return cell;
        }
            break;
            
        default:
        {
            return nil;
        }
            break;
    }
    
}


@end
