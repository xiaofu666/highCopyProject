//
//  UserModel.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/07/27.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseModel.h"
#import "UserEntity.h"

@interface UserModel : BaseModel

//通过本地的存储信息判断用户是否登录
+ (BOOL)isUserLoginByStorage;


//===== 与服务器交互的方法 =====//

//获取用户信息，每次获取用户信息都要更新Storage的用户信息
+ (void)getUser:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, UserEntity *user))success
    failure:(void(^)(NSError *error))failure;

//登录
+ (void)loginWithMobile:(NSString *)mobile
               password:(NSString *)password
                success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, UserEntity *user, NSString *appCartCookieId))success
                failure:(void(^)(NSError *error))failure;

@end
