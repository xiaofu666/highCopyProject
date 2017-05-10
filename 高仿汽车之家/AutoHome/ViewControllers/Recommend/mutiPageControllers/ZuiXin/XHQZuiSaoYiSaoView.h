//
//  XHQZuiSaoYiSaoView.h
//  
//
//  Created by qianfeng on 16/3/25.
//
//

#import <UIKit/UIKit.h>

@interface XHQZuiSaoYiSaoView : UIView
+ (void)configCustomPopViewWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr dataSourceArr:(NSArray *)dataourceArr anchorPoint:(CGPoint)anchorPoint seletedRowForIndex:(void(^)(NSInteger index))action animation:(BOOL)animation timeForCome:(NSTimeInterval)come timeForGo:(NSTimeInterval)go;
+ (void)removed;


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com