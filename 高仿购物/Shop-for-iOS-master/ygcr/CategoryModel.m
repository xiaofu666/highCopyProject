//
//  CategoryModel.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/07/27.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "CategoryModel.h"
#import "CategoryEntity.h"
#import "ProductEntity.h"

@implementation CategoryModel

+ (void)getCategoriesWithProducts:(void(^)(BOOL result, NSString *message, NSArray *categories))success
                          failure:(void(^)(NSError *error))failure
{
    NSString *url = kUrlCategoryListWithProduct;
    [HttpClient requestJson:url
               params:nil
              success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data){
                  NSMutableArray *categories = [[NSMutableArray alloc] init];
                  if (result) {
                      NSArray *cateList = [data objectForKey:@"categoryList"];
                      for (NSDictionary *dict in cateList) {
                          CategoryEntity *category = [[CategoryEntity alloc] initWithDictionary:dict];
                          NSMutableArray *productsTemp = [[NSMutableArray alloc] init];
                          
                          NSArray *productList = [dict objectForKey:@"productList"];
                          for (NSDictionary *prodDict in productList) {
                              ProductEntity *product = [[[ProductEntity alloc] initWithDictionary:prodDict] dealFields];
                              
                              [productsTemp addObject:product];
                              category.products = [productsTemp copy];
                          }
                          [categories addObject:category];
                      }
                  }
                  success(result, message, categories);
              }
              failure:failure];
}

@end
