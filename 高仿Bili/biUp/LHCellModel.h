//
//  LHCellModel.h
//  biUp
//
//  Created by snowimba on 15/12/10.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"
@interface LHCellModel : YHCoderObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *danmaku;
@property (nonatomic,copy) NSString *desc1;
@property (nonatomic,copy) NSString *desc2;
@property (nonatomic,copy) NSString *play;
@property (nonatomic,copy) NSString *param;
@property (nonatomic,copy) NSString *up;
@property (nonatomic,copy) NSString *online;
@property (nonatomic,copy) NSString *small_cover;
@property (nonatomic,assign) NSInteger rand;
@property (nonatomic,copy) NSString *collTime;
@property (nonatomic,copy) NSString *hisTime;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cellMWithDict:(NSDictionary *)dict;
//+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com