//
//  WWeChatApi.h
//  WWeChat
//
//  Created by 王子轩 on 16/2/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

#import "ChatModel.h"
#import <RongIMLib/RongIMLib.h>
#import "WZXTimeStampToTimeTool.h"
@interface WWeChatApi : NSObject


/**
 *  单例
 */
+ (WWeChatApi *)giveMeApi;
#pragma mark ---------------------- 登录 ---------------------------------
/**
 *  登录
 */
- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void(^)(id response))successBlock
    andFailure:(void(^)())failureBlock
    andError:(void(^)(NSError * error))errorBlock;

/**
 *  注册
 */
- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  上传图片
 */
- (void)updataAvaterWithImg:(UIImage *)img andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  更改性别
 */
- (void)updataSexWithIsMan:(BOOL)isMan andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  更改用户名
 */
- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  退出登录
 */
- (void)LogoutAndSuccess:(void(^)(id response))successBlock
               andFailure:(void(^)())failureBlock
                 andError:(void(^)(NSError * error))errorBlock;

#pragma mark ---------------------- 用户查询 ---------------------------------

/**
 * 查询用户名
 */
- (void)selectUserForMid:(NSString *)mid
              andSuccess:(void(^)(id response))successBlock
              andFailure:(void(^)())failureBlock
              andError:(void(^)(NSError * error))errorBlock;

#pragma mark ---------------------- 获取会话 ---------------------------------
/**
 * 获取会话列表
 */
- (void)getConversationListAndSuccess:(void (^)(NSArray * conversationArr))successBlock
        andFailure:(void(^)())failureBlock
        andError:(void(^)(NSError * error))errorBlock;

/**
 * 获取某会话内容
 */
- (void)getMessagesWithConversationID:(NSString *)conversationID andNum:(int)num andType:(RCConversationType)type AndSuccess:(void (^)(NSArray * messageArr))successBlock
        andFailure:(void(^)())failureBlock
        andError:(void(^)(NSError * error))errorBlock;

#pragma mark ---------------------- 发送信息 ---------------------------------
/**
 * 发送文本信息
 */
- (void)sentTextMessageToTargetId:(NSString *)targetId andConversationType:(RCConversationType)conversationType andMessage:(NSString *)message
    andSuccess:(void (^)(id response))successBlock
    andFailure:(void(^)())failureBlock
    andError:(void(^)(NSError * error))errorBlock;

#pragma mark ---------------------- 好友 ---------------------------------
/**
 *  查询好友
 */
- (void)askForFriendAndSuccess:(void (^)(id response))successBlock
                    andFailure:(void(^)())failureBlock
                    andError:(void(^)(NSError * error))errorBlock;
@end
