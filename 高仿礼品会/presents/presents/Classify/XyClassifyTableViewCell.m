//
//  XyClassifyTableViewCell.m
//  presents
//
//  Created by Xy on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyClassifyTableViewCell.h"



@implementation XyClassifyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.data = [NSMutableArray arrayWithCapacity:0];
        [self addSubview:self.collectionView];
    }
    return self;
}
- (void)setData:(NSArray *)data {
    if (_data != data) {
        _data = data;
    }
}


#pragma mark - collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;//隐藏滚动条
        [self.collectionView registerClass:[XyClassifyCollectionViewCell class] forCellWithReuseIdentifier:@"XyClassifyCollectionViewCellIdentifier"];
    }
    return _collectionView;
}

#pragma mark - collectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XyClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XyClassifyCollectionViewCellIdentifier" forIndexPath:indexPath];

    if (indexPath.row < self.data.count) {
        XyClassifyModel *model = self.data[indexPath.item];
        [cell setModel:model];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XyClassifyModel *model = self.data[indexPath.item];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"id" object:model.nId];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.flowLayout.itemSize = CGSizeMake((self.width / 4) + 5, XHIGHT * 50);
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
