//
//  XHQPictShowViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQPictShowViewController.h"

@interface XHQPictShowViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollerView;
@end

@implementation XHQPictShowViewController
- (void)viewDidLoad
{
    self.title = @"图片赏析";
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    [self showPict];
}
- (void)showPict
{
    _scrollerView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollerView.delegate = self;
   
    [self.view addSubview:_scrollerView];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_url]];
   // imageView.image = [UIImage imageNamed:@"welcome1"];
   [_scrollerView addSubview:imageView];
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.userInteractionEnabled = YES;
    // 1.设置放大和缩小比例
    _scrollerView.minimumZoomScale = 0.3;
    _scrollerView.maximumZoomScale = 30.0;
    
    // 2. 下面这个个属性必须设置成No
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.showsVerticalScrollIndicator = NO;
    
    
   // UIPinchGestureRecognizer *pinch = [UIPinchGestureRecognizer alloc]initWithTarget:<#(nullable id)#> action:<#(nullable SEL)#>
    
    NSLog(@"%@",imageView);
    

    
    
}
#pragma mark - 3.返回放大和缩小的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  [scrollView.subviews lastObject];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com