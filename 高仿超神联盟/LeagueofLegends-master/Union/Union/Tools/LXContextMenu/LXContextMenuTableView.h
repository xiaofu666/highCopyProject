//
//  LXTableView.h
//  LXMenuAnimation
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXContextMenuTableView;

@protocol LXContextMenuTableViewDelegate <NSObject>

@optional

/*!
 @abstract
 菜单收回方法
 
 @param contextMenuTableView - object dismissed
 
 @param indexPath - 选中的cell的indexPath
*/
- (void)contextMenuTableView:(LXContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath;

@end


@interface LXContextMenuTableView : UITableView

@property (nonatomic, strong) NSArray *menuTitles;//菜单标题

@property (nonatomic, strong) NSArray *menuIcons;//菜单图标

@property (nonatomic, assign) id<LXContextMenuTableViewDelegate>LXDelegate;

/*! @abstract 动画的持续时间秒 */

@property (nonatomic) CGFloat animationDuration;


/*!
 @abstract
 
 调用这个方法在实例的表视图 设置两个代理
 
 @param delegateDataSource - 为类添加两个代理方法
 
 @return LXTableView 对象 或者 nil
*/

- (instancetype)initWithTableViewDelegateDataSource:(id<UITableViewDelegate, UITableViewDataSource>)delegateDataSource;

/*!
 @abstract
 
 使用这种方法，因为[superview addSubview:MyLXTableView]不会出现侧边菜单正确。

 @param 视图弹出菜单. 如果使用了导航控制器 更好使用
 
 @param YES 或 NO 是否显示动画效果
 
 */

- (void)showInView:(UIView *)superview withEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated;

/*!
 @abstract
 
 收回菜单动画
 
 @param 选中cell的indexPath (to be hidden the las one)
 
 */
- (void)dismisWithIndexPath:(NSIndexPath *)indexPath;

/*!
 @abstract
 
 在设备旋转动画之前或期间调用此方法
 */
- (void)updateAlongsideRotation;


@end
