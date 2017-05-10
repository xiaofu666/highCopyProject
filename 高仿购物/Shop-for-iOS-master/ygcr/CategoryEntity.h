//
//  Category.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/26.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseEntity.h"

@interface CategoryEntity : BaseEntity

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *sort;
@property (nonatomic, copy) NSArray *products; //包含ProductEntity

@end
