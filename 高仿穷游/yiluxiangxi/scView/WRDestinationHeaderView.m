//
//  WRDestinationHeaderView.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRDestinationHeaderView.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@implementation WRDestinationHeaderView
{
    UIScrollView* _scrollView;
    UIPageControl* _pageControl;
    NSTimer* _timer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    self=[super initWithFrame:frame];
    if (self) {
        self.frame = [delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:250];
        [self creatSubViews];
        
    }
    return self;
}

-(void)creatSubViews{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.delegate = self;
    //设置按页滚动
    _scrollView.pagingEnabled = YES;
    //隐藏滚动条
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.alpha = 0.5;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _pageControl=[[UIPageControl alloc]initWithFrame:[delegate createFrimeWithX:0 andY:667 - 40 andWidth:375 andHeight:40]];
    //_pageControl.backgroundColor=[UIColor blackColor];
    //设置透明度
    _pageControl.alpha= 0.5;
    _pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.userInteractionEnabled = NO;
//    [self addSubview:_pageControl];
    
    [self addTimer:_timer];
    
}
-(void)addTimer:(NSTimer* )timer{
    if (_timer) {
        [_timer invalidate];
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(everTime) userInfo:nil repeats:YES];
}
-(void)reloadDataWithArray:(NSArray* )array{
   

    _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width * array.count , _scrollView.frame.size.height);
    for (UIView* subView in _scrollView.subviews) {
        //移除所有的子视图
        [subView removeFromSuperview];
    }
    //添加新的显示图片
    int i=0;
    for (NSString* imagePath in array) {
       
        UIImageView* imageView=[[UIImageView alloc]init];
        //
        
        imageView.frame = CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        [imageView setImageWithURL:[NSURL URLWithString:imagePath]];
        [_scrollView addSubview:imageView];
        i++;
    }
    //设置_pageControl
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=[array count]-1;
}

-(void) dealloc
{
    _scrollView.delegate = nil;
    
    [_timer invalidate];
    
    [_scrollView removeFromSuperview];
    _scrollView = nil;
}

-(void) stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    _timer = nil;
}

//结束减速，滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=_scrollView.contentOffset.x/self.frame.size.width;
    if (index==self.imageArrCount-1) {
        index=0;
        _scrollView.contentOffset=CGPointZero;
    }
    _pageControl.currentPage=index;
    [self addTimer:_timer];
}

-(void)everTime{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+self.frame.size.width, 0) animated:YES];
    NSInteger index=_scrollView.contentOffset.x/self.frame.size.width;
    if (index==self.imageArrCount-1) {
        index=0;
        _scrollView.contentOffset=CGPointZero;
    }
    _pageControl.currentPage=index;
}
@end
