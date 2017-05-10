//
//  ChatDetailViewController.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/3.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "BaseViewController.h"
#import <RongIMLib/RongIMLib.h>
@interface ChatDetailViewController : BaseViewController

/**
 *  会话名
 */
@property(nonatomic,copy)NSString * name;

/**
 *  会话ID
 */
@property(nonatomic,copy)NSString * converseID;

/**
 *  会话类型
 */
@property(nonatomic,assign)RCConversationType conversationType;

/**
 *  对面头像
 */
@property(nonatomic,strong)UIImage * heAvaterImg;
@end
