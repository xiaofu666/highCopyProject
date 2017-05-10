//
//  CartModel.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/07/27.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "CartModel.h"

@implementation CartModel

+ (void)getCart:(void(^)(BOOL result, NSString *message, NSArray *cartItems, NSArray *couponUsers, NSNumber *cartNum, NSNumber *totalPrice, BOOL isLoggedIn))success
        failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetCart;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSMutableArray *cartItems = [NSMutableArray new];
                        NSMutableArray *couponUsers = [NSMutableArray new];
                        NSNumber *cartNum = nil;
                        NSNumber *totalPrice = nil;
                        BOOL isLoggedIn = NO;
                        if (result) {
                            NSArray *cartItemList = [data objectForKey:@"cartItemList"];
                            //NSArray *countUsefulCoupon = [data objectForKey:@"countUsefulCoupon"];
                            cartNum = [data objectForKey:@"cartNum"];
                            totalPrice = [data objectForKey:@"totalPrice"];
                            isLoggedIn = [[data objectForKey:@"isLoggedIn"] boolValue];
                            
                            //购物车项转换为实体
                            NSMutableArray *cartItemAttrs = [NSMutableArray new];
                            for (NSDictionary *cartItemDict in cartItemList) {
                                NSArray *cartItemAttrList = [cartItemDict objectForKey:@"attrList"];
                                CartItemEntity *cartItem = [[CartItemEntity alloc] initWithDictionary:cartItemDict];
                                //ProductEntity *product = [[ProductEntity alloc] initWithDictionary:[cartItemDict objectForKey:@"product"]];
                                //cartItem.product = product;
                                
                                //购物车项的属性
                                for (NSDictionary *cartItemAttrDict in cartItemAttrList) {
                                    NSDictionary *productAttrItemDict = [cartItemAttrDict objectForKey:@"attrItem"];
                                    NSDictionary *productAttrItemValueDict = [cartItemAttrDict objectForKey:@"attrValue"];
                                    CartItemAttributeEntity *cartItemAttr = [[CartItemAttributeEntity alloc] initWithDictionary:cartItemAttrDict];
                                    ProductAttributeItemEntity *productAttrItem = [[ProductAttributeItemEntity alloc] initWithDictionary:productAttrItemDict];
                                    ProductAttributeItemValueEntity *productAttrItemValue = [[ProductAttributeItemValueEntity alloc] initWithDictionary:productAttrItemValueDict];
                                    cartItemAttr.productAttributeItem = productAttrItem;
                                    cartItemAttr.productAttributeItemValue = productAttrItemValue;
                                    [cartItemAttrs addObject:cartItemAttr];
                                    cartItem.attributes = [cartItemAttrs copy];
                                }
                                
                                [cartItems addObject:cartItem];
                            }
                            
                            //优惠券转换为实体
                            /*
                            for (NSDictionary *couponUserDict in countUsefulCoupon) {
                                CouponUserEntity *couponUser = [[CouponUserEntity alloc] initWithDictionary:couponUserDict];
                                [couponUsers addObject:couponUser];
                            }
                             */
                        }
                        success(result, message, [cartItems copy], [couponUsers copy], cartNum, totalPrice, isLoggedIn);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

//设置购物车项的数量
+ (void)setCartItemCountWithItemId:(NSString *)itemId
                             count:(NSNumber *)count
                           success:(void(^)(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice))success
                           failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlSetCartItemCountWithItemId, itemId];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                count,      @"count", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSNumber *cartNum = nil;
                        NSNumber *totalPrice = nil;
                        if (result) {
                            cartNum = [data objectForKey:@"cartNum"];
                            totalPrice = [data objectForKey:@"totalPrice"];
                        }
                        success(result, message, cartNum, totalPrice);
                    }
                    failure:failure];
}

//删除购物车项
+ (void)deleteCartItemWithItemId:(NSString *)itemId
                         success:(void(^)(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice))success
                         failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlDeleteCartItemWithItemId, itemId];
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSNumber *cartNum = nil;
                        NSNumber *totalPrice = nil;
                        if (result) {
                            cartNum = [data objectForKey:@"cartNum"];
                            totalPrice = [data objectForKey:@"totalPrice"];
                        }
                        success(result, message, cartNum, totalPrice);
                    }
                    failure:failure];
}

//选取购物车项
+ (void)selectCartItemWithItemId:(NSString *)itemId
                      isSelected:(NSNumber *)isSelected
                         success:(void(^)(BOOL result, NSString *message, NSNumber *cartNum, NSNumber *totalPrice))success
                         failure:(void(^)(NSError *error))failure;
{
    NSString *url = [NSString stringWithFormat:kUrlSelectCartItemWithItemId, itemId];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            isSelected,      @"is-selected", nil];
    [HttpClient requestJson:url
                     params:params
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSNumber *cartNum = nil;
                        NSNumber *totalPrice = nil;
                        if (result) {
                            cartNum = [data objectForKey:@"cartNum"];
                            totalPrice = [data objectForKey:@"totalPrice"];
                        }
                        success(result, message, cartNum, totalPrice);
                    }
                    failure:failure];
}

@end
