//
//  UserInfoController.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/21.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseController.h"
#import "UserEntity.h"

@interface UserInfoController : BaseController

- (instancetype)initWithUser:(UserEntity *)user;

@end
