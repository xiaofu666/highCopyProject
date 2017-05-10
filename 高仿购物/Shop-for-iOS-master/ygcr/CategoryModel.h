//
//  CategoryModel.h
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

@interface CategoryModel : BaseModel

+ (void)getCategoriesWithProducts:(void(^)(BOOL result, NSString *message, NSArray *categories))success
                          failure:(void(^)(NSError *error))failure;

@end
