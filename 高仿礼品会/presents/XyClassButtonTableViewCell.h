//
//  XyClassButtonTableViewCell.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XyButtonCollectionViewCell.h"
#import "XyClassButtonModel.h"
#import "ButtonArrayModel.h"

@interface XyClassButtonTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) XyClassButtonModel *model;
@property (strong, nonatomic) UILabel *labels;

@end
