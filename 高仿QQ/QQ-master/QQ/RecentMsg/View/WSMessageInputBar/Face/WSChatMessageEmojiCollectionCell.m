//
//  WSChatMessageFaceCollectionCell.m
//  QQ
//
//  Created by weida on 15/9/25.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatMessageEmojiCollectionCell.h"
#import "PureLayout.h"

@interface WSChatMessageEmojiCollectionCell ()
{
    UIImageView *mImageView;
}
@end

@implementation WSChatMessageEmojiCollectionCell

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
        [mImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        [mImageView autoSetDimensionsToSize:CGSizeMake(28, 28)];
        

    }
    return self;
}

-(void)setModel:(NSDictionary *)model
{
    _model = model;
    
    mImageView.image = [UIImage imageNamed:model[@"image"]];
}

@end
