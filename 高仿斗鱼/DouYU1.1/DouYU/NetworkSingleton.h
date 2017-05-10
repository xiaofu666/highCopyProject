//
//  NetworkSingleton.h
//  文件.h
//
//  Created by Alesary on 15/9/15.
//  Copyright (c) 2015年 Alesary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//请求超时
#define TIMEOUT 30

typedef void(^SuccessBlock)(id responseBody);

typedef void(^FailureBlock)(NSString *error);

@interface NetworkSingleton : NSObject

+(NetworkSingleton *)sharedManager;
-(AFHTTPRequestOperationManager *)baseHtppRequest;

#pragma mark - GET
-(void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - POST
-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - AFN上传照片
-(void)upImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
