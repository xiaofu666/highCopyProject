//
//  SearchCollectionViewCell.h
//  presents
//
//  Created by dapeng on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchCollectionViewCellDelegate <NSObject>

- (void)toPDetailDelegate:(NSString *)pageurl withImageUrl:(NSString *)imageUrl withTitle:(NSString *)title;

@end
@interface SearchCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSMutableArray *guidesArr;
@property (nonatomic, assign) id<SearchCollectionViewCellDelegate>searchDelegate;
@end
