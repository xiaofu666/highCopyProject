//
//  XBTagTitleModel.m
//  XBScrollPageController
//
//  Created by Scarecrow on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XBTagTitleModel.h"

@implementation XBTagTitleModel
+ (XBTagTitleModel *)modelWithtagTitle:(NSString *)title
                    andNormalTitleFont:(UIFont *)normalTitleFont
                  andSelectedTitleFont:(UIFont *)selectedTitleFont
                   andNormalTitleColor:(UIColor *)normalTitleColor
                 andSelectedTitleColor:(UIColor *)selectedTitleColor
{
    XBTagTitleModel *tag = [[self alloc]init];
    tag.tagTitle = title;
    tag.normalTitleFont = normalTitleFont;
    tag.selectedTitleFont = selectedTitleFont;
    tag.normalTitleColor = normalTitleColor;
    tag.selectedTitleColor = selectedTitleColor;
    return tag;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com