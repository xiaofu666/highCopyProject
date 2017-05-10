//
//  SmartbiAdaPerson+SmartbiAdaDatabaseOperation.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/28.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaPerson.h"

@interface SmartbiAdaPerson (SmartbiAdaDatabaseOperation)

/**
 *  保存到数据库
 */
//- (void)saveToDatabaseWithURL:(NSString *)sourceURL complection:(void (^)(BOOL ret))complection;
- (void)saveToDatabaseComplection:(void (^)(BOOL ret))complection;

/**
 *  从数据库中获取  数据，并把数据装到模型里
 *
 *  @return 模型对象的数组
 */
//+ (void)fetchApplicationsFromDatabaseWithURL:(NSString *)sourceURL complection:(void (^)(NSArray *results))complection;
+ (void)fetchApplicationsFromDatabaseComplection:(void (^)(NSArray *results))complection;
/*
 删除表内的所有数据
 */
+(void)deleteAllComplection:(void (^)(BOOL results))complection;
@end
