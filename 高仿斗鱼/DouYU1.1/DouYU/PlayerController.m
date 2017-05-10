//
//  PlayerController.m
//  DouYU
//
//  Created by admin on 15/11/8.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "PlayerController.h"
#import "Public.h"
#import "YFViewPager.h"

#import "FMGVideoPlayView.h"
#import "FullViewController.h"

@interface PlayerController ()<FMGVideoPlayViewDelegate>
{
   YFViewPager *_viewPager;
   UIWebView    *_webView;
    
}
@property (weak, nonatomic) FMGVideoPlayView *playView;

@end


@implementation PlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle= UIStatusBarStyleDefault;

    [self setupVideoPlayView];
    [self initViewPager];

}
- (void)setupVideoPlayView
{
    FMGVideoPlayView *playView=[FMGVideoPlayView videoPlayView];
    playView.delegate=self;
    // 视频资源路径
    [playView setUrlString:self.Hls_url];
    // 播放器显示位置（竖屏时）
    playView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    // 添加到当前控制器的view上
    [self.view addSubview:playView];
    
    // 指定一个作为播放的控制器
    playView.contrainerViewController = self;
    
}

-(void)initViewPager
{
    
    _webView = [[UIWebView alloc] init];
    [_webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"https://www.baidu.com"]]];

    NSArray *titles = [[NSArray alloc] initWithObjects:
                       @"聊天",
                       @"主播",
                       @"排行", nil];
    
    NSArray *views = [[NSArray alloc] initWithObjects:
                      _webView,
                      _webView,
                      _webView, nil];
    
    _viewPager = [[YFViewPager alloc] initWithFrame:CGRectMake(0,screen_width * 9 / 16+20, screen_width ,screen_height-screen_width * 9 / 16-20)
                                             titles:titles
                                              icons:nil
                                      selectedIcons:nil
                                              views:views];
    [self.view addSubview:_viewPager];
    
    [_viewPager didSelectedBlock:^(id viewPager, NSInteger index) {
        switch (index) {
            case 0:
            {
                NSLog(@"点击第一个菜单");
            }
                break;
            case 1:    
            {
                 NSLog(@"点击第二个菜单");
            }
                break;
            case 2:
            {
                NSLog(@"点击第三个菜单");
            }
                break;
                
            default:
                break;
        }
    }];
}

-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)shareAction
{
   NSLog(@"ShareBtn");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(NSString *)GetNowTimes
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    return timeString;
}




@end
