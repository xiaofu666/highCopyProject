//
//  UIView+HSFView.h
//  SportsLotteryTicket
//
//  Created by 胡双飞 on 15/8/26.
//  Copyright (c) 2015年 HSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HSFView)

/**
 *  快速在bounds内部设置x坐标
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  快速在bounds内部设置y坐标
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  快速设置width
 */
@property (nonatomic, assign) CGFloat w;
/**
 *  快速设置height
 */
@property (nonatomic, assign) CGFloat h;

@end
