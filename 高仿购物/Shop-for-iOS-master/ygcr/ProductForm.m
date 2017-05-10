//
//  ProductForm.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/29.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "ProductForm.h"

@implementation ProductForm

- (instancetype)initWithProduct:(ProductEntity *)product
{
    self = [super init];
    if (self) {
        self.productId = product.id;
        self.count = [NSNumber numberWithInteger:1];
        NSMutableArray *attrIdsTemp = [[NSMutableArray alloc] init];
        for (ProductAttributeItemEntity *item in product.attrItems) {
            if (item.itemValues.count > 0) {
                ProductAttributeItemValueEntity *value = item.itemValues[0];
                NSMutableDictionary *attrId = [[NSMutableDictionary alloc] init];
                [attrId setValue:item.id forKey:@"itemId"];
                [attrId setValue:value.id forKey:@"valueId"];
                [attrIdsTemp addObject:attrId];
            }
        }
        self.attrIds = [attrIdsTemp copy];
    }
    return self;
}

- (NSDictionary *)fieldsToDictionary
{
    NSMutableArray *attributes = [NSMutableArray new];
    for (NSDictionary *attrId in self.attrIds) {
        NSString *attrIdStr = [NSString stringWithFormat:@"%@_%@", [attrId objectForKey:@"itemId"], [attrId objectForKey:@"valueId"]];
        [attributes addObject:attrIdStr];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            self.productId,     @"productId",
                            self.count,         @"count",
                            attributes,         @"attributes", nil];
    return params;
}

- (void)submit:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data))success
                          failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlCartAdd;
    NSMutableDictionary *params = [[self fieldsToDictionary] mutableCopy];
    [params setValue:[self attrIdsToString] forKey:@"attributes"];
    
    [HttpClient requestJson:url
                     params:params
                    success:success
                    failure:failure];
}

//把属性转变为字符串如["3_15","2_10",...]
- (NSString *)attrIdsToString
{
    NSString *str = nil;
    NSMutableString *mutStr = [NSMutableString new];
    for (NSDictionary *dict in self.attrIds) {
        NSString *itemId = [dict objectForKey:@"itemId"];
        NSString *valueId = [dict objectForKey:@"valueId"];
        NSString *idStr = [NSString stringWithFormat:@",%@_%@", itemId, valueId];
        [mutStr appendString:idStr];
    }
    if (mutStr.length > 1) {
        str = [mutStr substringFromIndex:1];
    }
    return str;
}

@end
