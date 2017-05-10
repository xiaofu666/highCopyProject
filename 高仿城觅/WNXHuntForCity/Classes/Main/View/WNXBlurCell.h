//
//  WNXBlurCell.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/18.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNXFoundCellModel.h"

@interface WNXBlurCell : UICollectionViewCell

/** 直接用found的模型 */
@property (nonatomic, strong) WNXFoundCellModel *model;

+ (instancetype)blurCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com