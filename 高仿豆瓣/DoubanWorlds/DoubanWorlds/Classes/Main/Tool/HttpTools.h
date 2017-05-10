//
//  HttpTools.h
//  Finance
//
//  Created by LYoung on 15/8/4.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//  基础网络请求

#import <Foundation/Foundation.h>


typedef void (^HttpSuccess)(id json);
typedef void (^HttpFailure)(NSError *error);

typedef void (^ArrayBlock)(NSMutableArray *resultArray);


@interface HttpTools : NSObject


/**
 *  POST请求
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure;
/**
 *  GET请求
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com