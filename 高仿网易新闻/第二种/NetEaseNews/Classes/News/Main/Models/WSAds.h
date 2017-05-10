//
//  WSAds.h
//  网易新闻
//
//  Created by WackoSix on 15/12/29.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSAds : NSObject

//"imgsrc": "http://img3.cache.netease.com/3g/2015/12/27/20151227203459572a9.png",
//"subtitle": "",
//"tag": "photoset",
//"title": "夫妻二胎生三胞胎儿子 曾想将儿送人",
//"url": "54GI0096|85429"

@property (copy, nonatomic) NSString *imgsrc;

@property (copy, nonatomic) NSString *subtitle;

@property (copy, nonatomic) NSString *tag;

@property (copy, nonatomic) NSString *docid;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *url;

+ (instancetype)adsWithDict:(NSDictionary *)dict;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com