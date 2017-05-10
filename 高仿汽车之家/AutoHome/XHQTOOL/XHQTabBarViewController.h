//
//  XHQTabBarViewController.h
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHQTabBarViewController : UITabBarController
@property(nonatomic,strong) NSMutableArray * controllers
;

//@tip  创建tabbaritem
//@para title tabbaritem标题
//      normal 正常情况下tabbaritem图片
//      selectedImage 选中情况下tabbaritem图片
//      controllerName tabbaritem所对应的的控制器
//@result  无
-(void) addItem:(NSString*)title normalImage:(UIImage*)normal highLightImage:(UIImage*)selectedImage controller:(NSString*)controllerName ;





@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com