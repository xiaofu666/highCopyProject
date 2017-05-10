//
//  LoginViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+ToImg.h"
#import "WWeChatApi.h"

#import "TabBarViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewToTopLayout;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKeyBoardNoti];
    
    [self btnSetting];
    
    [_mobileTextfield addTarget:self action:@selector(judgement) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextfield addTarget:self action:@selector(judgement) forControlEvents:UIControlEventEditingChanged];
    [_centerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)]];
}

- (void)hideKeyBoard
{
    [self.view endEditing:YES];
}

- (void)judgement
{
    if (_mobileTextfield.text.length > 0 && _passwordTextfield.text.length >0)
    {
        _loginBtn.enabled = YES;
        _loginBtn.alpha = 1;
    }
    else
    {
        _loginBtn.enabled = NO;
        _loginBtn.alpha = 5;
    }
}

- (void)btnSetting
{
    [_loginBtn setBackgroundImage:[WXGreen toImg] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[[UIColor colorWithRed:36/255.0 green:186/255.0 blue:36/255.0 alpha:0.1] toImg] forState:UIControlStateDisabled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissBtnClick:(id)sender {
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
}
- (IBAction)loginBtnClick:(id)sender {
    
    [[WWeChatApi giveMeApi]loginWithUserName:_mobileTextfield.text andPassWord:_passwordTextfield.text andSuccess:^(id response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [self presentViewController:[[TabBarViewController alloc]init] animated:YES completion:^{
                
            }];
        });
       
        
    } andFailure:^{
        
    } andError:^(NSError *error) {
        
    }];
}

- (void)addKeyBoardNoti
{
    // iPhone 6之前的
    if([UIScreen mainScreen].bounds.size.height < 667)
    {
        //使用NSNotificationCenter 鍵盤出現時
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        //使用NSNotificationCenter 鍵盤隐藏時
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    //持续时间
//    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
//    //动画类型
//    NSInteger anType = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    
//    [UIView animateKeyframesWithDuration:2 delay:0 options:anType animations:^{
//        
        _ViewToTopLayout.constant -= WGiveHeight(50);
//        
//    } completion:^(BOOL finished) {
//    }];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
        _ViewToTopLayout.constant += WGiveHeight(50);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
