//
//  OrderListCell.h
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
#import "OrderEntity.h"

@interface OrderListCell : UITableViewCell

+ (CGFloat)height;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier order:(OrderEntity *)order;

@end
