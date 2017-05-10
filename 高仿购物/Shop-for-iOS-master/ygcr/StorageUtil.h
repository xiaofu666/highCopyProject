//
//  StorageUtil.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/8/22.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>

@interface StorageUtil : NSObject

//添加产品到购物车时，服务器会生成唯一的appCartCookieId，必须保存它，每次请求都要提交它
+ (void)saveAppCartCookieId:(NSString *)appCartCookieId;
+ (NSString *)getAppCartCookieId;

//用户是否已经登录, 由app传userId和appLoginToken过来
+ (void)saveAppLoginToken:(NSString *)appLoginToken;
+ (NSString *)getAppLoginToken;

//用户信息
+ (void)saveUserId:(NSString *)userId;
+ (NSString *)getUserId;

+ (void)saveUserMobile:(NSString *)userMobile;
+ (NSString *)getUserMobile;

+ (void)saveUserLevel:(NSString *)userLevel;
+ (NSString *)getUserLevel;

@end
