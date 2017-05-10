//
//  ADheadView.m
//  风行电影
//
//  Created by 唐僧 on 15/10/26.
//  Copyright (c) 2015年 于延宇. All rights reserved.
//

#import "ADheadView.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "WRRecWebViewController.h"
#define WIDTH (float)(self.window.frame.size.width)
#define HEIGHT (float)(self.window.frame.size.height)
@implementation ADheadView
{
    NSTimer* _timer;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0, 0, 375, 300);
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    UIApplication* application=[UIApplication sharedApplication];
    AppDelegate* delegate=application.delegate;
    _scrollView=[[UIScrollView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:self.frame.size.width andHeight:self.frame.size.height-120]];
    _scrollView.delegate=self;
    //设置按页滚动
    _scrollView.pagingEnabled=YES;
    //隐藏滚动条
    _scrollView.userInteractionEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [self addSubview:_scrollView];
    
    //_pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-160, self.frame.size.width, 40)];
    _pageControl=[[UIPageControl alloc]initWithFrame:[delegate createFrimeWithX:0 andY:self.frame.size.height-160 andWidth:self.frame.size.width andHeight:40]];
    //_pageControl.backgroundColor=[UIColor blackColor];
    //设置透明度
    _pageControl.alpha= 0.5;
    _pageControl.currentPageIndicatorTintColor=[UIColor cyanColor];
    _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    _pageControl.userInteractionEnabled=NO;
    [self addSubview:_pageControl];
    
    NSArray* arrBtn=@[@"看锦囊",@"抢折扣"];
    for (int i=0; i<2; i++) {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=[delegate createFrimeWithX:0+(self.frame.size.width/2)*i andY:self.frame.size.height-120 andWidth:self.frame.size.width/2 andHeight:60];
        [btn setTitle:arrBtn[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
        btn.tag=10+i;
        [self addSubview:btn];
    }
    
    UILabel* label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:9 andY:self.frame.size.height-40 andWidth:self.frame.size.width-18 andHeight:40]];
    label.text=@"发现下一站";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1];
    label.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [self addSubview:label];
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(everTime) userInfo:nil repeats:YES];
    //self.backgroundColor=[UIColor yellowColor];
}

-(void)pressBtn:(id)sender{
    UIButton* btn=(UIButton* )sender;
    if ([self.delegate respondsToSelector:@selector(sendADheaderViewBtn:)]) {
        [self.delegate sendADheaderViewBtn:btn];
    }else{
        NSLog(@"被东方没有事项协议方法");
    }
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
}

//结束减速，滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=_scrollView.contentOffset.x/self.frame.size.width;
    if (index==5) {
        index=0;
        _scrollView.contentOffset=CGPointZero;
    }
    _pageControl.currentPage=index;
    _timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(everTime) userInfo:nil repeats:YES];
}

-(void)everTime{
    _scrollView.contentOffset=CGPointMake(_scrollView.contentOffset.x+self.frame.size.width, 0);
    NSInteger index=_scrollView.contentOffset.x/self.frame.size.width;
    if (index==5) {
        index=0;
        _scrollView.contentOffset=CGPointZero;
    }
    _pageControl.currentPage=index;
}









@end
