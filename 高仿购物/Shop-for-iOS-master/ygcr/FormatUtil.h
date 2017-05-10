//
//  FormatUtil.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/8/22.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <Foundation/Foundation.h>

@interface FormatUtil : NSObject

//格式化价格, 总是以人民币显示
+ (NSString *)formatPrice:(NSNumber *)price;
+ (NSString *)formatFloatPrice:(float)price;

@end
