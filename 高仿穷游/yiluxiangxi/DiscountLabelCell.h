//
//  DiscountLabelCell.h
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/6.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountLabelCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView* disImageView;
@property(nonatomic,strong) UILabel* disTitlelabel;

@property(nonatomic,strong) UIImageView* disTimeImage;
@property(nonatomic,strong) UILabel* disTimeLabel;

@property(nonatomic,strong) UILabel* disDiscountLabel;
@property(nonatomic,strong) UILabel* disPriceLabel;

@end
