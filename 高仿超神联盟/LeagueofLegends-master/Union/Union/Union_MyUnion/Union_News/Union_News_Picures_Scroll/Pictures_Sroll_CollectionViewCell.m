//
//  Pictures_Sroll_CollectionViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Pictures_Sroll_CollectionViewCell.h"

#import <UIImageView+WebCache.h>

#import <UAProgressView/UAProgressView.h>

#import <MBProgressHUD.h>



@interface Pictures_Sroll_CollectionViewCell ()<MBProgressHUDDelegate>

//@property (nonatomic , retain ) UAProgressView *progressView;

@property (nonatomic , retain ) MBProgressHUD *HUD;//HUD提示框

@property (nonatomic , retain ) MBRoundProgressView *roundProgressView;//进度条视图

@end

@implementation Pictures_Sroll_CollectionViewCell

- (void)dealloc{
    
    [_imageView release];
    
    [_titleLable release];
    
    [_scrollView release];
    
    [_model release];
    
    [_HUD release];
    
    [_roundProgressView release];
    
    [super dealloc];
}





- (instancetype)initWithFrame:(CGRect)frame{
    
    if ( self = [super initWithFrame:frame]) {
        
        //初始化滑动视图
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        _scrollView.maximumZoomScale = 3;
        
        _scrollView.minimumZoomScale = 1;
        
        _scrollView.zoomScale = 1;
        
        _scrollView.delegate = self;
        
        [self.contentView addSubview:_scrollView];
        
        //初始化图片视图
        
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapAction:)];
        
        imageTap.numberOfTapsRequired = 2;
        
        imageTap.numberOfTouchesRequired = 1;
        
        _imageView = [[UIImageView alloc]init];
        
        _imageView.userInteractionEnabled = YES;
        
        [_imageView addGestureRecognizer:imageTap];
        
        [_scrollView addSubview:_imageView];
    
        
        //初始化圆形进度条视图
        
        _roundProgressView = [[MBRoundProgressView alloc]initWithFrame:CGRectMake(0, 0, 64 , 64 )];
        
        //初始化HUD提示框视图
        
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        
        [self addSubview:_HUD];
        
//        _HUD.mode = MBProgressHUDModeDeterminate;
        
        _HUD.mode = MBProgressHUDModeCustomView;//设置自定义视图模式
        
        _HUD.delegate = self;
        
        _HUD.color = [UIColor clearColor];
        
        _HUD.customView = _roundProgressView;

        
        /*
        
        //初始化进度视图
        
        _progressView = [[UAProgressView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
        
        _progressView.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , CGRectGetHeight(self.frame) / 2 );
        
//        _progressView.tintColor = [UIColor colorWithRed:5/255.0 green:204/255.0 blue:197/255.0 alpha:1.0];
        
        _progressView.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f];
        
        _progressView.borderWidth = 0.0;
        
        _progressView.lineWidth = 10.0;
        
        _progressView.fillOnTouch = YES;
        
        [self addSubview:_progressView];
        
        //初始化进度条百分比Label
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_progressView.frame) , 32.0)];
       
        textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:22];
        
        textLabel.textAlignment = NSTextAlignmentCenter;
        
        textLabel.textColor = self.progressView.tintColor;
        
        textLabel.backgroundColor = [UIColor clearColor];
        
        textLabel.hidden = YES;
        
        _progressView.centralView = textLabel;
        
        //填充改变Block 设置百分比文字颜色变化动画
        
        _progressView.fillChangedBlock = ^(UAProgressView *progressView, BOOL filled, BOOL animated){
           
            UIColor *color = (filled ? [UIColor whiteColor] : progressView.tintColor);
            
            if (animated) {
            
                [UIView animateWithDuration:0.3 animations:^{
                 
                    [(UILabel *)progressView.centralView setTextColor:color];
                
                }];
            
            } else {
            
                [(UILabel *)progressView.centralView setTextColor:color];
            
            }
        
        };
        
        //进度视图进度改变Block  修改百分比Label内容
        
        _progressView.progressChangedBlock = ^(UAProgressView *progressView, float progress){
            
            [(UILabel *)progressView.centralView setText:[NSString stringWithFormat:@"%2.0f%%", progress * 100]];
       
        };
        
        
        //进度视图被点击Block
        
        _progressView.didSelectBlock = ^(UAProgressView *progressView){
            
            
        };
        
        //进度视图初始进度
        
        _progressView.progress = 0;
         
         */
        
    }
    
    return self;
    
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    //提示框隐藏时 删除提示框视图
    
//    [hud removeFromSuperview];
//    
//    [hud release];
//    
//    hud = nil;
    
}

#pragma mark ---图片双击事件

- (void)imageTapAction:(UITapGestureRecognizer *)tap{
    
    //还原缩放比例
    
    _scrollView.zoomScale = 1;
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
}

//当scrollView正在缩放的时候会频繁响应的方法

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{

    //x和y轴的增量:
    
    //当scrollView自身的宽度或者高度大于其contentSize的时候, 增量为:自身宽度或者高度减去contentSize宽度或者高度除以2,或者为0
    
    //条件运算符
    
    CGFloat delta_x= scrollView.bounds.size.width > scrollView.contentSize.width ? (scrollView.bounds.size.width-scrollView.contentSize.width)/2 : 0;
  
    CGFloat delta_y= scrollView.bounds.size.height > scrollView.contentSize.height ? (scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0;
    
    //让imageView一直居中
    
    //实时修改imageView的center属性 保持其居中

    self.imageView.center=CGPointMake(scrollView.contentSize.width/2 + delta_x, scrollView.contentSize.height/2 + delta_y);

}


- (void)setModel:(Pictures_Sreoll_Model *)model{
    
    if ( _model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        
    }
    
    _scrollView.zoomScale = 1;
    
    _titleLable.text = _model.title;
    
    //加载图片
    
    NSURL *url = [NSURL URLWithString:model.url];
    
    [_roundProgressView setProgress:0.0f];
    
    [_HUD show:YES];
    
    __block typeof(self) Self = self;
    
    [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        float progressFloat = (float)receivedSize/(float)expectedSize;
        
        [Self.roundProgressView setProgress:progressFloat];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [Self.HUD hide:NO];
        
    }];

    
    
    /*
    
    //显示进度视图 并进度清0
    
    self.progressView.hidden = NO;
    
    self.progressView.progress = 0;
    
    __block typeof(self) Self = self;
    
    [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        float progressFloat = (float)receivedSize/(float)expectedSize;
        
        [Self.progressView setProgress: progressFloat animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        Self.progressView.hidden = YES;
        
    }];

    */
    
    CGFloat width =  [_model.fileWidth floatValue];
    
    CGFloat height = [_model.fileHeight floatValue];
    
    self.imageView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.width/(width/height));
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
    
    self.imageView.center = CGPointMake(CGRectGetWidth(_scrollView.frame) / 2 , CGRectGetHeight(_scrollView.frame) / 2 );
    
}


@end
