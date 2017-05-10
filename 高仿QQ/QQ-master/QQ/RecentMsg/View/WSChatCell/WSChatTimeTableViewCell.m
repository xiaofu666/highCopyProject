//
//  WSChatTimeTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/16.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTimeTableViewCell.h"
#import "WSChatModel.h"
#import "PureLayout.h"


#define kTextColorTime      ([UIColor colorWithRed:0.341 green:0.369 blue:0.357 alpha:1])

#define kTopOffsetTime      (20)//Time Lable和父控件顶部间距
#define kLeadingOffetTime   (20)//Time Lable和父控件右侧最小间距


@interface WSChatTimeTableViewCell ()
{
    UILabel *mTimeLable;
}
@end

@implementation WSChatTimeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        mTimeLable = [UILabel newAutoLayoutView];
        mTimeLable.backgroundColor =[UIColor clearColor];
        mTimeLable.font = [UIFont systemFontOfSize:10];
        mTimeLable.textColor = kTextColorTime;
        [self.contentView addSubview:mTimeLable];
        
        [mTimeLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kTopOffsetTime];
        [mTimeLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [mTimeLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [mTimeLable autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLeadingOffetTime relation:NSLayoutRelationGreaterThanOrEqual];
        
    }
    
    return self;
}

-(void)setModel:(WSChatModel *)model
{
    _model = model;
    
    mTimeLable.text = model.timeStamp.description;
}

@end
