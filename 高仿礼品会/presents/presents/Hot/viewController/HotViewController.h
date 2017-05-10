//
//  HotViewController.h
//  presents
//
//  Created by dapeng on 16/1/6.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotModel;


@interface HotViewController : BaseViewController

@property (nonatomic, strong) HotModel *hotModel;
//@property (nonatomic, retain) PageModel *pageModel;

@property (nonatomic, copy) NSString *string;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *mutableArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
