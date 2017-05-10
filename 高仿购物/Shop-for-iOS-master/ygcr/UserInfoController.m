//
//  UserInfoController.m
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/21.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "UserInfoController.h"
#import "UserInfoView.h"

@interface UserInfoController ()
{
    UserEntity *_user;
    
    UserInfoView *_infoView;
}

@end

@implementation UserInfoController

- (instancetype)initWithUser:(UserEntity *)user
{
    self = [super init];
    if (!self) return nil;
    
    _user = user;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    
    _infoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+kTopBarHeight, kScreenWidth, kScreenHeight) user:_user];
    [self.view addSubview:_infoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
