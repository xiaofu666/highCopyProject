//
//  FeedbackViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FeedbackViewController.h"

#import "NSString+URL.h"

#import <SKPSMTPMessage.h>

#import <MBProgressHUD.h>

@interface FeedbackViewController ()<UITextViewDelegate,SKPSMTPMessageDelegate,MBProgressHUDDelegate>

@property (nonatomic , retain ) UITextView *textView;//文本视图

@property (nonatomic , retain ) UILabel *wordCountLabel;//字数Label

@property (nonatomic , retain ) MBProgressHUD *HUD;//提示框视图

@end

@implementation FeedbackViewController

-(void)dealloc{
    
    [_textView release];
    
    [_wordCountLabel release];
    
    [_HUD release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    
    
    //添加导航栏右按钮
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
    
    rightBarButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;

    //初始化视图控件
    
    [self initViews];
    
    
    
    self.HUD.labelText = @"发送中..";
    
    self.HUD.delegate = self;

    
    
}

#pragma mark ---初始化视图控件

- (void)initViews{
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake( 5 , 20 , CGRectGetWidth(self.view.frame) - 10 , 150)];
    
    _textView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    _textView.textColor = [UIColor grayColor];
    
    _textView.layer.borderWidth = 0.2f;
    
    _textView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    
    _textView.clipsToBounds = YES;
    
    _textView.layer.cornerRadius = 5;
    
    _textView.font = [UIFont boldSystemFontOfSize:16];
    
    _textView.delegate = self;
    
    _textView.returnKeyType = UIReturnKeySend;
    
    [self.view addSubview:_textView];
    
    _wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_textView.frame) - 60, CGRectGetHeight(_textView.frame) - 30, 60, 30)];
    
    _wordCountLabel.textColor = [UIColor grayColor];
    
    _wordCountLabel.text = @"200";
    
    _wordCountLabel.textAlignment = NSTextAlignmentCenter;
    
    [_textView addSubview:_wordCountLabel];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;

    //设为第一响应者
    
    [_textView becomeFirstResponder];
    
    [self.view bringSubviewToFront:self.HUD];
    
}


#pragma mark ---UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    
    _wordCountLabel.text = [NSString stringWithFormat:@"%ld" , 200 - textView.text.length];
    
    if (textView.text.length >= 5) {
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        
    } else {
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length >= 200) {
        
        return NO;
        
    } else {
        
        return YES;
   
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---LazyLoading

-(MBProgressHUD *)HUD{
    
    if (_HUD == nil) {
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:_HUD];
        
    }
    
    return _HUD;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




#pragma mark ---rightBarButtonAction

- (void)rightBarButtonAction:(UIBarButtonItem *)sender{
    
    if (self.textView.text.length > 0) {
        
        //释放第一响应者
        
        [self.textView resignFirstResponder];
        
        //弹出提示框
        
        [self.HUD show:YES];
        
        //设置基本参数
        
        SKPSMTPMessage *mail = [[SKPSMTPMessage alloc] init];
        
        [mail setSubject:[NSString stringWithCString:"UnionFeedback" encoding:NSUTF8StringEncoding]];  // 设置邮件主题
        
        [mail setToEmail:@"applelixiang@yeah.net"]; // 目标邮箱
        
        [mail setFromEmail:@"applelixiang@126.com"]; // 发送者邮箱
        
        [mail setRelayHost:@"smtp.126.com"]; // 发送邮件代理服务器
        
        [mail setRequiresAuth:YES];
        
        [mail setLogin:@"applelixiang@126.com"]; // 发送者邮箱账号
        
        [mail setPass:@"hurhqzkddwurgoab"]; // 发送者邮箱密码(网易授权码)
        
        [mail setWantsSecure:YES];  // 需要加密
        
        [mail setDelegate:self];
        
        //设置邮件正文内容
        
        NSString *content = [NSString stringWithCString:[self.textView.text UTF8String] encoding:NSUTF8StringEncoding];
        
        NSDictionary *plainPart = @{kSKPSMTPPartContentTypeKey : @"text/plain", kSKPSMTPPartMessageKey : content, kSKPSMTPPartContentTransferEncodingKey : @"8bit"};
        
        //发送邮件
        
        [mail setParts:@[plainPart]]; // 邮件首部字段、邮件内容格式和传输编码
        
        [mail send];

        
    } else {
        
        
        
    }
}

#pragma mark ---SKPSMTPMessageDelegate

-(void)messageSent:(SKPSMTPMessage *)message{
    
    //发送成功
    
    self.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    
    self.HUD.mode = MBProgressHUDModeCustomView;
    
    self.HUD.labelText = @"发送成功,感谢您的宝贵建议";
    
    [self.HUD hide:YES afterDelay:2.0f];
    
    //清空内容
    
    self.textView.text = @"";
    
    _wordCountLabel.text = @"200";
    
    __block typeof(self)Self = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //返回
        
        [Self.navigationController popViewControllerAnimated:YES];
        
    });
    
}


-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    
    //发送失败
    
    self.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-guanbicuowu"]] autorelease];
    
    self.HUD.mode = MBProgressHUDModeCustomView;
    
    self.HUD.labelText = @"发送失败,请重新发送";
    
    [self.HUD hide:YES afterDelay:2.0f];
    
    //设置第一响应者
    
    [self.textView becomeFirstResponder];
    
}


#pragma mark ---MBProgressHUDDelegate

-(void)hudWasHidden:(MBProgressHUD *)hud{
    
    hud.customView = nil;
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"发送中..";
    
    
    
}




@end
