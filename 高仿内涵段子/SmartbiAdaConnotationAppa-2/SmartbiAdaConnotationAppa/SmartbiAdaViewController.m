//
//  ViewController.m
//  UIScrollView
//
//  Created by lcy on 16/2/25.
//  Copyright (c) 2016年 lcy. All rights reserved.
//

#import "SmartbiAdaViewController.h"
#import "SmartbiAdaAppDelegate.h"
#import "config__api.h"

@interface SmartbiAdaViewController ()

@end

@implementation SmartbiAdaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kScreenBounds];
    
    UIImageView *imageView = nil;
    for (NSInteger i = 0; i < 3; i ++) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"open_%ld",i+1]];
        
        [scrollView addSubview:imageView];

    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"开始体验" forState:UIControlStateNormal];
    btn.frame = CGRectMake((kScreenWidth - 100) / 2.0f , kScreenHeight / 2.0f+150, 100, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    
    imageView.userInteractionEnabled = YES;
    scrollView.contentSize = CGSizeMake(3 * kScreenWidth, kScreenHeight);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
}

//类似于登录  ---> tabBar   启动页   主界面

//切换window的根视图
-(void)click
{
    //AppDelegate
    SmartbiAdaAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = appDelegate.rootVC;
    //window ---》 mainVC
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"isFirst"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
