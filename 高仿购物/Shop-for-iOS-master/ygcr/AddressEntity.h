//
//  AddressEntity.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/07/19.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "BaseEntity.h"
#import "AreaEntity.h"

@interface AddressEntity : BaseEntity

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSNumber *isDefault;

@property (nonatomic, strong) AreaEntity *area;

@end
