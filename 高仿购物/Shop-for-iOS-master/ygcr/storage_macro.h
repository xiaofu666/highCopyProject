//
//  storage_macro.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/8/16.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

//在本地保存用户数据的键

//添加产品到购物车时，服务器会生成唯一的appCartCookieId，必须保存它，每次请求都要提交它
#define kStorageAppCartCookieId     @"appCartCookieId"

//用户是否已经登录, 由app传userId和appLoginToken过来
#define kStorageAppLoginToken       @"appLoginToken"

//用户信息
#define kStorageUserId              @"userId"
#define kStorageUserMobile          @"userMobile"
#define kStorageUserLevel           @"userLevel"