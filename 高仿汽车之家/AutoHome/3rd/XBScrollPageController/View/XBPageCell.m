//
//  XBPageCell.m
//  XBScrollPageController
//
//  Created by Scarecrow on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XBPageCell.h"

@implementation XBPageCell
- (void)configCellWithController:(UIViewController *)controller
{
    controller.view.frame = self.bounds;
    [self.contentView addSubview:controller.view];
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com