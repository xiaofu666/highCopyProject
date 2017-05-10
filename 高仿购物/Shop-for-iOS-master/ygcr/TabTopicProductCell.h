//
//  TabTopicProductCell.h
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

@class ProductEntity;

@interface TabTopicProductCell : UITableViewCell

+ (CGFloat)height;

- (void)fillContentWithProduct:(ProductEntity *)product tagName:(NSString *)name;

@end
