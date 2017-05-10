//
//  SummonerListTableViewCell.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SummonerModel.h"

typedef void (^ReloadDataBlock)();

@interface SummonerListTableViewCell : UITableViewCell

@property (nonatomic , retain ) SummonerModel *summonerModel;//召唤师数据模型

@property (nonatomic , assign ) BOOL isDefault;//是否为默认

@property (nonatomic , copy ) ReloadDataBlock reloadDataBlock;//更新数据block

@end
