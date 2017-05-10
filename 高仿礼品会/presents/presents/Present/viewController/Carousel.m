//
//  Carousel.m
//  豆瓣页面
//
//  Created by dllo on 15/11/14.
//  Copyright (c) 2015年 JEH. All rights reserved.
//

#import "Carousel.h"
#import "UIImageView+WebCache.h"


@implementation Carousel

#pragma maek - rewriteInit
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

       

        [self creatScrollView];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

    }
    return self;
}

#pragma maek - creatScrollView
- (void)creatScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

#pragma mark - setArray
- (void)setArray:(NSArray *)array withTitArray:(NSArray *)title {
    
    [self creatScrollView];
    NSInteger width = _scrollView.frame.size.width;
    NSInteger height = _scrollView.frame.size.height;
    _count = array.count;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 30, width, 30)];
    backView.backgroundColor = [UIColor clearColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    self.title = [NSArray arrayWithArray:title];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height - 30, width - 20, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
//    _titleLabel.text = title[0];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    for (int i = 0; i < _count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * (i + 1), 0, width, height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@"lunbozhanwei"]];

//        imageView.image = [UIImage imageNamed:array[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = i + 200;
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    if ([[array lastObject] isKindOfClass:[NSString class]]) {
        UIImageView *imageViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [imageViewLeft sd_setImageWithURL:[NSURL URLWithString:array[array.count - 1]]];
//        imageViewLeft.image = [UIImage imageNamed:array[array.count - 1]];
        imageViewLeft.contentMode = UIViewContentModeScaleAspectFill;
        imageViewLeft.clipsToBounds = YES;
        [_scrollView addSubview:imageViewLeft];
    }
    if ([[array firstObject] isKindOfClass:[NSString class]]) {
        UIImageView *imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width * (array.count + 1), 0, width, height)];
        [imageViewRight sd_setImageWithURL:[NSURL URLWithString:array[0]]];
//        imageViewRight.image = [UIImage imageNamed:array[0]];
        imageViewRight.contentMode = UIViewContentModeScaleAspectFill;
        imageViewRight.clipsToBounds = YES;
        [_scrollView addSubview:imageViewRight];
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * (_count + 2), 0);
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((width - 90) / 2, height - 30, 90, 30)];
    _pageControl.numberOfPages = _count;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _scrollView.userInteractionEnabled = YES;
    
 
    
    CGSize pointSize = [_pageControl sizeForNumberOfPages:_count];
    CGFloat page_x = -(_pageControl.bounds.size.width - pointSize.width) / 2 ;
    [_pageControl setBounds:CGRectMake(page_x, _pageControl.bounds.origin.y, _pageControl.bounds.size.width, _pageControl.bounds.size.height)];
    
    [self addSubview:_pageControl];
    
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

#pragma mark - carousel
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_scrollView.contentOffset.x == _scrollView.frame.size.width * (_count + 1)) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    } else if (_scrollView.contentOffset.x == 0) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * _count, 0)];
    }
    _pageControl.currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width - 1;

//    self.titleLabel.text = [self.title objectAtIndex:_pageControl.currentPage];
}

#pragma mark - autoCarousel



- (void)timerAction {
    _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + _scrollView.frame.size.width, 0);
    if (_scrollView.contentOffset.x > _scrollView.frame.size.width * _count) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO];
    }
    
    _pageControl.currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width - 1;
//    self.titleLabel.text = [self.title objectAtIndex:_pageControl.currentPage];
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    _number = tap.view.tag - 200;
    [self.delegate passCarouselValues:_number];
}

@end





















