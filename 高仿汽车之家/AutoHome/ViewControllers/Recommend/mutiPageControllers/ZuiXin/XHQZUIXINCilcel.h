//
//  XHQZUIXINCilcel.h
//  AutoHome
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol XHQZUIXINCilcelDeletage <NSObject>

- (void)didSelectedLocalImage:(NSString *)url;

@end


@interface XHQZUIXINCilcel : UIView


@property(nonatomic,strong)id<XHQZUIXINCilcelDeletage>deletage;


- (instancetype)initWithFrame:(CGRect )frame andCircleArray:(NSArray *)array;



@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com