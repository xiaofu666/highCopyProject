//
//  WWeChatApi.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WWeChatApi.h"
#import "UserInfoManager.h"
#import "MessageModel.h"
#import <RongIMLib/RongIMLib.h>
#import "WZXTimeStampToTimeTool.h"
#define TESTWang @"trEOJcU3n2+prYATwHePu8oTdBQ1Vfi4UjOp8ARQV34kcMpfp5JlUCgWImlx9C487WrTW1eOAIp0M5YM16N8NrdA9V1lxiZa"

#define TESTJiang @"h8E0R+SNGb6d0o8MMPqeuMoTdBQ1Vfi4UjOp8ARQV34kcMpfp5JlUOF/TCo774kbJlx+88VAYA3zsk2EGAq01yWO2GNBwQiz"

#define TEST3 @"rQOgkTMy5EJG7Dz+8PZly8oTdBQ1Vfi4UjOp8ARQV34kcMpfp5JlUGsdEq2eJaXcjbUxgIoFXXEkNnWuIuudc2ts3kq6jHJE"
@implementation WWeChatApi

+ (WWeChatApi *)giveMeApi
{
    static WWeChatApi * api = nil;
    if (api == nil) {
        api = [[WWeChatApi alloc]init];
    }
    return api;
}

- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [AVUser logInWithUsernameInBackground:userName password:passWord block:^(AVUser *user, NSError *error) {
        if (error)
        {
            ShowAlert(@"用户名或密码错误");
             NSLog(@"LeanCloud登录错误:%@",error.localizedDescription);
            errorBlock(error);
            [hub hideAnimated:YES];
        }
        else
        {
            if (user != nil)
            {
                //存入objectId
                NSString * objectId = [user objectForKey:@"objectId"];
                [[NSUserDefaults standardUserDefaults]setObject:objectId forKey:wUserID];
                NSLog(@"objectId:%@",objectId);
                
                NSDictionary * userDic = @{
            @"mid":user.username,
            
            @"password":user.password,
            
            @"nickName":[user objectForKey:@"nickName"] == nil ?@"":[user objectForKey:@"nickName"],
                                           
            @"sex":[user objectForKey:@"sex"] == nil ?@"":[user objectForKey:@"sex"],
                                           
            @"wxID":[user objectForKey:@"wxID"] == nil?@"":[user objectForKey:@"wxID"],
                                           
            @"avaterUrl":[user objectForKey:@"avaterUrl"] == nil?@"":[user objectForKey:@"avaterUrl"],
                                           
            @"sign":[user objectForKey:@"sign"] == nil?@"":[user objectForKey:@"sign"]
                                           };
                
                [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:wUserInfo];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                [UserInfoManager manager].isLogin = YES;
                
                 NSLog(@"LeanCloud登录成功");
                
                NSString * token;
                if ([user.username isEqualToString:@"00000000000"]) {
                    token = TESTJiang;
                }
                else  if([user.username isEqualToString:@"11111111111"]) {
                    token = TESTWang;
                }
                else  if([user.username isEqualToString:@"22222222222"]) {
                    token = TEST3;
                }
                
                [[RCIMClient sharedRCIMClient] connectWithToken:token
                 success:^(NSString *userId)
                {
                  NSLog(@"RongYun登陆成功。当前登录的用户ID：%@", userId);
                  
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        // 方法中有隐藏HUD这一更新UI的操作
                        [hub hideAnimated:YES];
                    });
                    
                   successBlock(nil);
                }
                error:^(RCConnectErrorCode status)
                {
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        // 方法中有隐藏HUD这一更新UI的操作
                        [hub hideAnimated:YES];
                    });
                    failureBlock();
                 NSLog(@"RongYun登陆错误码为:%ld", (long)status);
                }
                tokenIncorrect:^{
                    //token过期或者不正确。
                    //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                    //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        // 方法中有隐藏HUD这一更新UI的操作
                        [hub hideAnimated:YES];
                    });
                    failureBlock();
                    NSLog(@"RongYun token错误");
                }];
            }
            else
            {
                ShowAlert(@"LeanCloud登录失败");
                [hub hideAnimated:YES];
                failureBlock();
            }
        }
    }];
}

- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock
{
    AVUser * user = [AVUser user];
    user.username = userName;
    user.password = passWord;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
}

- (void)updataAvaterWithImg:(UIImage *)img andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    
    NSData *imageData = UIImagePNGRepresentation(img);
    AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
        if (succeeded)
        {
            AVUser *currentUser = [AVUser currentUser];
            currentUser[@"avaterUrl"] = imageFile.url;
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
             {
                if (succeeded)
                {
                    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
                    NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
                    [muDic setObject:imageFile.url forKey:@"avaterUrl"];
                    [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    successBlock(imageFile.url);
                }
                else
                {
                    failureBlock(error);
                }
            }];

        }
        
    } progressBlock:^(NSInteger percentDone) {
        
    }];
    
}

- (void)updataSexWithIsMan:(BOOL)isMan andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"sex"] = [NSNumber numberWithInt:isMan];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [muDic setObject:[NSNumber numberWithInt:isMan] forKey:@"sex"];
            [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"更改性别成功");
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
    
}

- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"nickName"] = name;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [muDic setObject:name forKey:@"nickName"];
            [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"更改昵称成功");
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
}

- (void)LogoutAndSuccess:(void (^)(id))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    [[RCIMClient sharedRCIMClient]logout];
    successBlock(nil);
}

- (void)selectUserForMid:(NSString *)mid andSuccess:(void (^)(id))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:mid];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error)
        {
            NSLog(@"查询对象错误:%@",error.localizedDescription);
            errorBlock(error);
        }
        else
        {
            if (objects.count > 0)
            {
                AVUser * selectUser = objects[0];

                NSLog(@"查询对象成功%@",[selectUser objectForKey:@"nickName"]);
                
                NSDictionary * dic = @{
                                       @"name":[selectUser objectForKey:@"nickName"],
                                       @"avater":[selectUser objectForKey:@"avaterUrl"] == nil?@"":[selectUser objectForKey:@"avaterUrl"],
                                       @"objectID":selectUser.objectId
                                       };
                
                successBlock(dic);
            }
            else
            {
                NSLog(@"查询对象失败:未找到");
                failureBlock();
            }
        }
        
    }];
}


- (void)getConversationListAndSuccess:(void (^)(NSArray *))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    //获取会话列表
    NSArray *conversationList = [[RCIMClient sharedRCIMClient]
                                 getConversationList:@[@(ConversationType_PRIVATE),
                                       @(ConversationType_DISCUSSION),
                                       @(ConversationType_GROUP),
                                       @(ConversationType_SYSTEM),
                                       @(ConversationType_APPSERVICE),
                                       @(ConversationType_PUBLICSERVICE)]];
    
    NSMutableArray * conversationArr = [[NSMutableArray alloc]init];
    
    if(conversationList.count > 0)
    {
        for (RCConversation *conversation in conversationList) {
            NSLog(@"会话类型：%lu，目标会话ID：%@", (unsigned long)conversation.conversationType, conversation.targetId);
            
            [[WWeChatApi giveMeApi]selectUserForMid:conversation.targetId andSuccess:^(id response)
             {
                 ChatModel * model = [[ChatModel alloc]init];
                 
                 model.name = response[@"name"];
                 
                 model.avatar = response[@"avater"];
                 
                 model.time = [[WZXTimeStampToTimeTool tool]compareWithTimeDic:[[WZXTimeStampToTimeTool tool]timeStampToTimeToolWithTimeStamp:conversation.sentTime andScale:3]];
                 
                 model.converseID = conversation.targetId;
                 
                 model.timestamp = conversation.sentTime;
                 
                 if ([conversation.lastestMessage isMemberOfClass:[RCTextMessage class]]) {
                     RCTextMessage *testMessage = (RCTextMessage *)conversation.lastestMessage;
                     model.message = testMessage.content;
                 }
                 
                 model.noReadNum = conversation.unreadMessageCount;
                 
                 model.type = conversation.conversationType;
                 
                 [conversationArr addObject:model];
                 
                 if (conversationArr.count == conversationList.count)
                 {
                     //时间排序后的会话列表
                     NSArray * sortedArray = [conversationArr sortedArrayUsingComparator:^NSComparisonResult(ChatModel * obj1, ChatModel * obj2) {
                         if (obj1.timestamp < obj2.timestamp ) {
                             return NSOrderedDescending;
                         } else {
                             return NSOrderedAscending;
                         }
                     }];
                     NSLog(@"获取会话列表成功");
                     successBlock(sortedArray);
                 }
                 
             } andFailure:^{
                 NSLog(@"获取会话列表失败");
                 failureBlock();
                 
             } andError:^(NSError *error) {
                 NSLog(@"获取会话列表错误:%@",error.localizedDescription);
                 errorBlock(error);
             }];
            
        }

    }
    else
    {
        NSLog(@"会话列表为空");
        failureBlock();
    }
    
   
}

- (void)sentTextMessageToTargetId:(NSString *)targetId andConversationType:(RCConversationType)conversationType andMessage:(NSString *)message andSuccess:(void (^)(id))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
//    [RCIMClient sharedRCIMClient].currentUserInfo.userId
    // 构建消息的内容，这里以文本消息为例。
    RCTextMessage *testMessage = [RCTextMessage messageWithContent:message];
    // 调用RCIMClient的sendMessage方法进行发送，结果会通过回调进行反馈。
    [[RCIMClient sharedRCIMClient] sendMessage:conversationType
                                      targetId:targetId
                                       content:testMessage
                                   pushContent:@"你收到一条信息"
                                      pushData:nil
                                       success:^(long messageId) {
                                           NSLog(@"发送成功。当前消息ID：%ld", messageId);
                                           successBlock(nil);
                                       } error:^(RCErrorCode nErrorCode, long messageId) {
                                           if (nErrorCode == ERRORCODE_TIMEOUT)
                                           {
                                               NSLog(@"发送超时");
                                               failureBlock();
                                           }
                                           else
                                           {
                                               NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
                                               errorBlock(nil);
                                           }
                                       }];

}

- (void)getMessagesWithConversationID:(NSString *)conversationID andNum:(int)num andType:(RCConversationType)type AndSuccess:(void (^)(NSArray *))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    NSArray * messageArr = [[RCIMClient sharedRCIMClient]getLatestMessages:type targetId:conversationID count:num];
    
    if (messageArr.count > 0)
    {
        NSArray * sortedArray = [messageArr sortedArrayUsingComparator:^NSComparisonResult(RCMessage * obj1, RCMessage * obj2) {
            if (obj1.sentTime > obj2.sentTime ) {
                return NSOrderedDescending;
            } else {
                return NSOrderedAscending;
            }
        }];
        
        NSMutableArray * dataArr = [[NSMutableArray alloc]init];
        
        int num = 0;
        for (int i = 0; i < sortedArray.count; i++)
        {
            RCMessage * message = sortedArray[i];
            
            MessageModel * model = [[MessageModel alloc]init];
            
           
            model.sentID = message.senderUserId;
            
            if (message.messageDirection == MessageDirection_SEND)
            {
                model.isMe = YES;
            }
            
            RCTextMessage * textMessage = (RCTextMessage *)message.content;
            model.message = textMessage.content;
            
            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]init];
            NSMutableArray * messages = [[NSMutableArray alloc]init];
            
            if (i == num)
            {
                muDic = [[NSMutableDictionary alloc]init];
                
                messages = [[NSMutableArray alloc]init];
                
                [muDic setObject:@(message.sentTime) forKey:@"timestamp"];
                
                [messages addObject:model];
                
                if (i == messageArr.count - 1)
                {
                    [muDic setObject:messages forKey:@"messages"];
                    [dataArr addObject:muDic];
                    break;
                }
            }
            else
            {
                continue;
            }
            
            for (int j = num + 1; j < sortedArray.count; j++)
            {
                RCMessage * message2 = sortedArray[j];
                MessageModel * model2 = [[MessageModel alloc]init];
                
                model2.sentID = message2.senderUserId;
                if ([model2.sentID isEqualToString:[AVUser currentUser].username])
                {
                    model2.isMe = YES;
                }
                RCTextMessage * textMessage2 = (RCTextMessage *)message2.content;
                model2.message = textMessage2.content;
                
                if ([[[WZXTimeStampToTimeTool tool]compareWithTimeDic:[[WZXTimeStampToTimeTool tool]timeStampToTimeToolWithTimeStamp:message.sentTime andScale:3]] isEqualToString:[[WZXTimeStampToTimeTool tool]compareWithTimeDic:[[WZXTimeStampToTimeTool tool]timeStampToTimeToolWithTimeStamp:message2.sentTime andScale:3]]])
                {
                    [messages addObject:model2];
                    if (j == sortedArray.count - 1)
                    {
                        [muDic setObject:messages forKey:@"messages"];
                        [dataArr addObject:muDic];
                        num = (int)sortedArray.count;
                        break;
                    }
                }
                else
                {
                    [muDic setObject:messages forKey:@"messages"];
                    [dataArr addObject:muDic];
                    num = j;
                    break;
                }
            }
        }
        
        successBlock(dataArr);
    }
    else
    {
        failureBlock();
    }
    
}

- (void)askForFriendAndSuccess:(void (^)(id))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    AVUser * user = [AVUser currentUser];
    
    AVQuery *query = [AVQuery queryWithClassName:@"Friend"];
    [query whereKey:@"manName" equalTo:user.objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error)
        {
            NSLog(@"查询好友列表错误:%@",error.localizedDescription);
            errorBlock(error);
        }
        else
        {
            if (objects.count > 0)
            {
                NSMutableArray * muArr = [[NSMutableArray alloc]init];
                for (AVObject * selectObject in objects)
                {
                    NSString * mid = selectObject[@"uID"];
                   [self selectUserForMid:mid andSuccess:^(id response) {
                       [muArr addObject:response];
                       if(muArr.count == objects.count)
                       {
                           NSLog(@"查询好友列表成功");
                           successBlock(muArr);
                       }
                       
                   } andFailure:^{
        
                   } andError:^(NSError *error) {
                       
                   }];
                }
                
            }
            else
            {
                NSLog(@"查询好友列表失败:未找到");
                failureBlock();
            }
        }
        
    }];

}
@end
