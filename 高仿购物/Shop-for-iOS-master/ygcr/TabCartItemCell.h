//
//  TabCartItemCell.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/03.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "CartItemEntity.h"
#import "CouponUserEntity.h"

@class TabCartItemCell;

@protocol TabCartItemCellDelegate <NSObject>

- (void)doClickMinus:(TabCartItemCell *)sender;

- (void)doClickPlus:(TabCartItemCell *)sender;

- (void)doClickDelete:(TabCartItemCell *)sender;

- (void)doClickSelect:(TabCartItemCell *)sender isSelected:(NSNumber *)isSelected;

@end


@interface TabCartItemCell : UITableViewCell

@property (nonatomic, copy) NSString *cartItemId;

@property (nonatomic, copy) NSNumber *isSelected;

@property (nonatomic, weak) id<TabCartItemCellDelegate> delegate;

+ (CGFloat)height;

- (void)fillContentWithCartItem:(CartItemEntity *)cartItem couponUser:(NSArray *)couponUsers totalPrice:(NSNumber *)totalPrice;

//设置购物车项的数量
- (void) setCount:(NSNumber *)count;

//获得购物车项的数量
- (NSNumber *)getCount;

//设置是否选择项的图片
- (void)setIsSelectedBy:(NSNumber *)isSelected;

@end
