//
//  WSChatMessageMoreCollectionCell.m
//  QQ
//
//  Created by weida on 15/9/24.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatMessageMoreCollectionCell.h"
#import "PureLayout.h"

@interface WSChatMessageMoreCollectionCell ()
{
    UIImageView *mImageView;
    
    UILabel     *mTitle;
}
@end

@implementation WSChatMessageMoreCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        mImageView = [[UIImageView alloc]initForAutoLayout];
        mImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:mImageView];
        
        [mImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [mImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:-8];
        [mImageView autoSetDimensionsToSize:CGSizeMake(40, 40)];
        
        mTitle = [[UILabel alloc]initForAutoLayout];
        mTitle.backgroundColor = [UIColor clearColor];
        mTitle.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:mTitle];
        
        [mTitle autoAlignAxis:ALAxisVertical toSameAxisOfView:mImageView];
        [mTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:mImageView withOffset:4];
        
    }
    return self;
}

-(void)setModel:(NSDictionary *)model
{
    _model = model;
    
    mTitle.text = model[@"title"];
    
    mImageView.image = [UIImage imageNamed:model[@"image"]];
    
}


@end
