//
//  XHQNetRequest.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQNetRequest.h"
#import "XHQAuxiliary.h"
@implementation XHQNetRequest
+(void) get:(NSString*)urlString complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{
    
    
    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据格式（二进制）
   // manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =   [NSSet setWithObject:@"text/html"];
    //请求
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (complete) {
            complete(responseObject);//调用block将请求数据返回
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);//将错误信息返回
        }
    }];
}

+(void) post:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{
    
    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * requestManager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据格式（二进制）
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // requestManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
    
    //请求
    [requestManager POST:urlString parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * __nullable operation, NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com