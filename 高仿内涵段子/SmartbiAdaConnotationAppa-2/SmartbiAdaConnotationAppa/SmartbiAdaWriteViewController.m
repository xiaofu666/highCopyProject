//
//  SmartbiAdaWriteViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/16.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaWriteViewController.h"
#import "SmartbiAdaNavigationController.h"
#import "config__api.h"


@interface SmartbiAdaWriteViewController ()<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textField;

@property (weak, nonatomic) IBOutlet UIView *UIVIEW;

@end

@implementation SmartbiAdaWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     SmartbiAdaNavigationController *nav=[[SmartbiAdaNavigationController alloc]init];
//    [self.view addSubview:nav];
    self.textField.returnKeyType=UIReturnKeyDone;//设置键盘中return 为 Done 完成
    self.textField.delegate=self;
     UIColor *titleColor = [UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftBackButtonFGNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    left.tintColor=titleColor;
    self.navigationItem.leftBarButtonItem=left;
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:nil];
    right.tintColor=titleColor;
    self.navigationItem.rightBarButtonItem=right;
    
//    self.textField.placeholder=@"您的投稿经过段友审核才能发布哦！我们的目标是：专注内涵，拒绝黄反！可以矫情，不要煽情！敬告：发布色情敏感内容会被封号处理。";
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    NSLog(@"是否需要启动编辑");
    self.UIVIEW.frame=CGRectMake(0, kScreenHeight-330, kScreenWidth, 80);
//    [self.view bringSubviewToFront:self.UIVIEW];
//    return YES;  //返回yes则启动编辑；否则不启动编辑
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    self.UIVIEW.frame=CGRectMake(0, 568-330, 320, 80);
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSLog(@"是否触发返回按键");
//    //收回键盘
//    [self.textField resignFirstResponder];
////    [self.view endEditing:YES];
//     self.UIVIEW.frame=CGRectMake(0, 490, 320, 80);
//    return NO;
//}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
