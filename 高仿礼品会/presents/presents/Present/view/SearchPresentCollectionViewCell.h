//
//  SearchPresentCollectionViewCell.h
//  presents
//
//  Created by dapeng on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchPresentCollectionViewCellDelegate  <NSObject>

- (void)passArray:(NSArray *)arr withModel:(HotModel *)model withString:(NSString *)url;
@end



@interface SearchPresentCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSMutableArray *presentArr;
@property (nonatomic, assign) id<SearchPresentCollectionViewCellDelegate> searchPDelegate;
@property (nonatomic, copy) NSString *next_url;
@end
