//
//  MessageModel.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

typedef NS_ENUM(NSInteger,MessageType)
{
    /** 默认，文本类型 */
    MessageTypeNone,
    /** Url类型 */
    MessageTypeUrl,
    /** 图片类型 */
    MessageTypeImg
};

/** 是否是你 */
@property(nonatomic,assign)BOOL isMe;

/** 发送者ID */
@property(nonatomic,copy)NSString * sentID;

/** 信息 */
@property(nonatomic,copy)NSString * message;

/** 信息类型 */
@property(nonatomic,assign)MessageType messageType;

/** 信息时间 */
@property(nonatomic,copy)NSString * timestamp;

/** 气泡尺寸 */
@property(nonatomic,assign)CGSize bubbleSize;

@end
