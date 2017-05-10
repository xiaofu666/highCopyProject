//
//  UserInfoView.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 16/3/14.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"

@interface UserInfoView : UIView

- (instancetype)initWithFrame:(CGRect)frame user:(UserEntity *)user;

@end
