//
//  WSChatTextTableViewCell.m
//  QQ
//
//  Created by weida on 15/8/16.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatTextTableViewCell.h"
#import "PureLayout.h"

//文本
#define kH_OffsetTextWithHead        (20)//水平方向文本和头像的距离
#define kMaxOffsetText               (45)//文本最长时，为了不让文本分行显示，需要和屏幕对面保持一定距离
#define kTop_OffsetTextWithHead      (15) //文本和头像顶部对其间距
#define kBottom_OffsetTextWithSupView   (40)//文本与父视图底部间距

@interface WSChatTextTableViewCell ()
{
    /**
     *  @brief  文本Lable
     */
    UILabel *mTextLable;
}
@end

@implementation WSChatTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        mTextLable = [UILabel newAutoLayoutView];
        mTextLable.numberOfLines = 0;
        mTextLable.backgroundColor = [UIColor clearColor];
        mTextLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:mTextLable];
        
        if (isSender)//是我自己发送的
        {
           [mBubbleImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:mTextLable withOffset:-20];
        }else//别人发送的消息
        {
            [mBubbleImageView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:mTextLable withOffset:20];
        }
        
        [mBubbleImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:mTextLable withOffset:20];
        
        CGFloat top     = kTop_OffsetTextWithHead + kTopHead;
        CGFloat bottom  = kBottom_OffsetTextWithSupView;
        
        CGFloat leading = kH_OffsetTextWithHead + kWidthHead + kLeadingHead;
        CGFloat traing  = kMaxOffsetText;
        
        UIEdgeInsets inset;
        if (isSender)//是自己发送的消息
        {
            inset = UIEdgeInsetsMake(top, traing, bottom, leading);
            
            [mTextLable autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeLeading];
            
            [mTextLable autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
            
        }else//是对方发送的消息
        {
            inset = UIEdgeInsetsMake(top, leading, bottom, traing);
            
            [mTextLable autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTrailing];
            
            [mTextLable autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:traing relation:NSLayoutRelationGreaterThanOrEqual];
        }

    }
    return self;
}



-(void)setModel:(WSChatModel *)model
{
    mTextLable.text = model.content;
    
    [super setModel:model];
    
}




-(void)longPress:(UILongPressGestureRecognizer *)Press
{
    if (Press.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
        
        mBubbleImageView.highlighted = YES;
        
    
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuCopy:)];
        UIMenuItem *retweet = [[UIMenuItem alloc]initWithTitle:@"转发" action:@selector(menuRetweet:)];
        UIMenuItem *retweetMultiple = [[UIMenuItem alloc]initWithTitle:@"转发多条" action:@selector(menuRetweetMultiple:)];
        UIMenuItem *remove = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(menuRemove:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[copy,retweet,retweetMultiple,remove]];
        [menu setTargetRect:mBubbleImageView.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIMenuControllerWillHideMenu) name:UIMenuControllerWillHideMenuNotification object:nil];
        
    }
}

/**
 *  @brief  菜单隐藏时调用此方法
 */
-(void)UIMenuControllerWillHideMenu
{
    mBubbleImageView.highlighted = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return  ((action == @selector(menuCopy:))   || (action == @selector(menuRemove:))  ||
            (action == @selector(menuRetweet:)) || (action == @selector(menuRetweetMultiple:)));
}


#pragma mark --复制、删除、转发、转发多条
-(void)menuCopy:(id)sender
{
    [UIPasteboard generalPasteboard].string = mTextLable.text;
    
}


-(void)menuRetweet:(id)sender
{
    
}

-(void)menuRetweetMultiple:(id)sender
{
   
}

-(void)menuRemove:(id)sender
{
    [self routerEventWithType:EventChatCellRemoveEvent userInfo:@{kModelKey:self.model}];
}


@end
