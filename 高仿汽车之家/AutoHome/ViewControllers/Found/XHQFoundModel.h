//
//  XHQFoundModel.h
//  AutoHome
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQModel.h"

@interface XHQFoundModel : XHQModel
@property(nonatomic,strong)NSDictionary *author;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,strong)NSDictionary *lastPoster;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)NSTimeInterval lastpostAt;
@property(nonatomic,copy)NSString *uri;
@property(nonatomic,copy)NSString *floor;
@property(nonatomic,copy)NSString *view;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com