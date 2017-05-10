//
//  WNXFoundCellModel.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/7.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  发现 cell的模型

#import <Foundation/Foundation.h>

@interface WNXFoundCellModel : NSObject

/** 图片名 */
@property (nonatomic, copy) NSString *icon;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 副标题 */
@property (nonatomic, copy) NSString *subTitle;

+ (instancetype)foundCellModelWihtDict:(NSDictionary *)dict;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com