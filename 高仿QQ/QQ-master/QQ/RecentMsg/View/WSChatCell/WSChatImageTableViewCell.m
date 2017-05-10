//
//  WSChatImageTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/17.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatImageTableViewCell.h"
#import "PureLayout.h"
#import "UIImageView+WebCache.h"


//文本
#define kH_OffsetTextWithHead        (20)//水平方向文本和头像的距离
#define kMaxOffsetText               (45)//文本最长时，为了不让文本分行显示，需要和屏幕对面保持一定距离
#define kTop_OffsetTextWithHead      (15) //文本和头像顶部对其间距
#define kBottom_OffsetTextWithSupView   (40)//文本与父视图底部间距

#define kMaxHeightImageView            (200)

@interface WSChatImageTableViewCell ()
{
    /**
     *  @brief  图片所在ImageView
     */
    UIImageView *mImageView;
}
@end


@implementation WSChatImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        if (isSender)//是我自己发送的
        {
            mBubbleImageView.image = [[UIImage imageNamed:@"chat_send_imagemask@2x"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            
        }else//别人发送的消息
        {
            mBubbleImageView.image = [[UIImage imageNamed:@"chat_recive_imagemask@2x"]stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        }
        
        mImageView = [UIImageView newAutoLayoutView];
        mImageView.backgroundColor = [UIColor clearColor];
        mImageView.userInteractionEnabled = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageBeenTaped:)];
        [mBubbleImageView addGestureRecognizer:tap];
        
        [self.contentView insertSubview:mImageView atIndex:0];

        if (isSender)//是我自己发送的
        {
            [mBubbleImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mImageView withOffset:0];
        }else//别人发送的消息
        {
            [mBubbleImageView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:mImageView withOffset:0];
        }
        
        [mBubbleImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:mImageView withOffset:0];
        
        CGFloat top     = kTopHead - kOffsetTopHeadToBubble;
        CGFloat bottom  = kBottom_OffsetTextWithSupView;
        CGFloat leading = kOffsetHHeadToBubble + kWidthHead + kLeadingHead;
        CGFloat traing  = kMaxOffsetText;
        
        [mImageView autoSetDimension:ALDimensionHeight toSize:kMaxHeightImageView relation:NSLayoutRelationLessThanOrEqual];
        
        UIEdgeInsets inset;
        if (isSender)//是自己发送的消息
        {
            inset = UIEdgeInsetsMake(top, traing, bottom, leading);
            
            [mImageView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeLeading];
            
            [mImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
            
        }else//是对方发送的消息
        {
            inset = UIEdgeInsetsMake(top, leading, bottom, traing);
            
            [mImageView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTrailing];
            
            [mImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
        }
    }
    
    return self;
}


-(void)setModel:(WSChatModel *)model
{
    if (model.sendingImage)
    {
        mImageView.image = model.sendingImage;
    }else
    {
        [mImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:[UIImage imageNamed:@"leftMenuBk"]];
    }
    [super setModel:model];
}


-(void)imageBeenTaped:(UITapGestureRecognizer*)tap
{
    [self routerEventWithType:EventChatCellImageTapedEvent userInfo:@{kModelKey:self.model}];
}

-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    if (Press.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
        
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuCopy:)];
        UIMenuItem *remove = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(menuRemove:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[copy,remove]];
        [menu setTargetRect:mBubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return  ((action == @selector(menuCopy:))  || (action == @selector(menuRemove:)));
}


#pragma mark --复制、删除处理
-(void)menuCopy:(id)sender
{
    [UIPasteboard generalPasteboard].image = mImageView.image;
}

-(void)menuRemove:(id)sender
{
    [self routerEventWithType:EventChatCellRemoveEvent userInfo:@{kModelKey:self.model}];
}

@end
