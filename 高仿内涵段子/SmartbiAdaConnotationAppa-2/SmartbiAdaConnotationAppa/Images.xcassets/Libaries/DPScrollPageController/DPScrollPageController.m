//
//  DPScrollPageController.m
//  
//
//  Created by DancewithPeng on 15/10/28.
//
//

#import "DPScrollPageController.h"

#define kCollectionViewCellReuseID @"kCollectionViewCellReuseID"

@interface DPScrollPageController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView           *contentCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (nonatomic, assign) CGPoint beginOffset;  //!< 拖拽开始的偏移量

@property (nonatomic, strong) UIViewController *displayViewController;
@property (nonatomic, strong) UIViewController *dismissViewController;

@property (nonatomic, assign) BOOL scrollAnimated; //!< 用来判断滚动是否带动画，处理ViewController的生命周期函数的

@property (nonatomic, assign) BOOL canTriggerScrollDelegate;

@end

@implementation DPScrollPageController


@dynamic currentIndex;


#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这里用CollectionView作为容器，来组织滑动滚动
    [self.contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellReuseID];
    [self.view addSubview:self.contentCollectionView];
    
    // 添加约束
    [self addConstraintsForContent];
    
    // 观察self.view的frame的变化，当变化的时候，去调整布局
    // 应该在LayoutSubViews里去改变
    // [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewDidLayoutSubviews
{
    [self.contentCollectionView reloadData];
}

// 设置是否自动转发四个Appearance方法
- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return !self.scrollAnimated;
}


#pragma mark - Interface Methods

- (void)addViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    // 用断言来做参数的合法性判断，NSAssert(condition, desc, ...);
    // 第一个参数是条件，如果条件不满足，就会抛出一个异常，让程序崩溃
    // 第二个参数是崩溃之后的描述语
    NSAssert(index>=0 && index<self.viewControllers.count, @"下标：%d 越界了！！！", (int)index);
    
    [self.viewControllers insertObject:viewController atIndex:index];
    [self.contentCollectionView reloadData];
}

- (void)removeViewControllerAtIndex:(NSInteger)index
{
    NSAssert(index>=0 && index<self.viewControllers.count, @"下标：%d 越界了！！！", (int)index);
    
    [self.viewControllers removeObjectAtIndex:index];
    [self.contentCollectionView reloadData];
}

- (void)removeViewController:(UIViewController *)viewController
{
    [self.viewControllers removeObject:viewController];
    [self.contentCollectionView reloadData];
}

- (void)scrollToPageAtIndex:(NSInteger)index animated:(BOOL)animated
{
    NSAssert(index>=0 && index<self.viewControllers.count, @"下标：%d 越界了！！！", (int)index);
    
    self.scrollAnimated = animated;
    
    self.beginOffset = self.contentCollectionView.contentOffset;
    self.canTriggerScrollDelegate = NO;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
    
    if (animated == NO) {
        if ([self.delegate respondsToSelector:@selector(scrollPage:didEndScrollToIndex:)]) {
            [self.delegate scrollPage:self didEndScrollToIndex:index];
        }
    }
}


#pragma mark - KVO

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if (object==self.view && !CGRectEqualToRect([change[@"new"] CGRectValue], [change[@"old"] CGRectValue])) {
//        
//        NSLog(@"%s", __PRETTY_FUNCTION__);
//        
//        [self.contentCollectionView reloadData];
//    }
//}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellReuseID forIndexPath:indexPath];
    
    
    self.displayViewController = self.viewControllers[indexPath.item];
    
    // 将要显示的View
    [self addChildViewController:self.displayViewController];
    [cell.contentView addSubview:self.displayViewController.view];
    self.displayViewController.view.frame = cell.contentView.bounds;
    
    
    // 将要消失的View
    if (self.beginOffset.x != collectionView.contentOffset.x) {
        NSInteger i = (collectionView.contentOffset.x>self.beginOffset.x) ? -1: 1;
        NSInteger index = indexPath.item + i;
        
        if (index>0 && index<self.viewControllers.count) {
            self.dismissViewController = self.viewControllers[index];
        }
        else {
            self.dismissViewController = nil;
        }
    
        if (self.scrollAnimated == YES) {
            // 让将要显示的ViewController调用viewWillAppear方法
            [self.displayViewController beginAppearanceTransition:YES animated:YES];
            // 让将要消失的ViewController调用viewWillDisappear方法
            [self.dismissViewController beginAppearanceTransition:NO animated:YES];
        }
    }
    
    [self.displayViewController didMoveToParentViewController:self];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 已经消失的View
    UIViewController *endViewController = self.viewControllers[indexPath.item];
    [endViewController willMoveToParentViewController:nil];
    [endViewController.view removeFromSuperview];
    [endViewController removeFromParentViewController];
    
    if (self.scrollAnimated == YES) {
        // 让消失的ViewController调用viewDidDisappear方法
        if (endViewController == self.dismissViewController) {
            [endViewController endAppearanceTransition];
        }
        else {
            [self.dismissViewController beginAppearanceTransition:YES animated:NO];
            [self.dismissViewController endAppearanceTransition];
        }
        
        // 已经显示的View, 让已经显示的ViewController调用viewDidAppear方法
        if (endViewController != self.displayViewController) {
            [self.displayViewController endAppearanceTransition];
        }
        else {
            [self.displayViewController beginAppearanceTransition:NO animated:YES];
            [self.displayViewController endAppearanceTransition];
        }
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.contentCollectionView.bounds.size;
}


#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.beginOffset = scrollView.contentOffset;
    self.scrollAnimated = YES;
    self.canTriggerScrollDelegate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.canTriggerScrollDelegate == YES) {
    
        NSInteger currentIndex = self.beginOffset.x / scrollView.bounds.size.width;
        NSInteger destinationIndex = 0;
        CGFloat scale = ABS(self.beginOffset.x - scrollView.contentOffset.x) / scrollView.bounds.size.width;
        
        if (scrollView.contentOffset.x>self.beginOffset.x && scrollView.contentOffset.x<(scrollView.contentSize.width-scrollView.bounds.size.width)) {
            
            destinationIndex = currentIndex+1;
            
            if ([self.delegate respondsToSelector:@selector(scrollPage:didScrollFromIndex:toIndex:scale:)]) {
                [self.delegate scrollPage:self didScrollFromIndex:currentIndex toIndex:destinationIndex scale:scale];
            }
        }
        else if (scrollView.contentOffset.x<self.beginOffset.x && scrollView.contentOffset.x>0) {
            destinationIndex = currentIndex-1;
            
            if ([self.delegate respondsToSelector:@selector(scrollPage:didScrollFromIndex:toIndex:scale:)]) {
                [self.delegate scrollPage:self didScrollFromIndex:currentIndex toIndex:destinationIndex scale:scale];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scrollPage:didEndScrollToIndex:)]) {
        [self.delegate scrollPage:self didEndScrollToIndex:scrollView.contentOffset.x/scrollView.bounds.size.width];
    }
}


#pragma mark - Helper Methods

- (void)addConstraintsForContent
{
    self.contentCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"CollectionView": self.contentCollectionView};
    NSArray *collectionHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[CollectionView]-0-|" options:0 metrics:nil views:views];
    NSArray *collectionVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[CollectionView]-0-|" options:0 metrics:nil views:views];
    
    [self.view addConstraints:collectionHConstraints];
    [self.view addConstraints:collectionVConstraints];
}


#pragma mark - Getter

- (UICollectionView *)contentCollectionView
{
    if (_contentCollectionView == nil) {
        _contentCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewFlowLayout];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.pagingEnabled = YES;
        _contentCollectionView.backgroundColor = [UIColor clearColor];
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.showsVerticalScrollIndicator = NO;
    }
    
    return _contentCollectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout
{
    if (_collectionViewFlowLayout == nil) {
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _collectionViewFlowLayout;
}

- (NSMutableArray *)viewControllers
{
    if (_viewControllers == nil) {
        _viewControllers = [[NSMutableArray alloc] init];
    }
    
    return _viewControllers;
}

- (NSInteger)currentIndex
{
    return self.contentCollectionView.contentOffset.x / self.contentCollectionView.bounds.size.width;
}

@end
