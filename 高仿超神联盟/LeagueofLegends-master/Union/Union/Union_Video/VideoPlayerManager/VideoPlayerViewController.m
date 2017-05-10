//
//  VideoPlayerViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "VideoPlayerViewController.h"

#import "VideoDetailsModel.h"

#import <MediaPlayer/MediaPlayer.h>

#import "PCH.h"

#import "LoadingView.h"

#import "SettingManager.h"

#import <AVKit/AVKit.h>


@interface VideoPlayerViewController ()<UIGestureRecognizerDelegate>

//视频播放控制器

@property (nonatomic , retain ) MPMoviePlayerController *moviePlayer;

//计时器

@property (nonatomic , retain ) NSTimer *timer;

//加载视图

@property (nonatomic , retain ) LoadingView *loadingView;

//----自定义控制器视图----

@property (nonatomic , retain ) UIView *topView;//顶部控制视图

@property (nonatomic , retain ) UIView *bottomView;//底部控制视图

@property (nonatomic , retain ) UIButton *topBackButton;//顶部返回按钮

@property (nonatomic , retain ) UILabel *topTitleLabel;//顶部标题Label

@property (nonatomic , retain ) UIButton *topDefinitionButton;//顶部清晰度切换按钮

@property (nonatomic , retain ) UIView *topDefinitionListView;//顶部清晰度列表视图

@property (nonatomic , retain ) UIButton *playButton;//播放按钮

@property (nonatomic , retain ) UISlider *slider;//播放进度条滑块

@property (nonatomic , retain ) UIProgressView *progressView;//缓冲进度条视图

@property (nonatomic , retain ) UILabel *playTimeLabel;//播放时间Label

@property (nonatomic , retain ) UILabel *videoDurationLabel;//视频时长Label


@property (nonatomic , retain ) UIView *volumeView;//音量视图

@property (nonatomic , retain ) UISlider *volumeSlider;//侧边音量滑块

@property (nonatomic , retain ) UISlider* systemvolumeViewSlider;//系统音量滑块

@property (nonatomic , retain ) UIImageView *volumeImageView;//音量图标



@property (nonatomic , retain ) UIView *promptView;//缩进快进提示视图

@property (nonatomic , retain ) UILabel *promptValueLabel;//提示滑动的值

@property (nonatomic , retain ) UILabel *promptTimeLabel;//提示时间Label


//----数据-----

@property (nonatomic ,assign ) CGPoint startPoint;//触摸起始点

@property (nonatomic ,assign ) CGPoint endPoint;//触摸结束点

@property (nonatomic ,assign ) NSInteger changeTime;//改变的时间

@property (nonatomic ,assign ) CGFloat nowPlayTime;//当前播放时间

@property (nonatomic ,assign ) NSInteger moveDirection;//触摸移动方向 0为未移动 1为左右移动 2为上下移动

@property (nonatomic , assign ) NSInteger definitionIndex;//视频清晰度下标



@property (nonatomic , assign ) BOOL isDismiss;//是否退出 YES为以退出 NO为未退出正在显示

@end

@implementation VideoPlayerViewController

-(void)dealloc{
    
    [_timer release];
    
    //移除所有通知监控
   
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    
    [super dealloc];
    
}

#pragma mark ---加载顶部控制视图

-(void)loadTopView{
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(self.view.frame), 64)];
    
    _topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    [self.view addSubview:_topView];
    
    //初始化返回按钮
    
    _topBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _topBackButton.backgroundColor = [UIColor clearColor];
    
    _topBackButton.tintColor = [UIColor whiteColor];
    
    [_topBackButton setImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    _topBackButton.frame = CGRectMake(0, 20, 60, 44);
    
    [_topBackButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView addSubview:_topBackButton];
    
    //初始化清晰度按钮
    
    _topDefinitionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _topDefinitionButton.frame = CGRectMake(CGRectGetWidth(_topView.frame) - 70, 27, 60, 30);
    
    _topDefinitionButton.layer.borderWidth = 1.0f;
    
    _topDefinitionButton.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:0.7] CGColor];
    
    _topDefinitionButton.layer.cornerRadius = 5.0f;
    
    [_topDefinitionButton addTarget:self action:@selector(DefinitionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _topDefinitionButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [_topDefinitionButton setTitle:@"标清" forState:UIControlStateNormal];
    
    [_topDefinitionButton setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    
    
    [_topView addSubview:_topDefinitionButton];
    
    //初始化清晰度列表视图
    
    _topDefinitionListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 150)];
    
    _topDefinitionListView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
    
    _topDefinitionListView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    
    _topDefinitionListView.hidden = YES;//默认隐藏
    
    _topDefinitionListView.alpha = 0;//默认隐藏
    
    [self.view addSubview:_topDefinitionListView];
    
    //初始化清晰度列表选项button
    
    UIButton *BDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    BDButton.frame = CGRectMake(0 , 10, CGRectGetWidth(_topDefinitionListView.frame), 40);
    
    BDButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    
    [BDButton setTitle:@"标清" forState:UIControlStateNormal];
    
    [BDButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [BDButton addTarget:self action:@selector(BDButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topDefinitionListView addSubview:BDButton];
    
    UIButton *HDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    HDButton.frame = CGRectMake(0 , 60, CGRectGetWidth(_topDefinitionListView.frame), 40);
    
    HDButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    
    [HDButton setTitle:@"高清" forState:UIControlStateNormal];
    
    [HDButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [HDButton addTarget:self action:@selector(HDButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topDefinitionListView addSubview:HDButton];
    
    UIButton *FHDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    FHDButton.frame = CGRectMake(0 , 110, CGRectGetWidth(_topDefinitionListView.frame), 40);
    
    FHDButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    
    [FHDButton setTitle:@"超清" forState:UIControlStateNormal];
    
    [FHDButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [FHDButton addTarget:self action:@selector(FHDButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topDefinitionListView addSubview:FHDButton];
    
    
    //初始标题
    
    _topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65 , 20 , CGRectGetWidth(_topView.frame) - 135 , 44)];
    
    _topTitleLabel.textColor = [UIColor whiteColor];
    
    _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _topTitleLabel.font = [UIFont systemFontOfSize:16];
    
    [_topView addSubview:_topTitleLabel];
    
    
}

#pragma mark ---加载底部控制视图

-(void)loadBottomView{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 60, CGRectGetWidth(self.view.frame), 60)];
    
    _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    [self.view addSubview:_bottomView];
    
    //初始化播放按钮
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _playButton.backgroundColor = [UIColor clearColor];
    
    _playButton.tintColor = [UIColor whiteColor];
    
    [_playButton setImage:[[UIImage imageNamed:@"iconfont-zanting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [_playButton setImage:[[UIImage imageNamed:@"iconfont-bofang"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
    
    _playButton.frame = CGRectMake( 5 , 5, 50, 50 );
    
    [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView addSubview:_playButton];
    
    //初始化缓冲进度条视图
    
    _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];

    _progressView.frame = CGRectMake(70 , 29 , CGRectGetWidth(self.view.frame) - 100 , 10);
    
    _progressView.trackTintColor = [UIColor blackColor];//设置进度条颜色
    
    _progressView.progressTintColor = [UIColor lightGrayColor];//设置进度条上进度的颜色
    
    _progressView.userInteractionEnabled = NO;
    
    [_bottomView addSubview:_progressView];
    
    //初始化播放进度滑块视图
    
    _slider = [[UISlider alloc]initWithFrame: CGRectMake(68 , 15 , CGRectGetWidth(self.view.frame) - 96 , 30)];
    
    _slider.minimumTrackTintColor = MAINCOLOER;
    
    _slider.maximumTrackTintColor = [UIColor clearColor];
    
    _slider.tintColor = [UIColor whiteColor];
    
    _slider.minimumValue = 0.0f;
    
    [_slider setThumbImage:[[UIImage imageNamed:@"iconfont-dian"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [_slider addTarget:self action:@selector(SliderAction:) forControlEvents:UIControlEventValueChanged];
    
    [_bottomView addSubview:_slider];
    
    //初始化播放时间
    
    _playTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 150 , 30 , 60 , 30)];
    
    _playTimeLabel.text = @"00:00:00";
    
    _playTimeLabel.textColor = [UIColor whiteColor];
    
    _playTimeLabel.textAlignment = NSTextAlignmentRight;
    
    _playTimeLabel.font = [UIFont systemFontOfSize:12];
    
    [_bottomView addSubview:_playTimeLabel];
    
    //初始化视频时长
    
    _videoDurationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 90 , 30 , 70 , 30)];
    
    _videoDurationLabel.text = @" - 00:00:00";
    
    _videoDurationLabel.textColor = [UIColor whiteColor];
    
    _videoDurationLabel.textAlignment = NSTextAlignmentLeft;
    
    _videoDurationLabel.font = [UIFont systemFontOfSize:12];
    
    [_bottomView addSubview:_videoDurationLabel];
    
    

    
    
    
}

#pragma mark ---加载侧边音量控制视图

-(void)loadVolumeView{
    
    _volumeView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 40 , 0, 40, 160)];
    
    _volumeView.center = CGPointMake(_volumeView.center.x, CGRectGetHeight(self.view.frame) / 2) ;
    
    _volumeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];

    [self.view addSubview:_volumeView];
    
    //初始化音量控制滑块视图
    
    _volumeSlider = [[UISlider alloc]initWithFrame: CGRectMake(0 - 40, 60, 120, 20)];
    
    _volumeSlider.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
    
    _volumeSlider.minimumTrackTintColor = MAINCOLOER;
    
    _volumeSlider.maximumTrackTintColor = [UIColor lightGrayColor];
    
    _volumeSlider.tintColor = [UIColor whiteColor];
    
    _volumeSlider.maximumValue = 1.0f;
    
    _volumeSlider.minimumValue = 0.0f;

    
    [_volumeSlider setThumbImage:[[UIImage imageNamed:@"iconfont-dian"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [_volumeSlider addTarget:self action:@selector(VolumeSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    [_volumeView addSubview:_volumeSlider];
    
    //初始化音量图标
    
    _volumeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 135, 20, 20)];
    
    _volumeImageView.tintColor = [UIColor whiteColor];
    
    _volumeImageView.image = [[UIImage imageNamed:@"iconfont-yinliangxiao"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [_volumeView addSubview:_volumeImageView];
    
    //获取系统音量
    
    MPVolumeView *systemVolumeView = [MPVolumeView new];
    
    systemVolumeView.center = CGPointMake(-1000, -1000);
    
    systemVolumeView.hidden = NO;
    
    for (UIView *view in [systemVolumeView subviews]){
    
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            
            _systemvolumeViewSlider = (UISlider*)view;
        
            break;
        }
    }
    
    //同步系统音量
    
    _volumeSlider.value = _systemvolumeViewSlider.value;
    
}

#pragma mark ---加载提示视图

-(void)loadPromptView{
    
    //初始化提示视图
    
    _promptView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 180)];
    
    _promptView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
    
    _promptView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    _promptView.layer.cornerRadius = 8;
    
    _promptView.hidden = YES;//默认隐藏
    
    [self.view addSubview:_promptView];
    
    //初始化滑动值
    
    _promptValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 , 50, CGRectGetWidth(_promptView.frame), 60)];
    
    _promptValueLabel.text = @"+00:00:15";
    
    _promptValueLabel.textAlignment = NSTextAlignmentCenter;
    
    _promptValueLabel.textColor = [UIColor whiteColor];
    
    _promptValueLabel.font = [UIFont boldSystemFontOfSize:40];
    
    [_promptView addSubview:_promptValueLabel];
    
    
    //初始化播放时间
    
    _promptTimeLabel = [[UILabel alloc]initWithFrame: CGRectMake(0, CGRectGetHeight(_promptView.frame) - 50, CGRectGetWidth(_promptView.frame) , 40)];
    
    _promptTimeLabel.textColor = [UIColor lightGrayColor];
    
    _promptTimeLabel.text = @"00:00:00/00:05:30";
    
    _promptTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    [_promptView addSubview:_promptTimeLabel];
    
    
    
}

#pragma mark ---设置所有视图控件布局

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    //顶部控制视图布局
    
    _topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.topView.frame));
    
    _topBackButton.frame = CGRectMake(0, 20, 60, 44);
    
    _topDefinitionButton.frame = CGRectMake(CGRectGetWidth(_topView.frame) - 80, 27, 60, 30);
    
    _topDefinitionListView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
    
    _topTitleLabel.frame = CGRectMake(65 , 20 , CGRectGetWidth(_topView.frame) - 150 , 44);
    
    //底部控制视图布局
    
    _bottomView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 60, CGRectGetWidth(self.view.frame), 60);
    
    _playButton.frame = CGRectMake( 5 , 5, 50, 50 );
    
    _progressView.frame = CGRectMake(70 , 29 , CGRectGetWidth(self.view.frame) - 100 , 10);
    
    _slider.frame = CGRectMake(68 , 15 , CGRectGetWidth(self.view.frame) - 96 , 30);
    
    _playTimeLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 150 , 30 , 60 , 30);
    
    _videoDurationLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 90 , 30 , 70 , 30);
    
    //音量控制视图布局
    
    _volumeView.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 40 , 0, 40, 160);
    
    _volumeView.center = CGPointMake(_volumeView.center.x, CGRectGetHeight(self.view.frame) / 2) ;
    
    _volumeImageView.frame = CGRectMake(10, 135, 20, 20);
    
    //加载提示视图布局
    
    _promptView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
    
    //加载视图布局
    
    _loadingView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //旋转视图
    
//    self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    //设置播放器属性
    
    self.moviePlayer.controlStyle = MPMovieControlStyleNone; //无控制面板样式

    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;//固定缩放比例并且尽量全部展示视频，不会裁切视频
    
//    self.moviePlayer.repeatMode = MPMovieRepeatModeOne;//重复播放
    
    //默认清晰度下标
    
    _definitionIndex = 0;

    
    //点击手势
    
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    
    Tap.delegate = self;
    
    [self.moviePlayer.view addGestureRecognizer:Tap];
    
    //双击手势
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    
    doubleTap.numberOfTapsRequired = 2;
    
    [self.moviePlayer.view addGestureRecognizer:doubleTap];
    
    //长按手势
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(HandleLongPress:)];
    
    longPress.minimumPressDuration=2;//最小时间
    
    [self.moviePlayer.view addGestureRecognizer:longPress];
    
    
    //添加通知
    
    [self addNotification];
    
    //加载顶部控制视图
    
    [self loadTopView];
    
    //加载底部控制视图
    
    [self loadBottomView];
    
    //加载侧边音量控制视图
    
    [self loadVolumeView];
    
    //加载提示视图
    
    [self loadPromptView];
    
    //初始化加载视图
    
    _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    _loadingView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , CGRectGetHeight(self.view.frame) / 2);
    
    _loadingView.loadingColor = [UIColor whiteColor];
    
    _loadingView.hidden = YES;//默认隐藏
    
    [self.view addSubview:_loadingView];
    
    
}





#pragma mark ---返回按钮响应事件

- (void)backButtonAction:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark ---清晰度按钮响应事件

- (void)DefinitionButtonAction:(UIButton *)sender{
    
    //设置视频清晰度下标
    
    if (_topDefinitionListView.hidden) {
        
        //清晰度按钮字体颜色设置为白色
        
        [_topDefinitionButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        
        //设置当前清晰度选项按钮字体为白色 其他为灰色
        
        for (int i = 0 ; i < self.videoArray.count; i++) {
            
            if (_definitionIndex == i) {
                
                [_topDefinitionListView.subviews[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            } else {
                
                [_topDefinitionListView.subviews[i] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                
            }
            
        }
        
        
        
        _topDefinitionListView.hidden = NO;
        
        [UIView animateWithDuration:0.3f animations:^{
        
            //显示清晰度列表视图
        
            _topDefinitionListView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
    
        
    } else {
        
        //清晰度按钮字体颜色设置为灰色
        
        [_topDefinitionButton setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.3f animations:^{
            
            //隐藏清晰度列表视图
            
            _topDefinitionListView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            _topDefinitionListView.hidden = YES;
            
        }];
        
    }

}

#pragma mark ---标清按钮事件

- (void)BDButtonAction:(UIButton *)sender{
    
    //设置清晰度选项下标
    
    self.definitionIndex = 0;
    
    
}

#pragma mark ---高清按钮事件

- (void)HDButtonAction:(UIButton *)sender{
    
    //设置清晰度选项下标
    
    self.definitionIndex = 1;

    
}

#pragma mark ---超清按钮事件

- (void)FHDButtonAction:(UIButton *)sender{
    
    //设置清晰度选项下标
    
    self.definitionIndex = 2;

    
}



#pragma mark ---播放按钮响应事件

- (void)playButtonAction:(UIButton *)sender{
    
    if (sender.selected) {
        
        //播放视频
        
        [self.moviePlayer play];
        
        
    } else {
        
        //暂停视频
        
        [self.moviePlayer pause];
        
    }
    
}

#pragma mark ---滑块视图响应事件

#pragma mark ---播放进度滑块事件

- (void)SliderAction:(UISlider *)slider{
    
    
    //设置播放进度
    
    [self.moviePlayer setCurrentPlaybackTime:slider.value];
    
    
}

#pragma mark ---音量大小

- (void)VolumeSliderAction:(UISlider *)slider{
    
    //设置对应的音量图标
    
    if (slider.value == 0) {
        
        _volumeImageView.image = [[UIImage imageNamed:@"iconfont-yinliangjingyin"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
    } else if (slider.value >= 0.8) {
        
        _volumeImageView.image = [[UIImage imageNamed:@"iconfont-yinliangda"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
    } else {
        
        _volumeImageView.image = [[UIImage imageNamed:@"iconfont-yinliangxiao"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
    }
    
    //设置系统音量
    
    [_systemvolumeViewSlider setValue:slider.value animated:YES];
    
    
}


#pragma mark ---开始触摸事件

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view bringSubviewToFront:_promptView];
    
    //得到触摸点
    
    UITouch *startTouch = [touches anyObject];
    
    //返回触摸点坐标
    
    self.startPoint = [startTouch locationInView:self.view];
    
    //初始化结束坐标
    
    self.endPoint = self.startPoint;
    
    //滑动方向初始化
    
    self.moveDirection = 0;
    
}

#pragma mark ---拖动事件

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
    
    UITouch *endTouch = [touches anyObject];
    
    //返回触摸点坐标
    
    self.endPoint = [endTouch locationInView:self.view];

    
    //左右滑动
    
    if (self.moveDirection == 1 || self.moveDirection == 0) {
        
        //左右滑动判定
        
        if ( self.startPoint.x - self.endPoint.x > 10 || self.startPoint.x - self.endPoint.x < - 10 ) {
            
            //设置移动方向为左右移动
            
            self.moveDirection = 1;
            
        }
        
        //允许左右滑动
        
        if (self.moveDirection == 1) {
            
            //显示提示视图
            
            _promptView.hidden = NO;
            
            if (self.startPoint.x < self.endPoint.x ) {
                
                //右滑动
                
                //更改的时间计数+速度差
                
                self.changeTime += 2;
                
            } else if (self.startPoint.x > self.endPoint.x ) {
                
                //左滑动
                
                //更改的时间计数+速度差
                
                self.changeTime -= 2;
                
            }
            
            //为提示值添加数据
            
            self.promptValueLabel.text = [NSString stringWithFormat:@"%@%@" , self.changeTime > 0 ? @"+" : @"-" , [self getStringWithTime:self.changeTime] ];
            
        }
        
        
    }
    
//--------------------------------------------
    
    //上下滑动
    
    if (self.moveDirection == 2 || self.moveDirection == 0) {
        
        //上下滑动判定
        
        if ( self.startPoint.y - self.endPoint.y > 10 || self.startPoint.y - self.endPoint.y < - 10 ) {
            
            //设置移动方向为上下移动
            
            self.moveDirection = 2;
        }
        
        //允许上下滑动
        
        if (self.moveDirection == 2) {
            
            if (self.startPoint.y > self.endPoint.y ) {
                
                //上滑动
                
                _volumeSlider.value += 0.02;
                
                
            } else if (self.startPoint.y < self.endPoint.y  ){
                
                //下滑动
                
                _volumeSlider.value -= 0.02;
                
            }
            
            //调用音量滑块视图事件 以达到同步音量图标
            
            [self VolumeSliderAction:_volumeSlider];
            
        }
        
    }
    
    if (self.moveDirection != 0) {
        
        self.startPoint = self.endPoint;
        
    }
    
}

#pragma mark ---触控结束

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //改变播放时间处理
    
    [self changeTimeHandle];
    
}

#pragma mark ---改变播放时间处理

- (void)changeTimeHandle{
    
    //判断是否改变了时间
    
    if (self.changeTime != 0) {
        
        //设置改变的播放时间
        
        self.slider.value += self.changeTime;
        
        [self SliderAction:self.slider];
        
    }
    
    //滑动方向初始化
    
    self.moveDirection = 0;
    
    //改变的时间值初始化
    
    self.changeTime = 0;
    
    _promptView.hidden = YES;
    
}


#pragma mark ---点击事件

- (void)handleTap:(UITapGestureRecognizer *)tap{
    
    //提示视图隐藏判断 (由于点击手势可能会截获touchEnded响应 所以要在这里判断做出操作)
    
    if (_promptView.hidden) {
        
        if (self.topView.frame.origin.y >= 0) {
            
            [self hiddenControlView];
            
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            
        } else {
            
            [self showControlView];
            
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
            
        }
        
    } else {
        
        //改变播放时间处理
        
        [self changeTimeHandle];
        
    }
    
    

    
    
 
}

#pragma mark ---双击事件

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap{
    
    //判断当前竖屏还是横屏
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        
        //这句话是防止手动先把设备置为横屏,导致下面的语句失效.
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];

        
    } else {
        
        //这句话是防止手动先把设备置为竖屏,导致下面的语句失效.
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
        
    }
    
}

#pragma mark ---长按事件

- (void)HandleLongPress:(UILongPressGestureRecognizer *)longPress{

    //长按设置播放速度 (2倍)
    
    [self.moviePlayer setCurrentPlaybackRate:2.0f];
    
    //判断手势是否结束
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        
        //还原长按设置播放速度 (1倍)
        
        [self.moviePlayer setCurrentPlaybackRate:1.0f];
        
    }
    
}



#pragma mark ---显示控制视图

- (void)showControlView{
    
    __block VideoPlayerViewController *Self = self;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        Self.bottomView.frame = CGRectMake(0 , CGRectGetHeight(Self.moviePlayer.view.frame) - 60 , CGRectGetWidth(Self.bottomView.frame), 60);
        
        Self.topView.frame = CGRectMake(0 , 0 , CGRectGetWidth(Self.topView.frame), CGRectGetHeight(Self.topView.frame));
        
        //显示音量控制视图
        
        [Self showVolumeControlView];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

#pragma mark ---隐藏控制视图

- (void)hiddenControlView{
    
    __block VideoPlayerViewController *Self = self;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        Self.topView.frame = CGRectMake(0 , 0 - 64 , CGRectGetWidth(Self.topView.frame), CGRectGetHeight(Self.topView.frame));
        
        Self.bottomView.frame = CGRectMake(0 , CGRectGetHeight(Self.moviePlayer.view.frame), CGRectGetWidth(Self.bottomView.frame), 60);
        
        //隐藏音量控制视图
        
        [Self hiddenVolumeControlView];
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

#pragma mark ---显示音量控制视图

- (void)showVolumeControlView{
    
    __block VideoPlayerViewController *Self = self;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        Self.volumeView.frame = CGRectMake(CGRectGetWidth(Self.moviePlayer.view.frame) - 40 , Self.volumeView.frame.origin.y, CGRectGetWidth(Self.volumeView.frame), CGRectGetHeight(Self.volumeView.frame));
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

#pragma mark ---隐藏音量控制视图

- (void)hiddenVolumeControlView{
    
    __block VideoPlayerViewController *Self = self;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        Self.volumeView.frame = CGRectMake(CGRectGetWidth(Self.moviePlayer.view.frame), Self.volumeView.frame.origin.y, CGRectGetWidth(Self.volumeView.frame), CGRectGetHeight(Self.volumeView.frame));
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}


//询问代理对象是否允许一个识别器对象同时识别其他手势 默认为no;

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
   
    return YES;

}


#pragma mark ---视图即将出现

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //设置退出状态
    
    self.isDismiss = NO;
    
    //隐藏下载气泡
    
    [[SettingManager shareSettingManager] downloadViewHiddenOrShow:YES];
    
}

#pragma mark ---视图已经消失

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    //视图即将消失
    
    //判断是否准备好播放
    
    if (self.moviePlayer.isPreparedToPlay) {
        
        //停止播放
        
        [self.moviePlayer stop];
        
    } else {
        
        //设置已退出状态
        
        self.isDismiss = YES;
        
    }

    
    //显示下载气泡
    
    [[SettingManager shareSettingManager] downloadViewHiddenOrShow:NO];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.apptransport security
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ---加载数据

-(void)setVideoTitle:(NSString *)videoTitle{
    
    if (_videoTitle != videoTitle) {
        
        [_videoTitle release];
        
        _videoTitle = [videoTitle retain];
        
    }
    
    //添加标题数据
    
    _topTitleLabel.text = videoTitle;
    
    
}

//获取视频详情数组

-(void)setVideoArray:(NSMutableArray *)videoArray{
    
    if (_videoArray != videoArray) {
        
        [_videoArray release];
        
        _videoArray = [videoArray retain];
        
        //如果传入的视频数组与上一次不一样 清空播放器URL 播放时间属性归0
        
        self.moviePlayer.contentURL = nil;
        
        self.nowPlayTime = 0;
        
    }
    
    if (videoArray != nil) {

        
        if (videoArray.count > 0) {
            
            //检测当前清晰度选项下标是否越界
            
            if (self.definitionIndex > videoArray.count - 1) {
                
                //如果越界设为当前最高清晰度下标
                
                self.definitionIndex = videoArray.count - 1;
                
            }
            
            //隐藏所有清晰度列表选项
            
            for (UIButton *itemButton in _topDefinitionListView.subviews) {
                
                itemButton.hidden = YES;
                
            }
            
            //显示清晰度列表选项
            
            for (int i = 0 ; i < videoArray.count ; i++) {
                
                UIButton *tempButton = (UIButton *)_topDefinitionListView.subviews[i];
                
                tempButton.hidden = NO;
                
            }
            
            //显示加载视图
            
            self.loadingView.hidden = NO;
            
            //设置视频URL
            
            self.moviePlayer.contentURL = [self getNetworkUrl];
            
            
            //缓冲视频
            
            [self.moviePlayer prepareToPlay];
            
            //播放
            
            [self.moviePlayer play];

            
        } else {
            
            
            
        }
        
    }

}

- (void)setDefinitionIndex:(NSInteger)definitionIndex{
    
    if (_definitionIndex != definitionIndex) {
        
        _definitionIndex = definitionIndex;
        
        //如果切换的清晰度与当前清晰度不同 才执行切换操作
        
        //转换播放相应清晰度的视频的url
        
        if (self.videoArray != nil) {
            
            if (self.videoArray.count - 1 >= definitionIndex ) {
                
                //隐藏清晰度列表
                
                _topDefinitionListView.hidden = YES;
                
                _topDefinitionListView.alpha = 0.0f;
                
                //设置清晰度按钮显示对应的标题
                
                NSString *definitionButtonTitle = nil;
                
                switch (definitionIndex) {
                    case 0:
                        
                        definitionButtonTitle = @"标清";
                        
                        break;
                        
                    case 1:
                        
                        definitionButtonTitle = @"高清";
                        
                        break;
                        
                        
                    case 2:
                        
                        definitionButtonTitle = @"超清";
                        
                        break;
                        
                        
                    default:
                        break;
                }
                
                [_topDefinitionButton setTitle:definitionButtonTitle forState:UIControlStateNormal];

                
                //设置视频URL
                
                self.moviePlayer.contentURL = [self getNetworkUrl];
                
                //缓冲视频
                
                [self.moviePlayer prepareToPlay];
                
                //播放
                
                [self.moviePlayer play];
                
                
                
            }
            
        }

        
    }
    
}


/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */

-(NSURL *)getFileUrl{
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */

-(NSURL *)getNetworkUrl{
    
    VideoDetailsModel *VDModel = self.videoArray[self.definitionIndex];
    
    NSArray *urlArray = VDModel.urls;
    
    NSString *urlStr = [urlArray objectAtIndex:0];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    return url ;

}

/**
 *  创建播放计时器
 *
 *  @return 播放计时器
 */

-(NSTimer *)timer{
    
    if (_timer == nil) {
        
        _timer = [[NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(playTimerAction:) userInfo:nil repeats:YES] retain];
        
        //将定时器添加到运行循环中
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];

        [runLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
        
    }
    
    return _timer;
    
}


/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */


-(MPMoviePlayerController *)moviePlayer{
    
    if (!_moviePlayer) {
        
        _moviePlayer=[[MPMoviePlayerController alloc]init];
        
        _moviePlayer.view.frame=self.view.bounds;
        
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:_moviePlayer.view];
        
        //将控制视图置于最上层
        
        [self.view bringSubviewToFront:_topView];
        
        [self.view bringSubviewToFront:_bottomView];
        
        [self.view bringSubviewToFront:_volumeView];
     
        [self.view bringSubviewToFront:_topDefinitionListView];
        
        [self.view bringSubviewToFront:_promptView];
        
        [self.view bringSubviewToFront:_loadingView];
        
    }
   
    return _moviePlayer;

}


#pragma mark - 控制器通知


/**
 *  添加通知监控媒体播放控制器状态
 */


-(void)addNotification{
    
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    
    //播放状态改变，可配合playbakcState属性获取具体状态
    
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    
    //媒体播放完成或用户手动退出
   
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
    //确定了媒体播放时长后
    
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackDuration:) name:MPMovieDurationAvailableNotification object:self.moviePlayer];
    
    //媒体网络加载状态改变
    
    [notificationCenter addObserver:self selector:@selector(mediaPlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
    
    //系统音量通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemVolumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */

-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
   
    switch (self.moviePlayer.playbackState) {
    
        case MPMoviePlaybackStatePlaying:
        
            NSLog(@"正在播放...");
            
            //同步播放按钮状态
            
            self.playButton.selected = NO;
            
            //继续开启定时器
            
            [self.timer setFireDate:[NSDate date]];
            
            //设置播放时间 从上一次播放的时间进度开始继续播放
            
            [self.moviePlayer setCurrentPlaybackTime:self.nowPlayTime];
            
            if (self.loadingView.hidden == NO) {
                
                //隐藏加载视图
                
                self.loadingView.hidden = YES;
                
            }
            
            
            
            
            break;
        
        case MPMoviePlaybackStatePaused:
        
            NSLog(@"暂停播放.");
            
            //同步播放按钮状态
            
            self.playButton.selected = YES;
            
            //暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
            
            self.timer.fireDate = [NSDate distantFuture];
            
            if (self.moviePlayer.currentPlaybackTime >= self.moviePlayer.playableDuration ) {
                
                //显示加载视图
                
                self.loadingView.hidden = NO;
                
            }
            
            break;
        
        case MPMoviePlaybackStateStopped:
        
            NSLog(@"停止播放.");
            
            //同步播放按钮状态
            
            self.playButton.selected = YES;
            
            //暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
            
            self.timer.fireDate = [NSDate distantFuture];
            
            break;
            
        case MPMoviePlaybackStateInterrupted:
            
            NSLog(@"中断播放.");
            
            //同步播放按钮状态
            
            self.playButton.selected = YES;
            
            //暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
            
            self.timer.fireDate = [NSDate distantFuture];

            break;
            
        case MPMoviePlaybackStateSeekingForward:
            
            NSLog(@"前进");
            
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            
            NSLog(@"后退");
            
            break;
        
        default:
        
            NSLog(@"播放状态:%ld",(long)self.moviePlayer.playbackState);
            
            break;
    
    }

    
//    媒体播放状态，枚举类型：
//    MPMoviePlaybackStateStopped：停止播放
//    MPMoviePlaybackStatePlaying：正在播放
//    MPMoviePlaybackStatePaused：暂停
//    MPMoviePlaybackStateInterrupted：中断
//    MPMoviePlaybackStateSeekingForward：向前定位
//    MPMoviePlaybackStateSeekingBackward：向后定位
    
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */

-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{

    NSLog(@"播放完成.%ld",(long)self.moviePlayer.playbackState);
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    } ];
    
}

/**
 *  确定了播放时长后
 *
 *  @param notification 通知对象
 */

-(void)mediaPlayerPlaybackDuration:(NSNotification *)notification{
    
    //设置视频时长
    
    _videoDurationLabel.text = [NSString stringWithFormat:@" - %@" , [self getStringWithTime:self.moviePlayer.duration]];
    
    //设置播放滑块视图最大值
    
    _slider.maximumValue = self.moviePlayer.duration;
    
}

/**
 *  媒体网络加载状态改变
 *
 *  @param notification 通知对象
 */

- (void)mediaPlayerLoadStateDidChange:(NSNotification *)notification{
    
    switch (self.moviePlayer.loadState) {
            
        case MPMovieLoadStateUnknown:
            
            //未知状态
            
            NSLog(@"====未知");
            
            break;
            
        case MPMovieLoadStatePlayable:
            
            //可播状态
            
            //隐藏加载视图
            
            self.loadingView.hidden = YES;
            
            NSLog(@"====可播");
            
            //判断是否已退出 如果退出则停止播放
            
            if (self.isDismiss) {
                
                //暂停视频
                
                [self.moviePlayer pause];
                
                //停止视频
                
                [self.moviePlayer stop];
                
            }
            
            break;
            
        case MPMovieLoadStatePlaythroughOK:
            
            //加载完成状态
            
            //隐藏加载视图
            
            self.loadingView.hidden = YES;
            
            NSLog(@"====加载完成");
            
            break;
            
        case MPMovieLoadStateStalled:
            
            //正在加载状态
            
            //显示加载视图
            
            self.loadingView.hidden = NO;
            
             NSLog(@"====加载");
            
            break;
            
        default:
            break;
    }
    
}

/**
 *  系统音量改变
 *
 *  @param notification 通知对象
 */

- (void)systemVolumeChanged:(NSNotification *)notification{
    
    //同步音量滑块的值与系统音量同步
    
    _volumeSlider.value = _systemvolumeViewSlider.value ;
    
    [self VolumeSliderAction:_volumeSlider];
    
}

#pragma mark ---moviePlayer计时器响应事件

- (void)playTimerAction:(NSTimer *)timer{
    
    //获取当前播放时间 并为控件赋值
    
    //为当前播放时间Label添加数据
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%@",[self getStringWithTime:self.moviePlayer.currentPlaybackTime]];
    
    //为提示时间添加时间数据
    
    self.promptTimeLabel.text = [NSString stringWithFormat:@"%@/%@" , [self getStringWithTime:self.moviePlayer.currentPlaybackTime] , [self getStringWithTime:self.moviePlayer.duration]];
    
    //设置播放进度滑块视图
    
    self.slider.value = self.moviePlayer.currentPlaybackTime;
    
    //存储当前播放时间
    
    self.nowPlayTime = self.moviePlayer.currentPlaybackTime;
    
    //获取已缓冲的百分比 (可播放时长 除以 总播放时长)
    
    CGFloat LoadedProgress = self.moviePlayer.playableDuration / self.moviePlayer.duration;
    
    //设置进度值并动画显示
    
    [self.progressView setProgress:LoadedProgress animated:YES];
    
    
}





//隐藏状态条

//- (BOOL)prefersStatusBarHidden
//{
//    
//    return YES;
//
//}


#pragma mark ---设置电池条前景部分样式类型 (白色)

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

#pragma mark ---时间格式转换 将秒转换成指定格式字符串

- (NSString *)getStringWithTime:(NSInteger)time{
    
    if (time < 0) {
        
        time = 0 - time;
        
    }
    
    NSString *timeString = nil;
    
    NSInteger MM = 0;
    
    NSInteger HH = 0;
    
    if (59 < time) {
        
        MM = time / 60 ;
        
//        timeString = [NSString stringWithFormat:@"%.2ld:%.2ld",MM,time - MM * 60];
        
        if (3599 < time) {
            
            HH = time / 3600 ;
   
        }
 
    }
    
    timeString = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld", (long)HH , MM > 59 ? MM - 60 : MM ,time - MM * 60];
    
    return timeString;
    
}

#pragma mark ---支持自动旋转

- (BOOL)shouldAutorotate
{

    return YES;

}


@end
