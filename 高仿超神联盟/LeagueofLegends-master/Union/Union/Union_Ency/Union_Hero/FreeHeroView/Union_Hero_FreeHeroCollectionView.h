//
//  Union_Hero_FreeHeroCollectionView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GearPowered.h"

typedef void (^HeroDetailBlock)(NSString *heroName);

@interface Union_Hero_FreeHeroCollectionView : UICollectionView<UICollectionViewDataSource , UICollectionViewDelegate , GearPoweredDelegate>


//英雄详情block

@property (nonatomic , copy ) HeroDetailBlock heroDetailBlock;


@end
