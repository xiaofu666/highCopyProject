//
//  SelectionCollectionViewCell.h
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selecttionCollectionViewCellDelegate <NSObject>

- (void)toPDetailVCDelegate:(NSString *)pageUrl withImageUrl:(NSString *)imageUrl withTitle:(NSString *)title;
- (void)toCarsouselNextVC:(NSString *)ids withUrl:(NSString *)url withNavTitle:(NSString *)title;



@end


@interface SelectionCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) NSMutableArray *carouselArray;
@property (nonatomic, retain) NSMutableArray *carouselTitleArray;
@property (nonatomic, strong) NSMutableArray *target_urlArr;

@property (nonatomic, retain) NSMutableArray *buttonModelArray;
@property (nonatomic, retain) NSMutableArray *CellModelArray;
@property (nonatomic, retain) NSMutableArray *IdArray;
@property (nonatomic, strong) Carousel *carousel;

@property (nonatomic, assign) id<selecttionCollectionViewCellDelegate>selectionDelegate;
@end
