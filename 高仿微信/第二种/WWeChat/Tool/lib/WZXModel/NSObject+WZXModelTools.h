//
//  NSObject+WZXModelTools.h
//  WZXModel
//
//  Created by wordoor－z on 16/3/11.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WZXModelTools)

/**
 * @method
 * @abstract Model快速添加描述
 * @discussion 在Model的Description方法中返回该方法返回值
 * @result Description
 */
- (NSString *)ModelDescription;

/**
 * @method
 * @abstract 快速JsonToModel转换
 * @discussion 直接调用
 */
- (void)JsonToModel:(NSDictionary *)dic;

/**
 * @method
 * @abstract 快速ModelToJson转换
 * @discussion 直接调用
 */
- (NSDictionary *)ModelToDic;

@end
