//
//  PrivateCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PrivateCell.h"
#import "UserInfoManager.h"
#import "WWeChatApi.h"
@interface PrivateCell()

/** 气泡 */
@property(nonatomic,strong)UIImageView * bubbleView;

@end

@implementation PrivateCell

- (void)setModel:(MessageModel *)model
{
    CGFloat width  = model.bubbleSize.width;
    CGFloat height = model.bubbleSize.height > 50 ? model.bubbleSize.height + 10: 50;
    
    self.backgroundColor = [UIColor clearColor];
    
    //如果是你
    if (model.isMe)
    {
        [_AiConView removeFromSuperview];
        
        [_BiConView setImageWithURL:[NSURL URLWithString:[[UserInfoManager manager]avaterUrl]] placeholderImage:[[UserInfoManager manager]avater] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
        }];
        
        self.bubbleView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 10 - 5 - width,10,width,height);
        UIImage * bubbleImg = [UIImage imageNamed:@"SenderTextNodeBkg"];
        UIEdgeInsets insets = UIEdgeInsetsMake(30, 15,30,15);
        UIImage *insetImage = [bubbleImg resizableImageWithCapInsets:insets];
        self.bubbleView.image = insetImage;
    }
    else
    {
        [_BiConView removeFromSuperview];
        
        self.bubbleView.frame = CGRectMake(10 + 40 + 5,10,width,height);
        UIImage * bubbleImg = [UIImage imageNamed:@"ReceiverTextNodeBkgHL"];
        UIEdgeInsets insets = UIEdgeInsetsMake(30, 15,30,15);
        UIImage *insetImage = [bubbleImg resizableImageWithCapInsets:insets];
        self.bubbleView.image = insetImage;
    }
    [self.contentView addSubview:_bubbleView];
    
    UILabel * messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, _bubbleView.frame.size.width - 40, _bubbleView.frame.size.height - 12)];
    messageLabel.font = [UIFont systemFontOfSize:14];
    
    messageLabel.text = model.message;
    
    messageLabel.numberOfLines = 0;
    
    [_bubbleView addSubview:messageLabel];
}

- (UIImageView *)bubbleView
{
    if (!_bubbleView)
    {
        _bubbleView = ({
            UIImageView * bubbleView = [[UIImageView alloc]init];
            
            bubbleView;
        });
    }
    return _bubbleView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
