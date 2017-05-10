//
//  NZCHotCollectionViewCell.h
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZCHotCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HotModel *hotModel;
@property (nonatomic, strong) UIImageView *imageViews;
@property (nonatomic, strong) UIImageView *heartImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *likeCount;
@property (nonatomic, strong) SAKeyValueItem *item;

@end
