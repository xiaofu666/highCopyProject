//
//  ProductForm.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/29.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>
#import "ProductEntity.h"

@interface ProductForm : NSObject

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSNumber *count;

//存放当前选择的商品属性，格式为：
// [{itemId:"", valueId:""},...]
//  提交表单时，需要把格式转变为字符串如["3_15","2_10",...]
@property (nonatomic, copy) NSArray *attrIds;

- (instancetype)initWithProduct:(ProductEntity *)product;

//根据属性返回字典
- (NSDictionary *)fieldsToDictionary;

//提交表单到服务器
- (void)submit:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data))success
       failure:(void(^)(NSError *error))failure;
@end
