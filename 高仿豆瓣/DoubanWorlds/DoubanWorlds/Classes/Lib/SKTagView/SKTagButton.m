//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@implementation SKTagButton

+ (instancetype)buttonWithTag:(SKTag *)tag
{
	SKTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
	
	if (tag.attributedText) {
		[btn setAttributedTitle:tag.attributedText forState:UIControlStateNormal];
	} else {
		[btn setTitle:tag.text forState:UIControlStateNormal];
		[btn setTitleColor:tag.textColor forState:UIControlStateNormal];
		btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize:tag.fontSize];
	}
	
	btn.backgroundColor = tag.bgColor;
	btn.contentEdgeInsets = tag.padding;
	btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	
    if (tag.bgImg)
    {
        [btn setBackgroundImage:tag.bgImg forState:UIControlStateNormal];
    }
    
    if (tag.borderColor)
    {
        btn.layer.borderColor = tag.borderColor.CGColor;
    }
    
    if (tag.borderWidth)
    {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    btn.userInteractionEnabled = tag.enable;
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com