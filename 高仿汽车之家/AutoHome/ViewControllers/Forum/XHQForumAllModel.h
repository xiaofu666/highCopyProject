//
//  XHQForumAllModel.h
//  AutoHome
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQModel.h"

@interface XHQForumAllModel : XHQModel

@property(nonatomic,strong)NSDictionary *author;
//@property(nonatomic,copy)NSString *lastpostAt;
@property(nonatomic,assign)NSTimeInterval lastpostAt;

@property(nonatomic,strong)NSString *flag;

@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *replyCount;
@property(nonatomic,copy)NSString *view;


@property(nonatomic,copy)NSString *isBestAnswer;
@property(nonatomic,copy)NSString *isContainImage;


@property(nonatomic,copy)NSString *uri;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com