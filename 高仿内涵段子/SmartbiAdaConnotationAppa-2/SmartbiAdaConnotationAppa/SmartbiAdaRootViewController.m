//
//  SmartbiAdaRootViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaRootViewController.h"
#import "SmartbiAdaLaunchViewController.h"

#import "SmartbiAdaHomeViewController.h"
#import "SmartbiAdaDiscoverViewController.h"
#import "SmartbiAdaTakeViewController.h"
#import "SmartbiAdaMeViewController.h"
#import "SmartbiAdaNavigationController.h"


@interface SmartbiAdaRootViewController ()

@property (nonatomic, strong) SmartbiAdaLaunchViewController *launchViewController; //!< 启动页面
@property (nonatomic, strong) UITabBarController *mainViewController; //!< 主页面，是一个UITabBarController
@end

@implementation SmartbiAdaRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     [self ada_addChildViewController:self.launchViewController];
    
    // 2.几秒之后，跳转到主页面
    // GCD封装的定时器，这个dispatch_after是几秒之后会执行Block里的代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"这里的代码会5秒钟后执行 转场动画");
        
        // 转场动画
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        [self ada_removeChildViewController:self.launchViewController];
        [self ada_addChildViewController:self.mainViewController];
        
        [UIView commitAnimations];
    });

    
}

- (void)ada_addChildViewController:(UIViewController *)viewController{
    // 把另一个ViewController加载容器的ViewController里的方法，可以把这三行代码理解为固定写法
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    // 把要添加的ViewController的frame调跟self.view的frame同样的大小
    viewController.view.frame = self.view.frame;
}
-(void)ada_removeChildViewController:(UIViewController *)viewController{

    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];
    [viewController removeFromParentViewController];
}
#pragma mark - Setter & Getter

// 懒加载
- (SmartbiAdaLaunchViewController *)launchViewController
{
    if (_launchViewController == nil) {
        _launchViewController = [[SmartbiAdaLaunchViewController alloc] initWithNibName:@"SmartbiAdaLaunchViewController" bundle:nil];
    }
    
    return _launchViewController;
}
-(UITabBarController *)mainViewController{
    if (_mainViewController == nil) {
        _mainViewController=[[UITabBarController alloc]init];
        
        SmartbiAdaHomeViewController *homeVC=[[SmartbiAdaHomeViewController alloc]init];
        SmartbiAdaDiscoverViewController *discoverVC=[[SmartbiAdaDiscoverViewController alloc]init];
        SmartbiAdaTakeViewController *takeVC=[[SmartbiAdaTakeViewController alloc]init];
        SmartbiAdaMeViewController *meVC=[[SmartbiAdaMeViewController alloc]init];
        NSArray *titles=@[@"首页",@"视频",@"发现",@"消息"];
        NSArray *icons=@[@"home",@"Found",@"audit",@"newstab"];
        NSArray *VCS=@[homeVC,discoverVC,takeVC,meVC];
        NSMutableArray *navVCS=[NSMutableArray array];
        for (NSInteger i=0; i<VCS.count; i++) {
            UIViewController *vc=VCS[i];
            SmartbiAdaNavigationController *nav=[[SmartbiAdaNavigationController alloc]initWithRootViewController:vc];
            nav.tabBarItem.title=titles[i];
            
            
            nav.tabBarItem.image=[[UIImage imageNamed:icons[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage=[[UIImage imageNamed:[NSString stringWithFormat:@"%@_press", icons[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            // 设置标题的样式
            UIColor *titleSelectedColor =
            [UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
            UIColor *titleNormalColor = [UIColor lightGrayColor];
            
            // 选中状态的字体颜色
            [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11], NSForegroundColorAttributeName: titleSelectedColor} forState:UIControlStateSelected];
            // 非选中状态的字体颜色
            [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11], NSForegroundColorAttributeName: titleNormalColor} forState:UIControlStateNormal];
            
            
            [navVCS addObject:nav];
        }
        
        _mainViewController.viewControllers=navVCS;
        [_mainViewController.tabBar setBarTintColor:[UIColor whiteColor]];
    }
    
    return _mainViewController;
}
@end
