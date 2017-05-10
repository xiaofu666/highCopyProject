//
//  XyClassifyCollectionViewCell.m
//  presents
//
//  Created by Xy on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyClassifyCollectionViewCell.h"

@implementation XyClassifyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self create];
    }
    return self;
}

- (void)setModel:(XyClassifyModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.imageViews sd_setImageWithURL:[NSURL URLWithString:model.banner_image_url]];
}

- (void)create {
    self.imageViews = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageViews.layer.cornerRadius = 5;
    self.imageViews.layer.masksToBounds = YES;
//    self.imageViews.layer.borderWidth = 1;
    [self addSubview:self.imageViews];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.imageViews.frame = self.bounds;
}
@end
