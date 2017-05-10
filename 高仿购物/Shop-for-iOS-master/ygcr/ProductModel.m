//
//  ProductModel.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/07/27.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ProductModel.h"
#import "ProductAttributeItemEntity.h"
#import "ProductAttributeItemValueEntity.h"

@implementation ProductModel

//===== 与服务器交互的方法 =====//

//获取商品实体
+ (void)getProduct:(NSString *)productId
           success:(void(^)(BOOL result, NSString *message, ProductEntity *product, NSNumber *cartNum, BOOL hasCollectedProduct))success
           failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:kUrlProduct, productId];
    [HttpClient requestJson:url
               params:nil
              success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data){
                  ProductEntity *product = nil;
                  NSNumber *cartNum = [NSNumber numberWithInt:0];
                  BOOL hasCollectedProduct = NO;
                  if (result) {
                      cartNum = [data objectForKey:@"cartNum"];
                      hasCollectedProduct = [[data objectForKey:@"hasCollectedProduct"] boolValue];
                      NSDictionary *productDict = [data objectForKey:@"product"];
                      product = [[ProductEntity alloc] initWithDictionary:productDict];
                      
                      NSArray *attrItemDicts = [productDict objectForKey:@"attrList"];
                      if (attrItemDicts && attrItemDicts.count > 0) {
                          NSMutableArray *attrItems = [[NSMutableArray alloc] init];
                          for (NSDictionary *attrItemDict in attrItemDicts) {
                              ProductAttributeItemEntity *attrItem = [[ProductAttributeItemEntity alloc] initWithDictionary:attrItemDict];
                              
                              NSArray *itemValueDicts = [attrItemDict objectForKey:@"valueList"];
                              if (itemValueDicts && itemValueDicts.count > 0) {
                                  NSMutableArray *itemValues = [[NSMutableArray alloc] init];
                                  for (NSDictionary *itemValueDict in itemValueDicts) {
                                      ProductAttributeItemValueEntity *itemValue = [[ProductAttributeItemValueEntity alloc] initWithDictionary:itemValueDict];
                                      [itemValues addObject:itemValue];
                                      
                                  }
                                  attrItem.itemValues = [itemValues copy];
                              }
                              [attrItems addObject:attrItem];
                          }
                          product.attrItems = [attrItems copy];
                      }
                  }
                  success(result, message, product, cartNum, hasCollectedProduct);
              }
              failure:failure];
}

//获取打折的商品列表
+ (void)getFeaturedProducts:(void(^)(BOOL result, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetFeaturedProducts;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSArray *products = nil;
                        NSMutableArray *productsArr = [NSMutableArray new];
                        if (result) {
                            NSArray *dictArr = [data objectForKey:@"productList"];
                            for (NSDictionary *dict in dictArr) {
                                ProductEntity *product = [[ProductEntity alloc] initWithDictionary:dict];
                                [productsArr addObject:product];
                            }
                            products = [productsArr mutableCopy];
                        }
                        success(result, message, products);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

//获取精选的商品列表
+ (void)getTopicProducts:(void(^)(BOOL result, NSString *message, NSArray *products))success
                 failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetTopicProducts;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSArray *products = nil;
                        NSMutableArray *productsArr = [NSMutableArray new];
                        if (result) {
                            NSArray *dictArr = [data objectForKey:@"productList"];
                            for (NSDictionary *dict in dictArr) {
                                ProductEntity *product = [[ProductEntity alloc] initWithDictionary:dict];
                                [productsArr addObject:product];
                            }
                            products = [productsArr mutableCopy];
                        }
                        success(result, message, products);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

//销量最高的商品列表
+ (void)getTopSaleProducts:(void(^)(BOOL result, NSString *message, NSArray *products))success
                   failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlGetTopSaleProducts;
    [HttpClient requestJson:url
                     params:nil
                    success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
                        NSArray *products = nil;
                        NSMutableArray *productsArr = [NSMutableArray new];
                        if (result) {
                            NSArray *dictArr = [data objectForKey:@"productList"];
                            for (NSDictionary *dict in dictArr) {
                                ProductEntity *product = [[ProductEntity alloc] initWithDictionary:dict];
                                [productsArr addObject:product];
                            }
                            products = [productsArr mutableCopy];
                        }
                        success(result, message, products);
                    } failure:^(NSError *error) {
                        failure(error);
                    }];
}

@end
