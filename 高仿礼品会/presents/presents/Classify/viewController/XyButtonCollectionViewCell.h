//
//  XyButtonCollectionViewCell.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonArrayModel.h"
@interface XyButtonCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) ButtonArrayModel *model;
@property (strong, nonatomic) UIImageView *imageViews;
@property (strong, nonatomic) UILabel *labels;

@end
