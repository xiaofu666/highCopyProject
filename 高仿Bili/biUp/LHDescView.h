//
//  LHView.h
//  testWeb
//
//  Created by snowimba on 15/12/10.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHDescModel;
@interface LHDescView : UIView
@property (nonatomic, strong) LHDescModel* testM;
@property (nonatomic, copy) void (^btnClickWith)(LHDescModel*);
//@property (nonatomic,strong) NSArray *arrDict;
+ (instancetype)viewWithNib;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com