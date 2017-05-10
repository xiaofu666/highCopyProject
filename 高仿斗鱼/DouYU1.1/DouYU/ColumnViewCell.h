//
//  ColumnViewCell.h
//  DouYU
//
//  Created by Alesary on 15/11/2.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"

@interface ColumnViewCell : UICollectionViewCell


-(void)setContentWith:(ColumnModel *)model;
@end
