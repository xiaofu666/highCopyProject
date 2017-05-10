//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTag.h"

@implementation SKTag

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        _text = text;
        _fontSize = 15;
        _textColor = [UIColor blackColor];
        _bgColor = [UIColor whiteColor];
        _enable = YES;
    }
    
    return self;
}

+ (instancetype)tagWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com