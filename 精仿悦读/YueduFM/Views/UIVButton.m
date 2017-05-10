//
//  UIVButton.m
//  weiju-ios
//
//  Created by StarNet on 8/20/15.
//  Copyright (c) 2015 evideo. All rights reserved.
//

#import "UIVButton.h"

@implementation UIVButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    self.imageEdgeInsets = UIEdgeInsetsMake((self.height-self.imageView.height-self.titleLabel.height)/2, (self.width-self.imageView.width)/2, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake((self.height-self.imageView.height-self.titleLabel.height)/2+self.imageView.height, (self.width-self.titleLabel.width)/2-self.imageView.width, 0, 0);
}

@end
