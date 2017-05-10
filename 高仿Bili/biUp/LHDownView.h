//
//  LHDownView.h
//  biUp
//
//  Created by snowimba on 16/1/7.
//  Copyright © 2016年 snowimba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHDownView : UIView
+ (instancetype)downLoadView;
@property (nonatomic,copy) void(^pushBlock)();
@property (nonatomic,strong) id cellM;
@property (nonatomic,strong) NSArray *arrDict;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com