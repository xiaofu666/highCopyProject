//
//  Hero_Details_EquipSelectListView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_EquipSelectListView.h"

#import "Hero_Details_EquipSelectCell.h"


@interface Hero_Details_EquipSelectListView ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain ) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , retain ) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end

@implementation Hero_Details_EquipSelectListView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        //设置代理
        
        self.delegate = self;
        
        self.dataSource = self;
        
        //注册cell
        
        [self registerClass:[Hero_Details_EquipSelectCell class] forCellReuseIdentifier:@"cell"];
        
        //设置表视图样式无cell分隔线
        
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        
    }
    
    return self;
    
}

#pragma mark ---获取英雄英文名

-(void)setEnHeroName:(NSString *)enHeroName{
    
    if (_enHeroName != enHeroName) {
        
        [_enHeroName release];
        
        _enHeroName = [enHeroName retain];
        
        self.contentOffset = CGPointMake(0, 0);
        
    }
 
    if (enHeroName != nil) {
        
        //加载数据
        
        [self loadData];
        
    }
    
}

#pragma mark ---加载数据

- (void)loadData{
    
    //隐藏
    
    self.hidden = YES;
    
    __block typeof(self) Self = self;
    
    //清除之前所有请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作
    
    [self.manager GET:[NSString stringWithFormat:kUnion_Ency_HeroDetails_EquipSelectURL , self.enHeroName] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //解析数据
            
            [Self JSONAnalyticalWithData:responseObject];
            
            //显示
            
            self.hidden = NO;
            
        } else {
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
}

#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(id)data{
    
    if (data != nil) {
        
        //清空数组
        
        [self.dataArray removeAllObjects];
        
        NSArray *tempArray = data;
     
        for (NSDictionary *itemDic in tempArray) {
            
            //创建数据模型
            
            EquipSelectModel *model = [[EquipSelectModel alloc]init];
            
            //赋值数据
            
            model.record_id = [[itemDic valueForKey:@"record_id"] retain];
            
            model.title = [[itemDic valueForKey:@"title"] retain];
            
            model.author = [[itemDic valueForKey:@"author"] retain];
            
            model.skill = [[itemDic valueForKey:@"skill"] retain];
            
            model.pre_cz = [[itemDic valueForKey:@"pre_cz"] retain];
            
            model.pre_explain = [[itemDic valueForKey:@"pre_explain"] retain];
            
            model.mid_cz = [[itemDic valueForKey:@"mid_cz"] retain];
            
            model.mid_explain = [[itemDic valueForKey:@"mid_explain"] retain];
            
            model.end_cz = [[itemDic valueForKey:@"end_cz"] retain];
            
            model.end_explain = [[itemDic valueForKey:@"end_explain"] retain];
            
            model.nf_cz = [[itemDic valueForKey:@"nf_cz"] retain];
            
            model.nf_explain = [[itemDic valueForKey:@"nf_explain"] retain];
            
            model.cost = [[itemDic valueForKey:@"cost"] retain];
            
            model.game_type = [[itemDic valueForKey:@"game_type"] retain];
            
            model.user_name = [[itemDic valueForKey:@"user_name"] retain];
            
            model.server = [[itemDic valueForKey:@"server"] retain];
            
            model.combat = [[itemDic valueForKey:@"combat"] retain];
            
            model.good = [[itemDic valueForKey:@"good"] retain];
            
            model.bad = [[itemDic valueForKey:@"bad"] retain];
            
            model.time = [[itemDic valueForKey:@"time"] retain];
            
            model.en_name = [[itemDic valueForKey:@"en_name"] retain];
            
            model.ch_name = [[itemDic valueForKey:@"ch_name"] retain];
            
            model.cost_nf = [[itemDic valueForKey:@"cost_nf"] retain];
            
            model.ni_name = [[itemDic valueForKey:@"ni_name"] retain];
            
            model.tags = [[itemDic valueForKey:@"tags"] retain];
            
            model.sc = [[itemDic valueForKey:@"sc"] retain];
            
            
            //添加数据源数组
            
            [self.dataArray addObject:model];
            
        }
        
        //更新表视图
        
        [self reloadData];
        
    }
    
}


#pragma mark ---UITableViewDataSource , UITableViewDelegate

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Hero_Details_EquipSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EquipSelectModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    //调用选中出装详情Block传递选中的model
    
    self.selectedEquipSelectDetailsBlock(model);
    
}



#pragma mark ---LazyLoading

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
        
    }
    
    return _dataArray;
    
}

-(AFHTTPRequestOperationManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [[AFHTTPRequestOperationManager manager] retain];
        
        // 设置超时时间
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer.timeoutInterval = 15.0f;
        
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    
    return _manager;
    
}



@end
