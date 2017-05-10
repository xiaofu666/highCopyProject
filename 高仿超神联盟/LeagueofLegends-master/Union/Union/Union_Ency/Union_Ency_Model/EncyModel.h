//
//  EncyModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncyModel : NSObject

@property (nonatomic , copy) NSString *name;//菜单名

@property (nonatomic , copy) NSString *iconName;//图标名


-(id)initWithName:(NSString *)name IconName:(NSString *)iconName;

@end
