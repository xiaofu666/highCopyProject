//
//  MyHeroTableView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GearPowered.h"

typedef void (^HeroDetailBlock)(NSString *heroName);

@interface MyHeroTableView : UITableView<GearPoweredDelegate , UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , copy ) NSString *summonerName;//用户名称(召唤师名称)

@property (nonatomic , copy ) NSString *serverName;//服务器名称(召唤师区名称)

//英雄详情block

@property (nonatomic , copy ) HeroDetailBlock heroDetailBlock;

//加载数据

- (void)loadData;



@end
