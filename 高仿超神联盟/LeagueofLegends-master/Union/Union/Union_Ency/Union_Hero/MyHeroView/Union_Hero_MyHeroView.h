//
//  Union_Hero_MyHeroView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddSummonerBlock)();

typedef void (^HeroDetailBlock)(NSString *heroName);

@interface Union_Hero_MyHeroView : UIView


@property (nonatomic , copy )AddSummonerBlock addSummonerBlock;//添加召唤师block 用于跳转添加视图控制器

//英雄详情block

@property (nonatomic , copy ) HeroDetailBlock heroDetailBlock;

//显示我的英雄视图

- (void)showMyHeroView;


@end

