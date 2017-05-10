//
//  EquipSelectDetailsViewController.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/12.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EquipSelectModel.h"

@interface EquipSelectDetailsViewController : UIViewController

@property (nonatomic , retain ) NSMutableArray *skillDataArray;//技能数据数组

@property (nonatomic , retain ) EquipSelectModel *model;//数据模型

@end
