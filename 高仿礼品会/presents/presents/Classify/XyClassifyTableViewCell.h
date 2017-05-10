//
//  XyClassifyTableViewCell.h
//  presents
//
//  Created by Xy on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XyClassifyCollectionViewCell.h"
#import "XyClassifyModel.h"

@interface XyClassifyTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) XyClassifyModel *model;

@end
