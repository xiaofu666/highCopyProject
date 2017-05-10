//
//  LunBoPic.h
//  presents
//
//  Created by dllo on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CarouselDelegate <NSObject>

- (void)changeVC:(NSString *)string;

@end
@interface LunBoPic : UIView<UIScrollViewDelegate>

typedef enum : NSUInteger {
    defaults,                 // 默认scrollView的滚动效果
    cube,                     // 立方体翻滚效果
    moveIn,                   // 新视图移到旧视图上面
    reveal,                   // 显露效果(将旧视图移开,显示下面的新视图)
    fade,                     // 交叉淡化过渡(不支持过渡方向)
    pageCurl,                 // 向上翻一页
    pageUnCurl,               // 向下翻一页
    suckEffect,               // 收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
    rippleEffect,             // 滴水效果,(不支持过渡方向)
    oglFlip,                  // 上下左右翻转效果
    rotate,                   // 旋转效果
    push,                     // 新视图把旧视图推出去
    cameraIrisHollowOpen,     // 相机镜头打开效果(不支持过渡方向)
    cameraIrisHollowClose,    // 相机镜头关上效果(不支持过渡方向)
} CarouselType;


@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, retain) NSArray *dataSource;

@property (nonatomic, assign) id<CarouselDelegate>delegate;


- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array withDistance:(CGFloat)distance;

- (void)setTimer:(NSTimeInterval)timeinterval;

@end
