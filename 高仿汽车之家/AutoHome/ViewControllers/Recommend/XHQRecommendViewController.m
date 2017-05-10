//
//  XHQRecommendViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//
#import "XHQZuiXinViewController.h"
#import "XHQPIngceViewController.h"
#import "XHQHangqingViewController.h"
#import "XHQWenhuaViewController.h"
#import "XHQYoujiViewController.h"
#import "XHQShipingViewController.h"

#import "XHQZuiSaoYiSaoView.h"


#import "XHQRecommendViewController.h"
@interface XHQRecommendViewController ()
@property(nonatomic,assign)NSInteger page;

@end

@implementation XHQRecommendViewController

- (instancetype)init
{
    if(self = [super initWithTagViewHeight:49])
    {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tagItemSize =CGSizeMake(80, 49);
    
    self.selectedTitleColor = [UIColor redColor];
    self.selectedTitleFont = [UIFont systemFontOfSize:18];
    
    self.normalTitleColor = [UIColor grayColor];
    self.normalTitleFont = [UIFont systemFontOfSize:15];
  
    self.backgroundColor = [UIColor whiteColor];
    self.selectedIndicatorColor = [UIColor redColor];
    
    NSArray *titleArray = @[@"最新",@"评测",@"行情",@"文化",@"游记",@"图赏"];
  
    
    
    NSArray *classNames =@[ [XHQZuiXinViewController class],[XHQPIngceViewController class],[XHQHangqingViewController class],[XHQWenhuaViewController class],[XHQYoujiViewController class],[XHQShipingViewController class]];
   
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"2vm"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:nil];
    

    
}

- (void)rightAction
{
    
    CGPoint point = CGPointMake(1, 1);
    
    NSArray *imagesArr = @[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png",@"diannao.png",@"shouqian.png"] ;
    NSArray *dataSourceArr = @[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] ;
    [ XHQZuiSaoYiSaoView configCustomPopViewWithFrame:CGRectMake(120, 20, 200, 160) imagesArr:imagesArr dataSourceArr:dataSourceArr anchorPoint:point seletedRowForIndex:^(NSInteger index) {
       
        NSString *str = [NSString stringWithFormat:@"您已选择%@",dataSourceArr[index]];
        
        [XHQAuxiliary alertWithTitle:@"温馨提示" message:str button:0 done:nil];
        
        
    } animation:YES timeForCome:0.3 timeForGo:0.3];

}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com