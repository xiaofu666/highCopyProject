//
//  LHCellView.h
//  biUp
//
//  Created by snowimba on 15/12/10.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHCellModel;
@interface LHCellView : UIView
@property (nonatomic,strong) LHCellModel *cellM;
+ (instancetype)viewWithNib;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com