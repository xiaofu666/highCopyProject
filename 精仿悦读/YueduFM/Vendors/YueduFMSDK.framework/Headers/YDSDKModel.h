//
//  YDSDKModel.h
//  YueduFMSDK
//
//  Created by StarNet on 9/16/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>

/** model基类 */
@interface YDSDKModel : NSObject

/** model的ID */
@property (nonatomic, assign) int aid;

/** 
 * model类方法
 *
 * @param data 数据源
 * @return model类
 */
+ (id)modelFromData:(NSDictionary* )data;

@end
