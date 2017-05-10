//
//  SixPictureCollectionViewCell.m
//  presents
//
//  Created by dapeng on 16/1/10.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SixPictureCollectionViewCell.h"

@implementation SixPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.images = [[UIImageView alloc] init];
        [self addSubview:self.images];
        self.backgroundColor = [UIColor whiteColor];
    }return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes: layoutAttributes];
    self.images.frame = CGRectMake(10, 10, self.height - 20, self.height - 20);
    
}
- (void)setPresentModel:(PresentMdoel *)presentModel {
    if (_presentModel != presentModel) {
        _presentModel = presentModel;
    }
    [self.images sd_setImageWithURL:[NSURL URLWithString:_presentModel.image_url]];
}

@end
