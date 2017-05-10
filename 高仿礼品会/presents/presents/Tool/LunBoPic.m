//
//  LunBoPic.m
//  presents
//
//  Created by dllo on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "LunBoPic.h"
#import <UIImageView+WebCache.h>

@implementation LunBoPic

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

//重写初始化
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array withDistance:(CGFloat)distance
{
    self = [super initWithFrame:frame];
    if (self) {
        _array = [[NSMutableArray alloc] initWithArray:array];
        _distance = distance;
        
        [self addSubview:self.scrollView];
        
        [self loadPicture];
        
        [self addSubview:self.pageControl];
        
    }
    return self;
}
//加载图片
- (void)loadPicture {
    
    
    
    if (self.array.count) {
        [self.array insertObject:[self.array lastObject] atIndex:0];
        [self.array addObject:self.array[1]];
        for (int i = 0; i < self.array.count; i++) {
            if ([self.array[i] isKindOfClass:[NSString class]]) {
                UIImageView *imageViews = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
                [imageViews sd_setImageWithURL:[NSURL URLWithString:self.array[i]]];
                imageViews.contentMode = UIViewContentModeScaleAspectFill;
                imageViews.clipsToBounds = YES;
                imageViews.layer.cornerRadius = 5;
                [self.scrollView addSubview:imageViews];
                
            }
        }
        _count = self.array.count;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        [self.scrollView addGestureRecognizer:tap];
        
        self.scrollView.contentSize = CGSizeMake(WIDTH * _count, 0);
    }
    
    //    [self.delegate getValue];
    
}
#pragma mark -------- 手势的点击方式

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    
    
    //    [self.delegate changeVC:self.dataSource[self.pageControl.currentPage]];
    
    
    
}

//pageControl方法
- (void)changePageByPageControl:(UIPageControl *)sender {
    self.scrollView.contentOffset = CGPointMake(WIDTH * (sender.currentPage + 1), 0);
}
//实现轮播
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == WIDTH * (_count - 1)) {
        
        
        self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    } else if (scrollView.contentOffset.x == 0) {
        
        ;
        
        self.scrollView.contentOffset = CGPointMake(WIDTH * (_count - 2), 0);
    }
    //    根据图片改currentPage
    self.pageControl.currentPage = self.scrollView.contentOffset.x / WIDTH - 1;
    
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //    //    添加自定义翻页动画
    //    CATransition *animation = [CATransition animation];
    //    //    设置动画执行时间
    //    animation.duration = 1;
    //    //    设置动画类型
    //    [animation setType:@"rotate"];
    //    //    动画开始方向
    //    animation.subtype = kCATransitionFromRight;
    //    [scrollView.layer addAnimation:animation forKey:nil];
    
}

//自动播放
- (void)setTimer:(NSTimeInterval)timeinterval {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeinterval target:self selector:@selector(timerCarousel) userInfo:nil repeats:YES];
    
    [timer fire];
}
//自动播放方法
- (void)timerCarousel {
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + WIDTH, 0);
    if (self.scrollView.contentOffset.x > WIDTH * (_count - 2)) {
        //    添加自定义翻页动画
        CATransition *animation = [CATransition animation];
        //    设置动画执行时间
        animation.duration = 1;
        //    设置动画类型
        [animation setType:@"cube"];
        //    动画开始方向
        animation.subtype = kCATransitionFromRight;
        [self.scrollView.layer addAnimation:animation forKey:nil];
        
        self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }
    
    //    添加自定义翻页动画
    CATransition *animation = [CATransition animation];
    //    设置动画执行时间
    animation.duration = 1;
    //    设置动画类型
    [animation setType:@"cube"];
    //    动画开始方向
    animation.subtype = kCATransitionFromRight;
    [self.scrollView.layer addAnimation:animation forKey:nil];
    
    self.pageControl.currentPage = self.scrollView.contentOffset.x / WIDTH - 1;
}

#pragma mark - private
//scrollView懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        //    设置代理人
        _scrollView.delegate = self;
        //    设置整页偏移
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
        
        
        
        
    }
    return _scrollView;
}
//pageControl懒加载
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT - _distance, WIDTH, 20)];
        _pageControl.numberOfPages = _count - 2;
        [_pageControl addTarget:self action:@selector(changePageByPageControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}


#pragma mark 处理枚举类型数据: 转换为字符串
- (NSString *)carouseAnimationType:(CarouselType)carouseType
{
    NSString *type = nil;
    switch (carouseType) {
        case defaults:
            type = nil;
            break;
        case cube:
            type = @"cube";
            break;
        case moveIn:
            type = @"moveIn";
            break;
        case reveal:
            type = @"reveal";
            break;
        case fade:
            type = @"fade";
            break;
        case pageCurl:
            type = @"pageCurl";
            break;
        case pageUnCurl:
            type = @"pageUnCurl";
            break;
        case suckEffect:
            type = @"suckEffect";
            break;
        case rippleEffect:
            type = @"rippleEffect";
            break;
        case oglFlip:
            type = @"oglFlip";
            break;
        case rotate:
            type = @"rotate";
            break;
        case push:
            type = @"push";
            break;
        case cameraIrisHollowOpen:
            type = @"cameraIrisHollowOpen";
            break;
        case cameraIrisHollowClose:
            type = @"cameraIrisHollowClose";
            break;
        default:
            type = nil;
            break;
    }
    return type;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
