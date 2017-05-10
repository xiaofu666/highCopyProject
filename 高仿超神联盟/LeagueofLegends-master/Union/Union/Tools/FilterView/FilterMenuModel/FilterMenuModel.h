//
//  FilterMenuModel.h
//  筛选栏封装
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

@interface FilterMenuModel : NSObject


@property (nonatomic , copy ) NSString *menuTitle; //菜单标题

@property (nonatomic , retain ) NSDictionary *menuDic;//菜单内容字典


@end
