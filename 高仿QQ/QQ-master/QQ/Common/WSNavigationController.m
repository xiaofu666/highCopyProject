//
//  WSNavigationController.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSNavigationController.h"
#import "WSRecentMsgTableViewController.h"
#import "WSBuddyListViewController.h"
#import "WSQworldViewController.h"

/**
 *  @brief  获取当前系统版本号
 */
#define kCurrentVersion      ([[[UIDevice currentDevice]systemVersion]floatValue])





@interface WSNavigationController ()

@end

@implementation WSNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupNavStyle];
    // Do any additional setup after loading the view.
}


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self)
    {
        NSString *title         = nil;
        NSString *image         = nil;
        NSString *selectedImage = nil;
        
        if ([rootViewController isKindOfClass:[WSRecentMsgTableViewController class]])
        {
            title         = @"消息";
            image         = @"tab_recent_nor";
            selectedImage = @"tab_recent_press";
        }else
        {
            if ([rootViewController isKindOfClass:[WSBuddyListViewController class]])
            {
                title         = @"联系人";
                image         = @"tab_buddy_nor";
                selectedImage = @"tab_buddy_press";
            }else
            {
                if ([rootViewController isKindOfClass:[WSQworldViewController class]])
                {
                    title         = @"动态";
                    image         = @"tab_qworld_nor";
                    selectedImage = @"tab_qworld_press";
                }
            }
        }
        
        UITabBarItem *Item = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
        
        self.tabBarItem = Item;
    }
    
    return self;
}


-(void)SetupNavStyle
{
    UIColor *BkColor = kBkColorNavigaion;
    if (kCurrentVersion < 7.0f)
    {
        [self.navigationBar setBackgroundImage:[[WSNavigationController CreateImageWithColor:BkColor] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
        if (kCurrentVersion > 6.f)
        {
            //去掉导航栏下边的投影
            self.navigationBar.shadowImage = [[WSNavigationController CreateImageWithColor:[UIColor clearColor]] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        }
    }else
    {
        [self.navigationBar setBackgroundImage:[[WSNavigationController CreateImageWithColor:BkColor] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.tintColor = [UIColor whiteColor];
        //去掉导航栏下边的投影
        self.navigationBar.shadowImage = [[WSNavigationController CreateImageWithColor:[UIColor clearColor]] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    }
    self.navigationBar.barStyle = UIBarStyleBlack;
}

+ (UIImage *)CreateImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
