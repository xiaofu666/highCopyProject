//
//  EquipSelectDetailsItemView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PCH.h"

#import "Hero_Details_SkillModel.h"

typedef void (^SelectedSkillImageViewBlock)(Hero_Details_SkillModel *model);

typedef void (^SelectedEquipImageViewBlock)(NSInteger equipID);

@interface EquipSelectDetailsItemView : UIView

@property (nonatomic , copy ) NSString *enHeroName;//英雄英文名

@property (nonatomic , retain ) NSMutableArray *skillDataArray;//技能数据数组

@property (nonatomic , retain ) NSArray *skillArray;//技能数组

@property (nonatomic , retain ) NSArray *equipArray;//装备数组

@property (nonatomic , copy ) NSString *title;//标题字符串

@property (nonatomic , copy ) NSString *explainStr;//注释字符串


@property (nonatomic , copy ) SelectedSkillImageViewBlock selectedSkillImageViewBlock;//选中技能图片Block

@property (nonatomic , copy ) SelectedEquipImageViewBlock selectedEquipImageViewBlock;//选中装备图片Block



- (instancetype)initWithFrame:(CGRect)frame isSkill:(BOOL)isSkill;

@end
