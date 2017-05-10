//
//  Networking.h
//  
//
//  Created by HarrisHan on 15/6/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void (^NetWorkBlock)(NSData *object);

@interface Networking : NSObject


+(Networking *)shareNetworking;

//GET异步请求

-(void)networkingGetWithURL:(NSString *)urlString Block:(NetWorkBlock)block;



@end
