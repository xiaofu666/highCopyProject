//
//  RunesModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/14.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunesModel : NSObject

@property (nonatomic , copy ) NSString *Name;//符文名称

@property (nonatomic , copy ) NSString *Alias;//符文别名

@property (nonatomic , copy ) NSString *lev1;//1级符文

@property (nonatomic , copy ) NSString *lev2;//2级符文

@property (nonatomic , copy ) NSString *lev3;//3级符文

@property (nonatomic , copy ) NSString *iplev1;//1级符文价钱

@property (nonatomic , copy ) NSString *iplev2;//2级符文价钱

@property (nonatomic , copy ) NSString *iplev3;//3级符文价钱

@property (nonatomic , copy ) NSString *Prop;//符文属性

@property (nonatomic , assign ) NSInteger Type;//符文类型

@property (nonatomic , copy ) NSString *Img;//符文图片名称

@property (nonatomic , copy ) NSString *Units;//单位

@property (nonatomic , assign ) NSInteger level;//等级

@end
