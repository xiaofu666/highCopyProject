//
//  WNXRmndHeadView.h
//  WNXHuntForCity
//
//  Created by MacBook on 15/7/2.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNXHomeModel.h"

@interface WNXRmndHeadView : UIView

//headView的模型，重写set方法
@property (nonatomic, strong) WNXHomeModel *headMode;
//便利构造方法
+ (instancetype)headViewWith:(WNXHomeModel *)headModel;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com