//
//  DiskSpaceProgressView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/24.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiskSpaceProgressView : UIView

@property (nonatomic , copy ) NSString *titleStr;//标题字符串

@property (nonatomic , retain ) UIColor *progressColor;//进度条颜色

@property (nonatomic , retain ) UIColor *trackColor;//背景条颜色

//设置进度

- (void)setProgress:(float)progress;

@end
