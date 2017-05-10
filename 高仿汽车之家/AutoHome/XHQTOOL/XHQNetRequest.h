//
//  XHQNetRequest.h
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^CompleteCallBack)(id data);//请求完成时的回调
typedef void (^FailureCallBack)(NSError* error);//请求出错的回调

@interface XHQNetRequest : NSObject

//功能：get方式请求数据
//参数：urlString 网址
//     complete 请求完成时的回调
//     failure  请求出错的回调
//返回值：无
+(void) get:(NSString*)urlString complete:(CompleteCallBack)complete fail:(FailureCallBack)failure;

//功能：post方式请求数据
//参数：urlString 网址
//     paras 一个字典，请求参数
//     complete 请求完成时的回调
//     failure  请求出错的回调
//返回值：无
+(void) post:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure;



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com