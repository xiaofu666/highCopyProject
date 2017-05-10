//
//  WNXDetailModel.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/9.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WNXArticleModel;

@interface WNXDetailModel : NSObject

/** detail列表 */
@property (nonatomic, strong) NSArray *poi_list;

/** 头部信息 */
@property (nonatomic, strong) NSDictionary *section_info;

/** 推荐tableveiw数据 */
@property (nonatomic, strong) NSArray *article_list;




+ (instancetype)detailModelWith:(NSDictionary *)dict;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com