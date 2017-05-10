//
//  XHQZUIXINDatabase.h
//  AutoHome
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "FMDatabase.h"
#import "XHQZuiXinModel.h"
@interface XHQZUIXINDatabase : FMDatabase
+ (instancetype)sharedManager;

- (void)addRecord:(XHQZuiXinModel *)model;


- (void)deleteRecord:(XHQZuiXinModel *)model;


- (NSArray *)findAll;
// 传入一个数据, 判断这条数据是否存在
- (BOOL)modelIsExists:(XHQZuiXinModel *)model;



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com