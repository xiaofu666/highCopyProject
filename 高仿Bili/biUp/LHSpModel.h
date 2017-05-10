//
//  LHSpModel.h
//  biUp
//
//  Created by snowimba on 15/12/24.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHSpModel : NSObject
@property (nonatomic,copy) NSString *evaluate;
@property (nonatomic,strong) NSArray *episodes;
@property (nonatomic,strong) NSArray *tags;
@property (nonatomic,strong) NSArray *seasons;
+(instancetype)spMWithDict:(NSDictionary *)dict;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com