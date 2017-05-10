//
//  XHQRegistViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQRegistViewController.h"



@interface XHQRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;


@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *okRegist;

@end

@implementation XHQRegistViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    if([XHQAuxiliary DeviceIsIpone6orLater])
    {
    [self keyBaordShowOrHide];
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)keyBaordShowOrHide
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)hideKeyBoard:(NSNotification *)sender
{
    self.view.transform = CGAffineTransformIdentity;
}
- (void)showKeyBoard:(NSNotification *)sender
{
    CGRect rect = [[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyBoardH = rect.size.height;
    
    self.view.transform = CGAffineTransformMakeTranslation(0, - keyBoardH );
}
- (IBAction)okRegist:(id)sender {
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *email = self.email.text;
    
     if(![XHQAuxiliary validateUserName:username rule:nil])
     {
     [XHQAuxiliary alertWithTitle:@"注册信息提示" message:@"用户名由大小写26个英文字母和数组组成，长度6-20位" button:0 done:nil];
         return;
     }
     if(![XHQAuxiliary validatePassword:password rule:nil ])
     {
     [XHQAuxiliary alertWithTitle:@"注册信息提示" message:@"密码由大小写26个英文字母和数组组成，长度6-20位" button:0 done:nil];
         return;
     }
     if(![XHQAuxiliary validateEmail:email])
     {
     [XHQAuxiliary alertWithTitle:@"注册信息提示" message:@"邮箱填写不规范" button:0 done:nil];
         return;
     }
    
    [XHQAuxiliary alertWithTitle:@"注册信息提示" message:@"恭喜您注册成功" button:0 done:nil];
    
    NSDictionary *dict = @{@"username":username,@"password":password,@"email":email};
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:@"XHQ"];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.email resignFirstResponder];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com