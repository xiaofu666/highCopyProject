//
//  NSDictionary+Tools.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/7.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Tools)
/*
 *未排序的参数
 */
- (NSString*)appendGetParameterWithBasePath:(NSString*)path;
/*
 *已经排序的参数
 */
- (NSString*)appendGetSortParameterWithBasePath:(NSString*)path;
/*
 *已经排序的参数自动加上sign
 */
- (NSString*)appendGetSortParameterWithSignWithBasePath:(NSString*)path;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com