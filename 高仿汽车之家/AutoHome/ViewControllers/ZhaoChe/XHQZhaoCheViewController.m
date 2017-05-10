//
//  XHQFondcarViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQZhaoCheViewController.h"

#import "XHQZhaoViewController.h"
#import "XHQZhaoSubViewController.h"


@interface XHQZhaoCheViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation XHQZhaoCheViewController
- (instancetype)init
{
    if(self = [super initWithTagViewHeight:49])
    {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagItemSize = CGSizeMake(80, 49);
    self.selectedTitleColor = [UIColor redColor];
    
    self.backgroundColor = [UIColor whiteColor];
    NSArray *titleArray = @[@"所有",@"条件"];
    NSArray *classNames = @[[XHQZhaoViewController class],[XHQZhaoSubViewController class]];
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:nil];
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com