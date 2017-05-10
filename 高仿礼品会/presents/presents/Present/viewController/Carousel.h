//
//  Carousel.h
//  豆瓣页面
//
//  Created by dllo on 15/11/14.
//  Copyright (c) 2015年 JEH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol carouselDelegate <NSObject>
- (void)passCarouselValues:(NSInteger)count;
@end
@interface Carousel : UIView <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) NSArray *title;
@property (nonatomic, assign) NSInteger number;
- (void)setArray:(NSArray *)array withTitArray:(NSArray *)title;
- (void)setTimer:(NSTimeInterval)timeinterval;
@property (nonatomic, assign) id<carouselDelegate>delegate;

@end
