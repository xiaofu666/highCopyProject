//
//  DPScrollPageTitleView.h
//  DPScrollPageControllerDemo
//
//  Created by DancewithPeng on 15/10/30.
//  Copyright © 2015年 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPScrollPageTitleView;

/**
 *  滚动页标题栏的代理协议
 */
@protocol DPScrollPageTitleViewDelegate <NSObject>

@optional

/**
 *  对应的Title被点击
 *
 *  @param titleView  标题栏
 *  @param titleLabel 对应的Title
 *  @param index      对应的下标
 */
- (void)scrollPageTitleView:(DPScrollPageTitleView *)titleView titleDidTap:(UILabel *)titleLabel atIndex:(NSInteger)index;


/**
 *  标题栏滚动
 *
 *  @param titleView 标题栏
 *  @param offset    滚动的偏移量
 */
- (void)scrollPageTitleView:(DPScrollPageTitleView *)titleView didScrollWithOffset:(CGPoint)offset;

@end


/**
 *  滚动页的标题栏
 */
@interface DPScrollPageTitleView : UIView

@property (nonatomic, assign          ) BOOL    scrollEnable;//!< 是否可以滚动
@property (nonatomic, strong, readonly) UIView  *sliderView;//!< 滑块
@property (nonatomic, weak            ) id<DPScrollPageTitleViewDelegate> delegate;//!< 代理

/**
 *  初始化方法，同时指定显示哪些Title，和每个Title的宽度
 *
 *  @param frame     位置
 *  @param titles    显示的title
 *  @param itemWidth 每个Title的宽度
 *
 *  @return 初始化好的标题栏
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles itemWidth:(CGFloat)itemWidth;


/**
 *  在指定位置添加标题
 *
 *  @param title 要添加的标题
 *  @param index 位置
 */
- (void)addTitle:(NSString *)title atIndex:(NSInteger)index;


/**
 *  删除标题
 *
 *  @param index 要删除的标题的下标
 */
- (void)removeTitleAtIndex:(NSInteger)index;


/**
 *  获取标题
 *
 *  @param index 要获取的标题的下标
 *
 *  @return 对应下标的标题
 */
- (UILabel *)titleLabelForIndex:(NSInteger)index;


/**
 *  添加滑块
 *
 *  @param sliderView 滑块
 */
- (void)addSliderView:(UIView *)sliderView;


/**
 *  滚动到让指定的Title可见
 *
 *  @param titleLabel 要看到的Title
 */
- (void)scrollToVisibleTitleLabel:(UILabel *)titleLabel;


/**
 *  滚动到让指定的Title可见
 *
 *  @param index 要看到的Title的下标
 */
- (void)scrollToVisibleTitleLabelAtIndex:(NSInteger)index;


/**
 *  滚动到让指定的Title居中
 *
 *  @param index 对应的下标
 */
- (void)scrollToCenterForTitleLabelAtIndex:(NSInteger)index;

@end
