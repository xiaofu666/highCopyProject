//
//  NZCHotCollectionViewCell.m
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.

//  热门页面Cell

#import "NZCHotCollectionViewCell.h"

@implementation NZCHotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageViews = [[UIImageView alloc] init];
        self.imageViews.contentMode = UIViewContentModeScaleAspectFill;
        
        self.heartImage = [[UIImageView alloc] init];
        self.heartImage.contentMode = UIViewContentModeScaleAspectFit;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textColor = [UIColor redColor];
        
        self.likeCount = [[UILabel alloc] init];
        
        [self addSubview:self.imageViews];
        [self addSubview:self.heartImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.likeCount];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    self.imageViews.frame = CGRectMake(0, 0, self.width, self.height / 4 * 3 - 10);
    self.titleLabel.frame = CGRectMake(5, self.height / 4 * 3 - 5, self.width - 10, 50);
    self.priceLabel.frame = CGRectMake(5, self.height - 20, self.width / 3 , 20);
    self.likeCount.frame = CGRectMake(self.width / 4 * 3 + 5, self.height - 20, self.width / 3, 20);
    self.heartImage.frame = CGRectMake(self.likeCount.left - 20, self.height - 20, 20, 17);
}

-(void)setHotModel:(HotModel *)hotModel {
    if (_hotModel != hotModel) {
        _hotModel = hotModel;
    }
    [self.imageViews sd_setImageWithURL:[NSURL URLWithString:hotModel.cover_image_url]];
    self.imageViews.clipsToBounds = YES;
    self.titleLabel.text = hotModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%@", hotModel.price];
    self.likeCount.text = [NSString stringWithFormat:@"%@", [hotModel.favorites_count stringValue]];
    self.heartImage.image = [UIImage imageNamed:@"heart"];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    self.likeCount.font = [UIFont systemFontOfSize:12];
    
}

- (void)setItem:(SAKeyValueItem *)item {
    if (_item != item) {
        _item = item;
    }
    [self.imageViews sd_setImageWithURL:[NSURL URLWithString:item.itemObject[@"cover_image_url"]]];
    self.imageViews.clipsToBounds = YES;
    self.titleLabel.text = item.itemObject[@"name"];
    self.priceLabel.text = [NSString stringWithFormat:@"%@", item.itemObject[@"price"]];
    self.likeCount.text = [NSString stringWithFormat:@"%@", item.itemObject[@"favorites_count"]];
    self.heartImage.image = [UIImage imageNamed:@"heart"];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    self.likeCount.font = [UIFont systemFontOfSize:12];
}




@end
