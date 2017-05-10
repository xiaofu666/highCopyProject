//
//  WSBuddyListTableViewCell.m
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSBuddyListTableViewCell.h"
#import "WSBuddyModel.h"
#import "PureLayout.h"

#define kWidhtHeadImageView   (35)

#define kTextColorSubTitle    ([UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1])

#define kBkColorLine          ([UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:1])

#define kTextColorTime        ([UIColor colorWithRed:0.741 green:0.741 blue:0.741 alpha:1])

@interface WSBuddyListTableViewCell ()
{
    
    /**
     *  @brief  头部图片
     */
    UIImageView *_headImageView;
    
    /**
     *  @brief  好友名称
     */
    UILabel *_nickName;
    
    /**
     *  @brief  聊天详情
     */
    UILabel     *mSubTitle;
    
    /**
     *  @brief  时间
     */
    UILabel     *mTime;
}
@end

@implementation WSBuddyListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        _headImageView = [UIImageView newAutoLayoutView];
        _headImageView.image = [UIImage imageNamed:@"user_avatar_default"];
        [self.contentView addSubview:_headImageView];
        
        [_headImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_headImageView  autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [_headImageView autoSetDimensionsToSize:CGSizeMake(kWidhtHeadImageView, kWidhtHeadImageView)];
        
        
        _nickName = [UILabel newAutoLayoutView];
        _nickName.font = [UIFont systemFontOfSize:13];
        _nickName.text = @"张金磊";
        [self.contentView addSubview:_nickName];
        
        
        [_nickName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_headImageView withOffset:0];
        [_nickName autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_headImageView withOffset:10];
        
        
        mSubTitle = [UILabel newAutoLayoutView];
        mSubTitle.font = [UIFont systemFontOfSize:10];
        mSubTitle.text = @"国庆不回家？";
        mSubTitle.textColor = kTextColorSubTitle;
        [self.contentView addSubview:mSubTitle];
        
        [mSubTitle autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:_nickName];
        [mSubTitle  autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_headImageView withOffset:0];
        
        UIView *line = [UIView newAutoLayoutView];
        line.backgroundColor= kBkColorLine;
        [self.contentView addSubview:line];
        [line autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mSubTitle];
        [line autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.contentView];
        [line autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:0];
        [line autoSetDimension:ALDimensionHeight toSize:1];
        
        
        
        mTime = [UILabel newAutoLayoutView];
        mTime.textAlignment = NSTextAlignmentRight;
       // mTime.text = @"下午9:20";
        mTime.textColor = kTextColorTime;
        mTime.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:mTime];
        
        [mTime setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh+1 forAxis:UILayoutConstraintAxisHorizontal];
        
        [mTime autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nickName];
        [mTime autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        [mTime autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_nickName withOffset:4 relation:NSLayoutRelationGreaterThanOrEqual];
        [mTime autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mSubTitle withOffset:4 relation:NSLayoutRelationGreaterThanOrEqual];
        
    }
    return self;
}

-(void)setModel:(WSBuddyModel *)model
{
    _model = model;
    _nickName.text = model.nickName;
    
    mSubTitle.text = model.lastSignature;
}

@end
