//
//  SmartbiAdaHome+SmartbiAdaDatabaseOperationVideo.h
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaHome.h"

@interface SmartbiAdaHome (SmartbiAdaDatabaseOperationVideo)

/**
 *  保存到数据库
 */

- (void)saveToDatabaseVideoComplection:(void (^)(BOOL ret))complection;

/**
 *  从数据库中获取  数据，并把数据装到模型里
 *
 *  @return 模型对象的数组
 */

+ (void)fetchApplicationsFromDatabaseVideoComplection:(void (^)(NSArray *results))complection;
/*
 删除表内的所有数据
 */
+(void)deleteAllVideoComplection:(void (^)(BOOL results))complection;


@end
