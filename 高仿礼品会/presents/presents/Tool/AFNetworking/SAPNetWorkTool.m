//
//  SAPNetWorkTool.m
//  CarsHome
//
//  Created by dapeng on 15/12/1.
//  Copyright © 2015年 dapeng. All rights reserved.
//

#import "SAPNetWorkTool.h"
#import "SAReachabilityManager.h"
#import "KVNProgress.h"
@implementation SAPNetWorkTool

+ (void)getWithUrl:(NSString *)url parameter:(NSDictionary *)parameter httpHeader:(NSDictionary *)header responseType:(responseType)responseType success:(SuccessBlock)success fail:(FailBlock)fail {
    
    if ([SAReachabilityManager sharedReachabilityManager].currentReachabilityStatus == NotReachable) {
        /* *************************************************** */
        // 在这里读取本地缓存
        
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[url hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
        [KVNProgress showErrorWithStatus:@"无法连接网络"];
        success(result);
    }else {
//    1.sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    2.处理header
    if (header) {
        for (NSString *key in header.allKeys) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
            
        }
    }
//    3.判断返回数据类型
    switch (responseType) {
        case ResponseTypeDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case ResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ResponseTypeXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
    }
//    4.判断返回值接收的具体类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
//    5.get请求
    [manager GET:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            /* ************************************************** */
            //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[url hash]];
            // 存储的沙盒路径
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 归档
            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    }
}

+ (void)postWithUrl:(NSString *)url body:(id)body bodyType:(BodyType)bodyType httpHeader:(NSDictionary *)header responseType:(responseType)responseType success:(SuccessBlock)success fail:(FailBlock)fail {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    处理body
    switch (bodyType) {
        case BodyTypeDictionary:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case BodyTypeString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
                return parameters;
            }];
            break;
    }
//    处理请求头
    if (header) {
        for (NSString *key in header.allKeys) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
//    判断返回数据类型
    switch (responseType) {
        case ResponseTypeDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case ResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ResponseTypeXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
    }
//    判断返回值接收的具体类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
//    post请求
    [manager POST:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            /* ************************************************** */
            //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[url hash]];
            // 存储的沙盒路径
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 归档
            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    
}

@end
