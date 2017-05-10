//
//  Union_Video_SortCollectionView.h
//  Union
//
//  Created by lanou3g on 15-7-19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GearPowered.h"
typedef void (^myBlock) (NSString *tag , NSString *name);

typedef void (^VideoSearchBlock)(NSString *videoName);

@interface Union_Video_SortCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GearPoweredDelegate>

@property (nonatomic ,copy) myBlock block;

@property (nonatomic ,copy) VideoSearchBlock videoSearchBlock;//视频搜索block

@end
