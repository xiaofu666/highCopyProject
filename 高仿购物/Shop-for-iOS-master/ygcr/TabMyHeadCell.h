//
//  TabMyHeadCell.h
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
#import "UserEntity.h"

@protocol TabMyHeadCellDelegate <NSObject>

@end


@interface TabMyHeadCell : UITableViewCell

+ (CGFloat)height;

- (void)fillContentWithUser:(UserEntity *)user;

@end
