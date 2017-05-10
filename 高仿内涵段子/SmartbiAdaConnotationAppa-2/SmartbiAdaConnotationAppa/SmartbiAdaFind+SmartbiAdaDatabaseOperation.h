//
//  SmartbiAdaFind+SmartbiAdaDatabaseOperation.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaFind.h"

@interface SmartbiAdaFind (SmartbiAdaDatabaseOperation)

/**
 *  保存到数据库
 */
- (void)saveToDatabaseComplection:(void (^)(BOOL ret))complection;

/**
 *  从数据库中获取  数据，并把数据装到模型里
 *
 *  @return 模型对象的数组
 */
+ (void)fetchApplicationsFromDatabaseComplection:(void (^)(NSArray *results))complection;
/*
 删除表内的所有数据
 */
+(void)deleteAllComplection:(void (^)(BOOL results))complection;
@end
