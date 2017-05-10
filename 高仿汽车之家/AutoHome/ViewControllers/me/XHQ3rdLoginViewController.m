//
//  XHQ3rdLoginViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//



#import "XHQ3rdLoginViewController.h"
#import "UMSocial.h"
#import "UMSocialShakeService.h"
#import "UMSocialScreenShoter.h"

#import "XHQRegistViewController.h"


@interface XHQ3rdLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *passwords;

@end

@implementation XHQ3rdLoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    [self creatLoginView];
}
- (void)creatLoginView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(Reginst)];
}

- (void)Reginst
{
    XHQRegistViewController *regist = [[XHQRegistViewController alloc]init];
    [self pushNextWithType:@"cube" Subtype:@"fromLeft" Viewcontroller:regist];
}
- (IBAction)login:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   NSDictionary *dict =[userDefaults objectForKey:@"XHQ"];
  
    NSString *str = dict[@"username"];
    
    
    if(str)
    {
       
        [XHQAuxiliary alertWithTitle:@"登录提示" message:@"登录成功" button:0 done:nil];
        
        if(self.LoginSuccess)
        {
            self.LoginSuccess();
        }
        return;

    }
    
    [XHQAuxiliary alertWithTitle:@"登录提示" message:@"用户名或密码错误" button:0 done:nil];
}
- (IBAction)sain:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //   获取用户名、uid、token
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
               [XHQAuxiliary alertWithTitle:@"温馨提示" message:@"使用新浪账号登录成功" button:0 done:nil
                ];
                
                if(self.LoginSuccess)
                {
                    self.LoginSuccess();
                }
            }];
        }});

    
}
- (IBAction)qq:(id)sender {
    
    UMSocialSnsPlatform * snsPlatform= [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //   获取微博用户名、uid、token
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
                [XHQAuxiliary alertWithTitle:@"温馨提示" message:@"使用QQ登录成功" button:0 done:nil];
                
                if(self.LoginSuccess)
                {
                    self.LoginSuccess();
                }
            }];
        }});
    

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.passwords resignFirstResponder];
}
@end



// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com