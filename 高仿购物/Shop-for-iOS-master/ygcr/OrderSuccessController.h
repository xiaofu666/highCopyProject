//
//  OrderSuccessController.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/9/18.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseController.h"
#import "OrderEntity.h"

@interface OrderSuccessController : BaseController

- (instancetype)initWithOrder:(OrderEntity *)order;

@end
