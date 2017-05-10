//
//  RequestModel.h
//  iOS6.2爱限免
//
//  Created by 唐僧 on 15/10/19.
//  Copyright (c) 2015年 于延宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol sendRequestInfo <NSObject>

//由于同一个界面的请求数据可能不止一个 所以为了区分是哪一个接口的信息 传递一个接口回去比较
-(void)sendMessage:(id)message andPath:(NSString* )path;

@end

@interface scRequestModel : NSObject

//所有视图控制器请求数据都是要用该类完成
@property(nonatomic,copy)NSString* path;

@property(nonatomic,strong)NSDictionary* postBodyDic;

//触发get数据请求的方法
-(void)startRequestInfo;

//触发POST请求的方法
-(void)startPostRequestInfo;

@property(nonatomic,assign) id<sendRequestInfo> delegate;


@end
