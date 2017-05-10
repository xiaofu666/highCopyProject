//
//  XyButtonCollectionViewCell.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyButtonCollectionViewCell.h"
#import "XyClassButtonModel.h"

@implementation XyButtonCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self create];
    }
    return self;
}
- (void)setModel:(ButtonArrayModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.imageViews sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    self.labels.text = model.name;
}
- (void)create {
    self.imageViews = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.labels = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labels.textAlignment = NSTextAlignmentCenter;
    self.labels.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.labels];
    [self addSubview:self.imageViews];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.imageViews.frame = CGRectMake((self.width - XHIGHT * 50) / 2, 0, XHIGHT * 50, XHIGHT * 50);
    self.labels.frame = CGRectMake(0, XHIGHT * 50, self.width, self.height - XHIGHT * 50);
}
@end
