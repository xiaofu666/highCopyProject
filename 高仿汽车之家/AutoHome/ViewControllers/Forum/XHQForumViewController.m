//
//  XHQForumViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQForumViewController.h"


#import "XHQForumAllViewController.h"
#import "XHQForumBestViewController.h"
#import "XHQForumAskViewController.h"


#import "XHQForumAllModel.h"

@implementation XHQForumViewController
- (instancetype)init
{
    if(self = [super initWithTagViewHeight:49])
    {
        
    }return self;
}
- (void)viewDidLoad {
  
    [super viewDidLoad];
    self.tagItemSize = CGSizeMake(110, 49);
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArray = @[@"全部",@"精华",@"问答"];
    NSArray *viewControllerArray = @[[XHQForumAllViewController class],[XHQForumBestViewController class],[XHQForumAskViewController class]];
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:viewControllerArray withParams:nil];

}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com