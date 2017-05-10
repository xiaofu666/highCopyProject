//
//  LHCommM.h
//  biUp
//
//  Created by snowimba on 15/12/22.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCommM : NSObject

@property (nonatomic,copy) NSString *face;
@property (nonatomic,copy) NSString *create_at;
@property (nonatomic,assign) NSInteger good;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,copy) NSString *nick;
@property (nonatomic,strong) NSArray *reply;
@property (nonatomic,assign) NSInteger lv;
@property (nonatomic,assign) NSInteger isgood;

+(instancetype)cellWithDict:(NSDictionary *)dict;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com