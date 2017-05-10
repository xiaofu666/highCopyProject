//
//  SmartbiAdaMeViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by mac on 16/3/30.
//  Copyright (c) 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaMeViewController.h"
#import "SmartbiAdaLoginQQViewController.h"
#import "SmartbiAdaPerson.h"
#import "SmartbiAdaPerson+SmartbiAdaDatabaseOperation.h"
#import "SmartbiAdaWriteViewController.h"


@interface SmartbiAdaMeViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginOut;
- (IBAction)login:(id)sender;
- (IBAction)loginTou:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView_jing;



@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *nameSay;
@property (strong,nonatomic) SmartbiAdaPerson *per;
- (IBAction)tougao:(id)sender;
- (IBAction)loginOut:(id)sender;

@end

@implementation SmartbiAdaMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
    [self.loginView setHidden:YES];
    [self.loginOut setHidden:NO];
  
    [self timer:nil];

    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timer:) userInfo:nil repeats:YES];
}
-(void)timer:(NSTimer *)time
{
//    NSLog(@"123");
    [SmartbiAdaPerson fetchApplicationsFromDatabaseComplection:^(NSArray *results) {
        if (results.count>0) {
             self.per=results[0];
        }
        else
        {
//            NSLog(@"没有登录");
        }
    }];
//    NSLog(@"self.nickname==%@",self.per.nickname);
    if(self.per.nickname.length > 0)
    {
        self.icon.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.per.figureurl_qq_1]]];
        self.name.text=self.per.nickname;
        self.nameSay.text=@"这个人很懒，什么也没有留下";
        if(self.per.msg.length > 0)
        {
            self.nameSay.text=self.per.msg;
        }
        [self.loginView setHidden:NO];
        [self.loginOut setHidden:YES];
    }
    else
    {
        // 结果在主线程中返回
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loginView setHidden:YES];
            [self.loginOut setHidden:NO];
            
        });
        
     
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SmartbiAdaPerson" object:nil];
   
}
- (IBAction)login:(id)sender {
    SmartbiAdaLoginQQViewController *loginQQVC=[[SmartbiAdaLoginQQViewController alloc]init];
    [self presentViewController:loginQQVC animated:YES completion:nil];
}

- (IBAction)loginTou:(id)sender {
    [self login:nil];
}
- (IBAction)tougao:(id)sender {
//    SmartbiAdaWriteViewController *write=[[SmartbiAdaWriteViewController alloc]init];
//    [self presentViewController:write animated:YES completion:nil];
}

- (IBAction)loginOut:(id)sender {
    [SmartbiAdaPerson deleteAllComplection:^(BOOL results) {
        if (results  == YES) {
            NSLog(@"成功退出");
        }
    }];
    self.per=nil;
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
