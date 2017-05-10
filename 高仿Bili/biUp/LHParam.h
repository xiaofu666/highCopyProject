//
//  LHParam.h
//  biUp
//
//  Created by snowimba on 15/12/24.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHParam : NSObject
@property (nonatomic,copy) NSString *param;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *danmaku;
@property (nonatomic,copy) NSString *update_time;
@property (nonatomic,copy) NSString *index;
+ (instancetype)paramWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com