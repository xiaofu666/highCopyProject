//
//  XHQZUIXINCilcel.m
//  AutoHome
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQZUIXINCilcel.h"
#import "XHQDaoGoDescViewController.h"

#import "XHQCilcelModel.h"

@interface XHQZUIXINCilcel()<UIScrollViewDelegate>


@property(nonatomic,strong)NSArray *dataSourc;

/**存储轮播图的对象数组*/

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,assign)NSInteger count;

@end
@implementation XHQZUIXINCilcel
- (instancetype)initWithFrame:(CGRect)frame andCircleArray:(NSArray *)array
{
    if(self = [super init])
    {

        _dataSourc = array;
        NSLog(@"💐%lu",(unsigned long)_dataSourc.count);
        self.frame = frame;
        [self creatScrollView];
        [self creatPageControl];
        
       
        [self creatTimer];
    }
    return self;
    
}


- (void)creatPageControl
{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,85,XHQ_SCRWIDTH, 10)];
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    self.pageControl.numberOfPages = 6;
   // self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self  addSubview:self.pageControl];
}
- (void)creatScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    
    for(NSInteger i = 0 ;i < 8;i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(XHQ_SCRWIDTH * i,0, XHQ_SCRWIDTH,  HEIGHTOFHEARD )];
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame),0) ;
        
        if(i == 0)
        {
            XHQCilcelModel *model = _dataSourc[i];
            NSString *image = model.image;

            
            [imageView sd_setImageWithURL:[NSURL URLWithString:image]placeholderImage:[UIImage imageNamed:@"welcome1"]];
        }else if( i == 7)
        {
            XHQCilcelModel *model = _dataSourc[i - 2];
            NSString *image = model.image;

            [imageView sd_setImageWithURL:[NSURL URLWithString:image]placeholderImage:[UIImage imageNamed:@"welcome1"]];
            
        }else{
            
            if(i > 0 && i < 7)
            {
                XHQCilcelModel *model = _dataSourc[i - 1];
                NSString *image = model.image;

             [imageView sd_setImageWithURL:[NSURL URLWithString:image]placeholderImage:[UIImage imageNamed:@"welcome1"]];
                
            }
        }
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTop:)];
        
        [imageView addGestureRecognizer:tap];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //设置初始偏移量
    self.scrollView.contentOffset = CGPointMake(0 , 0);
    
    [self addSubview:self.scrollView];
    
}
- (void)creatTimer
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollCirle) userInfo:nil repeats:YES];
}
- (void)scrollCirle
{
    static int i = 0;
    if(i == 7)
    {
        i = 0;
        [self.scrollView setContentOffset:CGPointMake(0,0) animated:NO];
        
    }
    [self.scrollView setContentOffset:CGPointMake(XHQ_SCRWIDTH * i, 0) animated:YES];
    i ++;
    
}
#pragma mark -- 滚动的代理方法 ---
//setContentOffSet:animated:YES; 动画滚动完成后回调
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //得到页码
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = page - 1;
    
    float Width = CGRectGetWidth(scrollView.frame);
    //如果到了最后一页，瞬间替换到第一页
    if(page == 7)
    {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
        
    }if(page == 0)
    {
        [scrollView setContentOffset:CGPointMake(Width * 7, 0) animated:NO];
        
    }
    
}

- (void)ActionTop:(UIGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 100;
    XHQCilcelModel *model = self.dataSourc[index];
    
    NSString *uri = model.topicUrl;
    if([self.deletage respondsToSelector:@selector(didSelectedLocalImage:)])
  {
        [self.deletage didSelectedLocalImage:uri];
    }
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com