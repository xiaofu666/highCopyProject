//
//  XyLinkageCollectionViewCell.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 Xy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XyGiftCollectionModel.h"

@interface XyLinkageCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIImageView *imageViews;

@property (nonatomic, retain) XyGiftCollectionModel *giftModel;

@end
