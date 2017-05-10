//
//  WSChannel.h
//  网易新闻
//
//  Created by WackoSix on 16/1/8.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSChannel : NSObject

/**频道的标识*/
@property (copy, nonatomic) NSString *tid;

/**频道的名称*/
@property (copy, nonatomic) NSString *tname;

/**频道的相对URL*/
@property (copy, nonatomic) NSString *channelURL;

+ (instancetype)channelWithDict:(NSDictionary *)dict;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com