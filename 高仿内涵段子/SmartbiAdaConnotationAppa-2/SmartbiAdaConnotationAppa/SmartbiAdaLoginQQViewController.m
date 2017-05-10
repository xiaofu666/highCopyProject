//
//  SmartbiAdaLoginQQViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/4/28.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaLoginQQViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "AFNetworking.h"
#import "SmartbiAdaPerson.h"
#import "SmartbiAdaPerson+SmartbiAdaDatabaseOperation.h"



#define URL @"https://graph.qq.com/user/get_user_info"
/*
https://graph.qq.com/user/get_user_info?
access_token=*************&
oauth_consumer_key=12345&
openid=****************
*/

@interface SmartbiAdaLoginQQViewController ()<TencentSessionDelegate>
{
    TencentOAuth *_tencentOAuth;
    NSMutableArray *_permission;
    
}
- (IBAction)loginQQ:(id)sender;
- (IBAction)back:(id)sender;

@end

@implementation SmartbiAdaLoginQQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *openapi = @"1103297850";//demo中可以使用地1103297850
    //我自己申请的APP ID： 1105291455  tencent1105291455，别人的APP ID： 1103297850 tencent1103297850
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:openapi andDelegate:self];
}

- (void)tencentDidNotNetWork
{
    NSLog(@"没有网络");
}
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"登录失败");
}

- (void)tencentDidLogin
{
    NSLog(@"登录成功");
    NSLog(@"token===%@",[_tencentOAuth accessToken] );
    NSLog(@"openId===%@",[_tencentOAuth openId]) ;
    NSLog(@"appid === %@",[_tencentOAuth appId]);
    [self fetchDataFromServer];
    
}
-(void)fetchDataFromServer{
    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
    man.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *str=URL;
    NSDictionary *dic=@{@"access_token":[_tencentOAuth accessToken],@"oauth_consumer_key":[_tencentOAuth appId],@"openid":[_tencentOAuth openId]};
    [man GET:str  parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        SmartbiAdaPerson *person=[SmartbiAdaPerson initWithDictionry:dict WithOnLine:dic];
        [SmartbiAdaPerson deleteAllComplection:^(BOOL results) {
            
        }];
        [person saveToDatabaseComplection:^(BOOL ret) {
            if (ret == YES) {
                NSLog(@"有用户数据了.");
            } else {
                NSLog(@"用户数据出错，再登录一次。");
            }
        }];
       
//        NSLog(@"用户信息：%@",dict);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
- (IBAction)loginQQ:(id)sender {
    _permission = [NSMutableArray arrayWithObjects:kOPEN_PERMISSION_GET_USER_INFO, nil];
    [_tencentOAuth authorize:_permission inSafari:NO];
    
}

- (IBAction)back:(id)sender {
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
