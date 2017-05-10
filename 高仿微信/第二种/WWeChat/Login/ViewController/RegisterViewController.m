//
//  RegisterViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+ToImg.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self btnSetting];
    [_mobileTextfield addTarget:self action:@selector(judgement) forControlEvents:UIControlEventEditingChanged];

}
- (void)judgement
{
    if (_mobileTextfield.text.length > 0 )
    {
        _registerBtn.enabled = YES;
        _registerBtn.alpha = 1;
    }
    else
    {
        _registerBtn.enabled = NO;
        _registerBtn.alpha = 5;
    }
}

- (void)btnSetting
{
    [_registerBtn setBackgroundImage:[WXGreen toImg] forState:UIControlStateNormal];
    [_registerBtn setBackgroundImage:[[UIColor colorWithRed:36/255.0 green:186/255.0 blue:36/255.0 alpha:0.1] toImg] forState:UIControlStateDisabled];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)registerBtnClick:(id)sender {
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
