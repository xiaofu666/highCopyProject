//
//  SortCollectionViewCell.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SortModel.h"

@interface SortCollectionViewCell : UICollectionViewCell

@property (nonatomic ,retain) SortModel *sortModel;

@property (nonatomic ,retain) UIImageView *imageView;

@property (nonatomic ,retain) UILabel *titleLable;

@property (nonatomic ,retain) UILabel *upDataLable;

@end
