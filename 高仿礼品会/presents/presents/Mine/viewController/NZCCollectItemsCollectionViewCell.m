//
//  NZCCollectItemsCollectionViewCell.m
//  presents
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "NZCCollectItemsCollectionViewCell.h"

@implementation NZCCollectItemsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];


//        self.dataSource = [[NSMutableArray alloc] initWithCapacity:0];
//        
//        self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
//        
//        NSArray *array = [self.store getAllItemsFromTable:@"my_item"];
//
//        for (SAKeyValueItem *item in array) {
//            NSLog(@"%@", item.itemObject);
//            self.collectModel = [[NZCCollectModel alloc] initWithDictionary:item.itemObject];
//            [self.dataSource addObject:item];
//        }
    if (self) {
        
    
    
        [self creatCollectionView];
        
    }
    return self;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
    }
    [self.collectionView reloadData];
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark  返回单元格间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
#pragma mark 返回行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark 返回单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.width - 20) / 2, 250);
}


- (void)creatCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[NZCHotCollectionViewCell class] forCellWithReuseIdentifier:@"NZCHotCollectionViewCell"];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:_collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NZCHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NZCHotCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = self.dataSource[indexPath.item];
    
    return cell;
}

- (void)collectReloDate {
//    [self getStoreDate];
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NZCHotDetialViewController *hotDetail = [[NZCHotDetialViewController alloc] init];
//    hotDetail.collectDelegate = self;
    
    //代理传值让外面做
    [self.delegate passValueWithUrl:[[self.dataSource[indexPath.item] itemObject] valueForKey:@"url"] withItem:[_dataSource[indexPath.row] itemObject] withArray:[[self.dataSource[indexPath.item] itemObject] valueForKey:@"image_urls"]];
}

@end
