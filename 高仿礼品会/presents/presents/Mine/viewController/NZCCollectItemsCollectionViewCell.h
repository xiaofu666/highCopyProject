//
//  NZCCollectItemsCollectionViewCell.h
//  presents
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol collectionDelegate <NSObject>

- (void)passValueWithUrl:(NSString *)url withItem:(NSDictionary *)item withArray:(NSArray *)array;

@end

@interface NZCCollectItemsCollectionViewCell : UICollectionViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) SAKeyValueStore *store;

@property (nonatomic, strong) NZCCollectModel *collectModel;

@property (nonatomic, assign)id<collectionDelegate>delegate;




@end
