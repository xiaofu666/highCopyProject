//
//  SAPNetWorkTool.h
//  CarsHome
//
//  Created by dapeng on 15/12/1.
//  Copyright © 2015年 dapeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void (^SuccessBlock)(id result);
typedef void(^FailBlock)(NSError *error);
typedef NS_ENUM(NSUInteger, responseType) {
    ResponseTypeJSON,
    ResponseTypeXML,
    ResponseTypeDATA,
};
//Body类型
typedef NS_ENUM(NSUInteger, BodyType) {
    BodyTypeString,
    BodyTypeDictionary
};
@interface SAPNetWorkTool : NSObject
/**
 *  get请求
 *
 *  @param url          url
 *  @param parameter    参数
 *  @param header       请求头
 *  @param responseType 返回值类型
 *  @param success      成功
 *  @param fail         失败
 */
+ (void)getWithUrl:(NSString *)url parameter:(NSDictionary *)parameter httpHeader:(NSDictionary *)header responseType:(responseType)responseType success:(SuccessBlock)success fail:(FailBlock)fail;
//post
/**
 *  post请求
 *
 *  @param url          url
 *  @param body         body
 *  @param bodyType     body类型
 *  @param header       请求头
 *  @param responseType 返回值类型
 *  @param success      成功
 *  @param fail         失败
 */
+ (void)postWithUrl:(NSString *)url body:(id)body bodyType:(BodyType)bodyType httpHeader:(NSDictionary *)header responseType:(responseType)responseType success:(SuccessBlock)success fail:(FailBlock)fail;

@end
