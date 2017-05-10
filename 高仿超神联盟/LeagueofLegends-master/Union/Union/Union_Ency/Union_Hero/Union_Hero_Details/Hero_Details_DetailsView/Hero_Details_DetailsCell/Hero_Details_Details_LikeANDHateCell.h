//
//  Hero_Details_Details_LikeANDHateCell.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Hero_Details_Details_BaseCell.h"

typedef void (^SelectedHeroToHeroDetails)(NSString *enHeroName);

@interface Hero_Details_Details_LikeANDHateCell : Hero_Details_Details_BaseCell

@property (nonatomic , retain ) NSMutableArray *dataArray ;//数据源数组

@property (nonatomic , copy ) SelectedHeroToHeroDetails selectedHeroToHeroDetails;//选中英雄到英雄详情Block

@end
