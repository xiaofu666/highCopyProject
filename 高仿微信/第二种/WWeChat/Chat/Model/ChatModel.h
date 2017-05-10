//
//  ChatModel.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/29.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMLib/RongIMLib.h>
@interface ChatModel : NSObject

/**
 *  头像
 */
@property (nonatomic,copy)NSString * avatar;

/**
 *  名字
 */
@property (nonatomic,copy)NSString * name;

/**
 *  信息
 */
@property (nonatomic,copy)NSString * message;

/**
 *  时间
 */
@property (nonatomic,copy)NSString * time;

/**
 *  时间戳
 */
@property (nonatomic,assign)NSInteger timestamp;

/**
 *  未读消息数
 */
@property (nonatomic,assign)int noReadNum;

/**
 *  会话类型
 */
@property (nonatomic,assign)RCConversationType type;

/**
 *  会话id
 */
@property (nonatomic,copy)NSString * converseID;
@end
