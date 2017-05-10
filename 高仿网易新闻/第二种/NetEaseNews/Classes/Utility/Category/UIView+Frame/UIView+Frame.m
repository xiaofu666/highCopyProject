//
//  UIVieh+Frame.m
//  网易彩票
//
//  Created by WackoSiw on 15/12/16.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
        
}

- (CGFloat)x{
    
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
    
}

- (CGFloat)y{
    
    return self.frame.origin.x;
}

- (void)setW:(CGFloat)w{
    
    CGRect frame = self.frame;
    
    frame.size.width = w;
    
    self.frame = frame;
    
}

- (CGFloat)w{
    
    return self.frame.size.width;
}


- (void)setH:(CGFloat)h{
    
    CGRect frame = self.frame;
    
    frame.size.height = h;
    
    self.frame = frame;
    
}

- (CGFloat)h{
    
    return self.frame.size.height;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com