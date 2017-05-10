//
//  StorageUtil.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/8/22.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "StorageUtil.h"

@implementation StorageUtil

+ (void)saveAppCartCookieId:(NSString *)appCartCookieId
{
    [self saveObject:appCartCookieId forKey:kStorageAppCartCookieId];
}
+ (NSString *)getAppCartCookieId
{
    return [self getObjectByKey:kStorageAppCartCookieId];
}

//用户是否已经登录, 由app传userId和appLoginToken过来
+ (void)saveAppLoginToken:(NSString *)appLoginToken
{
    [self saveObject:appLoginToken forKey:kStorageAppLoginToken];
}
+ (NSString *)getAppLoginToken
{
    return [self getObjectByKey:kStorageAppLoginToken];
}

//用户信息
+ (void)saveUserId:(NSString *)userId
{
    [self saveObject:userId forKey:kStorageUserId];
}
+ (NSString *)getUserId
{
    return [self getObjectByKey:kStorageUserId];
}
+ (void)saveUserMobile:(NSString *)userMobile
{
    [self saveObject:userMobile forKey:kStorageUserMobile];
}
+ (NSString *)getUserMobile
{
    return [self getObjectByKey:kStorageUserMobile];
}
+ (void)saveUserLevel:(NSString *)userLevel
{
    [self saveObject:userLevel forKey:kStorageUserLevel];
}
+ (NSString *)getUserLevel
{
    return [self getObjectByKey:kStorageUserLevel];
}

//公用的保存和获取本地数据的方法
+ (void)saveObject:(NSObject *)obj forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];//把数据持久化到standardUserDefaults数据库
}
+ (NSString *)getObjectByKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *obj = [defaults objectForKey:key];
    
    if (!obj) return nil;
    
    return obj;
}

@end
