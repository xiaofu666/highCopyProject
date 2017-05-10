//
//  WSChatTableBaseCell.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatBaseTableViewCell.h"


@implementation WSChatBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        mHead = [UIImageView newAutoLayoutView];
        mHead.backgroundColor = [UIColor clearColor];
        mHead.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headBeenTaped:)];
        [mHead addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *headlongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(headBeenLongPress:)];
        [mHead addGestureRecognizer:headlongPress];
        
        mHead.image = [UIImage imageNamed:@"user_avatar_default"];
        [self.contentView addSubview:mHead];
      
        [mHead autoSetDimensionsToSize:CGSizeMake(kWidthHead, kHeightHead)];
        
        [mHead autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kTopHead];
        NSArray *IDs = [reuseIdentifier componentsSeparatedByString:kReuseIDSeparate];
        
        NSAssert(IDs.count>=2, @"reuseIdentifier should be separate by -");
        
        isSender = [IDs[0] boolValue];
        
        if (isSender)//是我自己发送的
        {
            [mHead autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kTraingHead];
        }else//别人发送的消息
        {
            [mHead autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLeadingHead];
        }
        
        mBubbleImageView = [UIImageView newAutoLayoutView];
        mBubbleImageView.backgroundColor = [UIColor clearColor];
        mBubbleImageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *bubblelongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [mBubbleImageView addGestureRecognizer:bubblelongPress];
        [self.contentView addSubview:mBubbleImageView];
        
        [mBubbleImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mHead withOffset:-kOffsetTopHeadToBubble];
        
    
        if (isSender)//是我自己发送的
        {
            mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_send_nor] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            
            mBubbleImageView.highlightedImage = [[UIImage imageNamed:kImageNameChat_send_press] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            
            [mBubbleImageView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:mHead withOffset:-kOffsetHHeadToBubble];
        }else//别人发送的消息
        {
             mBubbleImageView.image = [[UIImage imageNamed:kImageNameChat_Recieve_nor]stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            mBubbleImageView.highlightedImage = [[UIImage imageNamed:kImageNameChat_Recieve_press] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            
            [mBubbleImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:mHead withOffset:kOffsetHHeadToBubble];
        }
    }
    
    return self;
}

-(void)headBeenTaped:(UITapGestureRecognizer *)tap
{
    [self routerEventWithType:EventChatCellHeadTapedEvent userInfo:@{kModelKey:self.model}];
}

-(void)headBeenLongPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        [self routerEventWithType:EventChatCellHeadLongPressEvent userInfo:@{kModelKey:self.model}];
    }
   
}

-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
