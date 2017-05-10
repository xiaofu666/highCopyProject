//
//  LXContextMenuCell.h
//  ContextMenu
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LXContextMenuCell <NSObject>

/*!

 @abstract
 
 在动画被处理时调用的方法如下
 
 */

- (UIView *)animatedIcon;

- (UIView *)animatedContent;

@end
