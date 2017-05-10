//
//  Networking.m
//  
//
//  Created by HarrisHan on 15/6/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Networking.h"

#import "UIView+LXAlertView.h"


static Networking *network;

@implementation Networking


+(Networking *)shareNetworking{
    
    @synchronized(self){
        
        if (network == nil) {
            
            network = [[Networking alloc]init];
            
        }
        
        return network;
    }
}

//GET异步请求 返回DATA

-(void)networkingGetWithURL:(NSString *)urlString Block:(NetWorkBlock)block{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //创建请求对象
    
    NSMutableURLRequest *request=[NSMutableURLRequest  requestWithURL:url];
    
    //设置请求超时
    
    request.timeoutInterval= 30.0f;
    
    request.HTTPMethod = @"GET";

    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        block(data);
        
        
    }];
    
}


@end
