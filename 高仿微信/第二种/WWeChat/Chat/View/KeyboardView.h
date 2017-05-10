//
//  KeyboardView.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardView : UIView

typedef NS_ENUM(NSInteger, SentMessageType) {
    /** 文本信息 */
    SentMessageTypeText ,
    /** 图片信息 */
    SentMessageTypeImg ,
    /** 语音信息 */
    SentMessageTypeWav
};


@property(nonatomic,copy)void (^showBlock)(NSInteger antype,CGFloat duration,CGSize kbSize);
@property(nonatomic,copy)void (^hideBlock)(NSInteger antype,CGFloat duration,CGSize kbSize);
@property(nonatomic,copy)void (^sentBlock)(id message,SentMessageType type);
//语音按钮
@property(nonatomic,strong)UIButton * soundBtn;

//输入框
@property(nonatomic,strong)UITextField * messageField;

//表情按钮
@property(nonatomic,strong)UIButton *  faceBtn;

//更多按钮
@property(nonatomic,strong)UIButton *  moreBtn;

- (void)setShowBlock:(void (^)(NSInteger, CGFloat, CGSize))showBlock andHideBlock:(void (^)(NSInteger, CGFloat, CGSize))hideBlock;
@end
