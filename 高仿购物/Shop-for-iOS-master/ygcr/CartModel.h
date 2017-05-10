//
//  CartModel.h
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
#import "CartItemEntity.h"
#import "CouponUserEntity.h"
#import "ProductEntity.h"
#import "ProductAttributeItemEntity.h"
#import "ProductAttributeItemValueEntity.h"
#import "CartItemAttributeEntity.h"

@interface CartModel : BaseModel

//===== 与服务器交互的方法 =====//

//获得购物车的项, 包括对应的产品属性
+ (void)getCart:(void(^)(BOOL result, NSString *message, NSArray *cartItems, NSArray *couponUsers, NSNumber *cartNum, NSNumber *totalPrice, BOOL isLoggedIn))success
           failure:(void(^)(NSError *error))failure;

//设置购物车项的数量
+ (void)setCartItemCountWithItemId:(NSString *)itemId
                             count:(NSNumber *)count
                           success:(void(^)(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice))success
                           failure:(void(^)(NSError *error))failure;

//删除购物车项
+ (void)deleteCartItemWithItemId:(NSString *)itemId
                           success:(void(^)(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice))success
                           failure:(void(^)(NSError *error))failure;

//选取购物车项
+ (void)selectCartItemWithItemId:(NSString *)itemId
                      isSelected:(NSNumber *)isSelected
                         success:(void(^)(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice))success
                         failure:(void(^)(NSError *error))failure;

@end
