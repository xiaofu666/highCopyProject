//
//  PreorderAddressCell.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/11/01.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>
#import "AddressEntity.h"

@protocol PreorderAddressCellDelegate <NSObject>

- (void)doClickAddressCell;

@end


@interface PreorderAddressCell : UITableViewCell

@property (nonatomic, weak) id<PreorderAddressCellDelegate> delegate;

+ (CGFloat)height;

- (void)fillContentWithAddress:(AddressEntity *)address;

@end
