//
//  BaseViewController.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlassView.h"
@interface BaseViewController : UIViewController

/**
 *  毛玻璃效果view
 */
@property (nonatomic,strong)GlassView * glassView;

/**
 *  添加nav上右按钮，图片
 */
- (void)addRightBtnWithImgName:(NSString *)imgName andSelector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串
 */
- (void)addRightBtnWithStr:(NSString *)str andSelector:(SEL)sel;

/**
 *  添加nav上左按钮，字符串
 */
- (void)addLeftBtnWithStr:(NSString *)str andSelector:(SEL)sel;
@end
