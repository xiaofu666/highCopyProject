//
//  QuanModel.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/17.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuanModel : NSObject

/** 发帖人名字 */
@property(nonatomic,copy)NSString * name;

/** 发帖人头像Url */
@property(nonatomic,copy)NSString * avaterUrl;

/** 发帖时间 */
@property(nonatomic,copy)NSString * time;

/** 评论数组 */
@property(nonatomic,copy)NSArray * comments;

/** 图片数组 */
@property(nonatomic,copy)NSArray * imgs;
@end
