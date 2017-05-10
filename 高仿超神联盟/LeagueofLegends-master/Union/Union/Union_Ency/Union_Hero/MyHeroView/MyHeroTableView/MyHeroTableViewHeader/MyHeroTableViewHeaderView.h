//
//  MyHeroTableViewHeaderView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeroTableViewHeaderView : UIView

@property (nonatomic , copy ) NSString *serverFullName;//服务器全名

@property (nonatomic , assign ) NSInteger heroCount;//英雄数量

@property (nonatomic , assign ) NSInteger heroGoldPrice;//英雄金币价格


//添加数据

- (void)addData;

@end
