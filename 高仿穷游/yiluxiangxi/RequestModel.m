//
//  RequestModel.m
//  iOS6.2爱限免
//
//  Created by 唐僧 on 15/10/19.
//  Copyright (c) 2015年 于延宇. All rights reserved.
//

#import "RequestModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "MMProgressHUD.h"

@implementation RequestModel

-(void)startRequestInfo{
    //<1>
    AFHTTPRequestOperationManager* manger=[AFHTTPRequestOperationManager manager];
    //<2>
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    //<3>添加活动指示器
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showDeterminateProgressWithTitle:nil status:@"正在加载😄"];
    //<4>开始请求数据并解析
    [manger GET:self.path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(sendMessage:andPath:)]) {
            [self.delegate sendMessage:responseObject andPath:self.path];
        }
        [MMProgressHUD dismissWithSuccess:@"加载成功"];
        //NSLog(@"加载成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)startPostRequestInfo{
    //<1>
    //NSLog(@"***");
    AFHTTPRequestOperationManager* manger=[AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //<3>添加活动指示器
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showDeterminateProgressWithTitle:nil status:@"正在加载😄"];
    [manger POST:self.path parameters:self.postBodyDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(sendMessage:andPath:)]) {
            [self.delegate sendMessage:responseObject andPath:self.path];
        }
        [MMProgressHUD dismissWithSuccess:@"加载成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
