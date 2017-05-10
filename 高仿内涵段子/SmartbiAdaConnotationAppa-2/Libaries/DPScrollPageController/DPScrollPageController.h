//
//  DPScrollPageController.h
//  
//
//  Created by DancewithPeng on 15/10/28.
//
//

#import <UIKit/UIKit.h>

@class DPScrollPageController;

/**
 *  滚动页的代理
 */
@protocol DPScrollPageControllerDelegate <NSObject>

@optional

/**
 *  滚动页从一页滚动到另一页
 *
 *  @param scrollPage 滚动页
 *  @param fromIndex  原本在这一页
 *  @param toIndex    要滚动到的页
 *  @param scale      位移的比例
 */
- (void)scrollPage:(DPScrollPageController *)scrollPage didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex scale:(CGFloat)scale;


/**
 *  已经滚动到指定的页
 *
 *  @param scrollPage 滚动页控件
 *  @param toIndex    要滚动到的页
 */
- (void)scrollPage:(DPScrollPageController *)scrollPage didEndScrollToIndex:(NSInteger)toIndex;

@end



/**
 *  滚动页的封装
 */
@interface DPScrollPageController : UIViewController

@property (nonatomic, strong) NSMutableArray *viewControllers;  //!< 管理的ViewControllers

@property (nonatomic, assign, readonly) NSInteger currentIndex; //!< 当前显示的页面

@property (nonatomic, weak) id<DPScrollPageControllerDelegate> delegate; //!< 代理

/**
 *  在指定的位置添加一个ViewController
 *
 *  @param viewController 要添加的ViewController
 *  @param index          添加的位置
 */
- (void)addViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;


/**
 *  删除指定位置的ViewController
 *
 *  @param index 要删除的ViewController的位置
 */
- (void)removeViewControllerAtIndex:(NSInteger)index;


/**
 *  删除指定的ViewController
 *
 *  @param viewController 要删除的ViewController
 */
- (void)removeViewController:(UIViewController *)viewController;


/**
 *  滚动到指定的页面
 *
 *  @param index 指定的页面的Index
 *  @param animated 滚动是否带动画
 */
- (void)scrollToPageAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
