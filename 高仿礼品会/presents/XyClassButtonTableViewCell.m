//
//  XyClassButtonTableViewCell.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyClassButtonTableViewCell.h"

@implementation XyClassButtonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dataSource = [NSArray array];
        self.labels = [[UILabel alloc] initWithFrame:CGRectZero];

        [self addSubview:self.collectionView];
        [self addSubview:self.labels];
    }
    return self;
}


- (void)setModel:(XyClassButtonModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.labels.text = model.name;

}


#pragma mark - collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[XyButtonCollectionViewCell class] forCellWithReuseIdentifier:@"XyButtonCollectionViewCellIdentifier"];
    }
    return _collectionView;
}

#pragma mark - collectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XyButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XyButtonCollectionViewCellIdentifier" forIndexPath:indexPath];
    if (indexPath.row < self.model.chan.count) {
        ButtonArrayModel *model = self.model.chan[indexPath.item];
        [cell setModel:model];
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.chan.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ButtonArrayModel *model = self.model.chan[indexPath.item];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"id" object:model.nId];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.labels.font = [UIFont systemFontOfSize:13];
    self.labels.frame = CGRectMake(5, 0, self.width - 5, XHIGHT * 20);
    self.flowLayout.itemSize = CGSizeMake(self.width / 5, XHIGHT * 80);
    self.flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
    self.collectionView.frame = CGRectMake(0, XHIGHT * 20, self.width, self.height - XHIGHT * 20);
//    self.collectionView.backgroundColor = [UIColor blackColor];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
