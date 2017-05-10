//
//  WNXInfoModel.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/19.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNXInfoModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) BOOL isShowImage;
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)infoModelWithDict:(NSDictionary *)dict;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com