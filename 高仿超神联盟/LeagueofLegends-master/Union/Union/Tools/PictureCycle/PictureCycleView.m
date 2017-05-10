//
//  PictureCycleView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "PictureCycleView.h"

#import "PictureCycleScrollView.h"

#import "PictureCycleItem.h"

@interface PictureCycleView ()<UIScrollViewDelegate>


@property (nonatomic , retain ) UIPageControl *pageControl;


@property (nonatomic , retain ) PictureCycleScrollView *scrollView;


@property (nonatomic , retain ) PictureCycleItem *lastItem;//上一个

@property (nonatomic , retain ) PictureCycleItem *nowItem;//当前

@property (nonatomic , retain ) PictureCycleItem *nextItem;//下一个

@property (nonatomic , assign ) NSInteger nowIndex;//当前Item下标

@property (nonatomic, retain) NSTimer *timer;



@end

@implementation PictureCycleView

-(void)dealloc{
    
    [_pageControl release];
    
    [_scrollView release];
    
    [_lastItem release];
    
    [_nowItem release];
    
    [_nextItem release];
    
    [_timer release];
    
    [_dataArray release];
    
    [super dealloc];
    
}


//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
   
    if (self) {
        
        //初始化图片循环滑动视图并添加单击手势
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        
        _scrollView = [[PictureCycleScrollView alloc]init];
        
        _scrollView.delegate = self;
        
        _scrollView.pagingEnabled = YES;
        
        _scrollView.bounces = NO;// 是否反弹
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [_scrollView addGestureRecognizer:tap];
        
        [self addSubview:_scrollView];
        
        //初始化Item
        
        _lastItem = [[PictureCycleItem alloc]initWithFrame:CGRectZero];
        
        [_scrollView addSubview:_lastItem];
        
        _nowItem = [[PictureCycleItem alloc]initWithFrame:CGRectZero];
        
        [_scrollView addSubview:_nowItem];
        
        _nextItem = [[PictureCycleItem alloc]initWithFrame:CGRectZero];
        
        [_scrollView addSubview:_nextItem];
        
        
        //初始化页数控制
        
        _pageControl = [[UIPageControl alloc]init];
        
        [self addSubview:_pageControl];
   
    }
    
    return self;
    
}

//布局Frame

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    _lastItem.frame = CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    
    _nowItem.frame = CGRectMake(CGRectGetWidth(_scrollView.frame) , 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    
    _nextItem.frame = CGRectMake(CGRectGetWidth(_scrollView.frame) * 2 , 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 20 , CGRectGetWidth(self.frame), 20);
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * 3 , CGRectGetHeight(self.frame));
    
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);//默认偏移
    
}

//获取数据源数组

-(void)setDataArray:(NSMutableArray *)dataArray{
    
    if (_dataArray != dataArray) {
        
        [_dataArray release];
        
        _dataArray = [dataArray retain];
        
    }
    
    if (dataArray != nil) {
        
        //设置页数控制器页数
        
        _pageControl.numberOfPages = dataArray.count;
        
        //默认页数
        
        _pageControl.currentPage = 0;
        
        //默认下标
        
        self.nowIndex = 0;
        
    }

}


//获取时间间隔

-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    
    if (_timeInterval != timeInterval) {
        
        _timeInterval = timeInterval;
        
    }
    
    //延迟指定的秒数执行
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_timer != nil) {
            
            //清空计时器
            
            [_timer invalidate];
            
            [_timer release];
            
            _timer = nil;
            
        }
        
        //初始化计时器
        
        _timer = [[NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES] retain];
        
        //将定时器添加到运行循环中
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        [runLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
        
        //暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
        
        _timer.fireDate = [NSDate distantFuture];
        
        self.isPicturePlay = self.isPicturePlay;
        
        
    });

    
}

#pragma mark ---定时器事件

- (void)timerAction:(NSTimer *)timer{
    
    //滑动视图向左滑动
    
    CGPoint point = CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0);
    
    [_scrollView setContentOffset:point animated:YES];
    
}


-(void)setIsPicturePlay:(BOOL)isPicturePlay{
    
    if (_isPicturePlay != isPicturePlay) {
        
        _isPicturePlay = isPicturePlay;
        
    }
    
    //设置图片播放 (YES 播放 , NO 停止)
    
    if (isPicturePlay) {
        
        //继续图片播放
        
        //继续开启定时器
        
        [self.timer setFireDate:[NSDate date]];
        
    } else {
        
        //停止播放图片
        
        //暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
        
        self.timer.fireDate = [NSDate distantFuture];
        
    }
    
    
}

//设置当前Item下标

-(void)setNowIndex:(NSInteger)nowIndex{
    
    if (_nowIndex != nowIndex ) {
        
        _nowIndex = nowIndex;
        
    }
    
    //为Item添加数据模型
    
    _nowItem.model = [self.dataArray objectAtIndex:nowIndex];
    
    _lastItem.model = [self.dataArray objectAtIndex:[self getLastItemIndex]];
    
    _nextItem.model = [self.dataArray objectAtIndex:[self getNextItemIndex]];
    
    //设置页数控制器当前页数
    
    self.pageControl.currentPage = nowIndex;
    
}

//获取上一个下标

- (NSInteger)getLastItemIndex{
    
    NSInteger tempIndex = self.nowIndex;
    
    tempIndex--;
    
    if (tempIndex < 0 ) {
        
        tempIndex = self.dataArray.count - 1;
        
    }
    
    return tempIndex;
    
}

//获取下一个下标

- (NSInteger)getNextItemIndex{
    
    NSInteger tempIndex = self.nowIndex;
    
    tempIndex++;
    
    if (tempIndex > self.dataArray.count - 1 ) {
        
        tempIndex = 0;
        
    }
    
    return  tempIndex;
    
}

#pragma mark ---上一张

- (void)playLastItem{
    
    self.nowIndex = [self getLastItemIndex];
    
}

#pragma mark ---下一张

- (void)playNextItem{
   
    self.nowIndex = [self getNextItemIndex];
    
}

#pragma mark ---滑动视图滑动结束处理

- (void)scrollViewDidEndScrollingHandle{
    
    NSInteger page = self.scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame);
    
    //判断左滑动还是右滑动
    
    switch (page) {
        case 0:
            
            [self playLastItem];
            
            break;
            
        case 2:
            
            [self playNextItem];
            
            break;
            
        default:
            break;
    }
    
    
    //还原滑动视图偏移量
    
    CGPoint point = CGPointMake(self.scrollView.frame.size.width, 0);
    
    [_scrollView setContentOffset:point animated:NO];

    
}



#pragma mark ---UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    
}

//滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingHandle];
    
}

//当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingHandle];

}


#pragma mark ---点击事件

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    //调用选中图片Block 传递选中的图片信息
    
    self.selectedPictureBlock([self.dataArray objectAtIndex:self.nowIndex]);
    
}



@end
