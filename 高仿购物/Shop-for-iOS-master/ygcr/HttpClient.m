//
//  HttpClient.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/8/16.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "HttpClient.h"

@implementation HttpClient

+ (instancetype)sharedInstance
{
    static HttpClient *client;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        client = [[HttpClient alloc] init];
    });
    return client;
}

- (void)request:(NSString *)url
         params:(NSDictionary *)params
           type:(HttpResponseType)type
        success:(void(^)(NSObject *response))success
        failure:(void(^)(NSError *error))failure
{
    //__weak typeof(self) weakSelf = self;
    [self POST:url parameters:params
       success:^(AFHTTPRequestOperation *operation, id response){
           
            #ifdef DEBUG
                //NSLog(@"url:%@\r\nbody:%@", url, response);
            #endif
           
           success(response);
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error){
           failure(error);
       }];
    
}

+ (void)requestJson:(NSString *)url
             params:(NSMutableDictionary *)params
            success:(void(^)(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data))success
            failure:(void(^)(NSError *error))failure
{
    if (!params)
        params = [NSMutableDictionary new];
    
    //总是提交客户端类型参数，标明是什么类型的客户端
    [params setObject:kTerminalTypeValue forKey:kTerminalTypeName];
    
    //提交appCartCookieId，不注册用户也能添加产品到购物车
    NSString *appCartCookieId = [StorageUtil getAppCartCookieId];
    NSString *appLoginToken = [StorageUtil getAppLoginToken];
    NSString *userId = [StorageUtil getUserId];
    if (appCartCookieId.length > 0) {
        [params setObject:appCartCookieId forKey:kStorageAppCartCookieId];
    }
    if (appLoginToken.length > 0) {
        [params setObject:appLoginToken forKey:kStorageAppLoginToken];
    }
    if (userId.length > 0) {
        [params setObject:userId forKey:kStorageUserId];
    }
    
    [[self sharedInstance] request:url params:params type:HttpResponseType_Json
                                 success:^(NSObject *response){
                                     NSDictionary *dict = (NSDictionary *)response;
                                     BOOL result = [[dict objectForKey:@"result"] boolValue];
                                     NSNumber *resultCode = [dict objectForKey:@"resultCode"];
                                     NSString *message = [dict objectForKey:@"message"];
                                     NSDictionary *data = [dict objectForKey:@"data"];
                                     success(result, resultCode, message, data);
                                 }
                                 failure:failure];
}

@end
