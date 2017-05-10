//
//  ProductAttrCell.h
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
#import "ProductForm.h"

/**
 * 属性视图对象
 * 这个对象会改变productForm表单的属性值
 */

@interface ProductAttrCell : UITableViewCell

//高度会根据产品的属性个数自动变化
+ (CGFloat)heightWithProduct:(ProductEntity *)product;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier product:(ProductEntity *)product productForm:(ProductForm *)productForm;

@end
