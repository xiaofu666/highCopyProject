//
//  AccountTool.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYAccount;

typedef void (^AccessTokenSuccess)();

@interface AccountTool : NSObject

+(void)saveAccount:(LYAccount *)account;
+ (LYAccount *)currenAccount;
/**
 *  获取access_Token
 */
+(void)getAccessTokenWithcode:(NSString *)code success:(AccessTokenSuccess)success filure:(HttpFailure)failure;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com