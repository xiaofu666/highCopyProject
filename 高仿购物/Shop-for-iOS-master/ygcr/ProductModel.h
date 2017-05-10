//
//  ProductModel.h
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
#import "ProductEntity.h"

@interface ProductModel : BaseModel

//===== 与服务器交互的方法 =====//

//获取商品实体
+ (void)getProduct:(NSString *)productId
           success:(void(^)(BOOL result, NSString *message, ProductEntity *product, NSNumber *cartNum, BOOL hasCollectedProduct))success
           failure:(void(^)(NSError *error))failure;

//获取打折的商品列表
+ (void)getFeaturedProducts:(void(^)(BOOL result, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure;

//获取精选的商品列表
+ (void)getTopicProducts:(void(^)(BOOL result, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure;

//销量最高的商品列表
+ (void)getTopSaleProducts:(void(^)(BOOL result, NSString *message, NSArray *products))success
                    failure:(void(^)(NSError *error))failure;

@end
