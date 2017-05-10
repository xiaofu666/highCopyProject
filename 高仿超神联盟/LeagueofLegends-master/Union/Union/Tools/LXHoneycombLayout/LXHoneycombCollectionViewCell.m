//
//  LXHoneycombCollectionViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "LXHoneycombCollectionViewCell.h"

@implementation LXHoneycombCollectionViewCell


-(void)settingCellHoneycombStyle{
    
    // step 1: 生成六边形路径
    
    CGFloat longSide = self.itemSize * 0.5 * cosf(M_PI * 30 / 180);
    
    CGFloat shortSide = self.itemSize * 0.5 * sin(M_PI * 30 / 180);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, longSide)];
    
    [path addLineToPoint:CGPointMake(shortSide, 0)];
    
    [path addLineToPoint:CGPointMake(shortSide + self.itemSize * 0.5, 0)];
    
    [path addLineToPoint:CGPointMake(self.itemSize, longSide)];
    
    [path addLineToPoint:CGPointMake(shortSide + self.itemSize * 0.5, longSide * 2)];
    
    [path addLineToPoint:CGPointMake(shortSide, longSide * 2)];
    
    [path closePath];
    
    // step 2: 根据路径生成蒙板
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.path = [path CGPath];
    
    // step 3: 给cell添加模版
    
    self.layer.mask = maskLayer;
    
}

@end
