//
//  AvatarsModel.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//  图片信息模型

#import <Foundation/Foundation.h>

@interface AvatarsModel : NSObject

/** 小 */
@property (nonatomic ,strong) NSString *small;
/** 大 */
@property (nonatomic ,strong) NSString *large;
/** 中 */
@property (nonatomic ,strong) NSString *medium;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com