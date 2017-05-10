//
//  CircleView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (nonatomic , retain ) UIColor *strokeColor;

@property (nonatomic , retain ) UIColor *backColor;

@property (nonatomic , copy ) NSString *title;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
