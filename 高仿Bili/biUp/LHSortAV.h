//
//  LHSortAV.h
//  biUp
//
//  Created by snowimba on 16/1/11.
//  Copyright © 2016年 snowimba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHSortAV : NSObject
@property (nonatomic,strong) NSNumber *AV;
@property (nonatomic,strong) NSNumber *P;
@property (nonatomic,strong) NSNumber *CID;
@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *Mp4Url;
+ (instancetype)sortAVWithDict:(NSDictionary *)dict;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com