//
//  PreViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PreViewController.h"
#import "UserInfoManager.h"
#import "WWeChatApi.h"
#import "TabBarViewController.h"
@interface PreViewController()
@property (weak, nonatomic) IBOutlet UIButton *languageBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerBtnToRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnToLeft;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end
@implementation PreViewController

- (void)viewWillAppear:(BOOL)animated
{
    if ([UserInfoManager manager].mid.length > 0 && [UserInfoManager manager].password.length > 0)
    {
        [_languageBtn removeFromSuperview];
        [_loginBtn removeFromSuperview];
        [_registerBtn removeFromSuperview];
        
        [[WWeChatApi giveMeApi]loginWithUserName:[UserInfoManager manager].mid andPassWord:[UserInfoManager manager].password andSuccess:^(id response) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarViewController alloc]init];
                
            });
            
        } andFailure:^{
            
        } andError:^(NSError *error) {
            
        }];
        
    }
    else
    {
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _loginBtnHeight.constant = WGiveHeight(40);
    _loginBtnWidth.constant = WGiveWidth(130);
    
    _registerBtnHeight.constant = WGiveHeight(40);
    _registerBtnWidth.constant = WGiveWidth(130);
    
    _loginBtnToLeft.constant = (kSceenWidth - (WGiveWidth(130)*2))/3.0 -20;
    _registerBtnToRight.constant = (kSceenWidth - (WGiveWidth(130)*2))/3.0 -20;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
