//
//  BaseViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)addRightBtnWithStr:(NSString *)str andSelector:(SEL)sel
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:sel];
}

- (void)addLeftBtnWithStr:(NSString *)str andSelector:(SEL)sel
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:sel];
}

- (void)addRightBtnWithImgName:(NSString *)imgName andSelector:(SEL)sel
{
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[self removeRendering:imgName] style:UIBarButtonItemStylePlain target:self action:sel];
    
    //微调一下图片的位置
    [self.navigationItem.rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, WGiveWidth(-6), 0, WGiveWidth(6))];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  修改状态颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  返回取消渲染的image
 */
- (UIImage *)removeRendering:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *
 */
- (GlassView *)glassView
{
    if (!_glassView)
    {
        _glassView = [[GlassView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    }
    return _glassView;
}

#pragma mark -- im --

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
