//
//  ProductInfoCell.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/29.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "ProductEntity.h"

//产品详情页顶部的产品信息
@interface ProductInfoCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier product:(ProductEntity *)product;

+ (CGFloat)heightWithNoShortDescription;

+ (CGFloat)heightWithShortDescription;

@end
