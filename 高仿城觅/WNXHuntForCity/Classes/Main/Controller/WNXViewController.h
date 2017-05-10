//
//  WNXViewController.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/6/30.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^coverDidRomove)();

@interface WNXViewController : UIViewController

//** 遮盖按钮 */
@property (nonatomic, strong) UIButton *coverBtn;

@property (nonatomic, strong) coverDidRomove coverDidRomove;

@property (nonatomic, assign) BOOL isScale;

- (void)coverClick;

/** 点击缩放按钮 */
- (void)rightClick;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com