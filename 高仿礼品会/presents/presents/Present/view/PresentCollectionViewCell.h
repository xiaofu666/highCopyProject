//
//  PresentCollectionViewCell.h
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol presentCollectionViewCellDelegate <NSObject>

- (void)toPDetailVCDelegate:(NSString *)pageurl withImageUrl:(NSString *)imageUrl withTitle:(NSString *)title;

@end


@interface PresentCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) NSMutableArray *carouselArray;
@property (nonatomic, retain) NSMutableArray *buttonModelArray;
@property (nonatomic, retain) NSMutableArray *CellModelArray;
@property (nonatomic, retain) NSMutableArray *IdArray;
@property (nonatomic, strong) Carousel       *carousel;
@property (nonatomic, copy) NSString       *ids;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, assign) id<presentCollectionViewCellDelegate>PrsentDelegate;
@end
