//
//  XyLinkageCollectionViewCell.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 Xy. All rights reserved.
//

#import "XyLinkageCollectionViewCell.h"

@implementation XyLinkageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] init];
        self.imageViews = [[UIImageView alloc] init];
//        self.imageViews.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.label];
        [self addSubview:self.imageViews];
        
        
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.imageViews.frame = CGRectMake(XWIDTH * 12, 0, self.height -  XHIGHT *20 , self.height - XHIGHT *20);
    self.label.frame = CGRectMake(0, self.imageViews.bottom, self.width, 20);
  
}

- (void)setGiftModel:(XyGiftCollectionModel *)giftModel
{
    if (_giftModel != giftModel) {
        _giftModel = giftModel;
    }
    [self.imageViews sd_setImageWithURL:[NSURL URLWithString:giftModel.icon_url]];
    self.label.text = giftModel.name;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:13];
    
}


@end
