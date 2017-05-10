//
//  LHScrollViewM.h
//  biUp
//
//  Created by snowimba on 15/12/12.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHScrollViewM : UIView
@property (nonatomic,strong) NSArray *arrDict;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

+(instancetype)scrollViewM;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com