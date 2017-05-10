//
//  CSLBaseViewController.m
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "XHQRootViewController.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface XHQRootViewController ()
-(void) dataInit;//数据初始化
-(void) showIndicatorInView:(UIView*)parentView isDisplay:(BOOL)show;//是否显示指示器

@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation XHQRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.dataSource = nil;//销毁数据源
}


//初始化数据源
-(void) dataInit{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
   
}


//数据请求
-(void) request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict{
    
    if ([method isEqualToString:@"GET"]) {
        [XHQNetRequest get:urlString complete:^(id data) {
            
            [self parserData:data];
        } fail:^(NSError *error) {
            NSLog(@"GET的失败原因是%@",error);
            [self showHub:NO];
        }];
    }
    else{
        [XHQNetRequest post:urlString para:dict complete:^(id data) {
            [self parserData:data];
        } fail:^(NSError *error) {
            NSLog(@"POST失败原因是%@",error.description);
        }];
    }
}


//子类是实现
-(void) parserData:(id)data{
    //    [self showIndicator:NO];
   
}

- (void)showHub:(BOOL)show
{
    if(show)
    {
        [self.hud show:YES];
    }else {
        [self.hud hide:YES];
    }
}


- (void)pushNextWithType:(NSString *)type Subtype:(NSString *)subtype Viewcontroller:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.type = type;
    transition.subtype = subtype;
    transition.duration = 1;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController .view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewController animated:nil];

}

#pragma mark ---- 懒加载 -----
- (MBProgressHUD *)hud {
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        // 加载文案
        _hud.labelText = @"正在为您刷新...";
        
        // 添加
        [self.view addSubview:_hud];
    }
    return _hud;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com