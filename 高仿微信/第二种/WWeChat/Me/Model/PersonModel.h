//
//  PersonModel.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/29.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

/**
 *  用户头像
 */
@property (nonatomic,copy)NSString * avater;

/**
 *  用户昵称
 */
@property (nonatomic,copy)NSString * nickName;

/**
 *  微信号
 */
@property (nonatomic,copy)NSString * weID;

/**
 *  ObjectID
 */
@property (nonatomic,copy)NSString * ObjectID;

@end
