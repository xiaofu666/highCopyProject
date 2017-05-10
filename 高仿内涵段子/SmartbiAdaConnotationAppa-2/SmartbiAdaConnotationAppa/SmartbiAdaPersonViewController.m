//
//  SmartbiAdaPersonViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/16.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaPersonViewController.h"

@interface SmartbiAdaPersonViewController ()
- (IBAction)back:(id)sender;
- (IBAction)setting:(id)sender;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *beijing;

@end

@implementation SmartbiAdaPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor=[UIColor redColor];
    self.beijing.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginTap)];
    [self.beijing addGestureRecognizer:tap];
}
-(void)loginTap{
    NSLog(@"真高兴。可以写登录的内容了。");
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

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setting:(id)sender {
}

- (IBAction)login:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    self.tabBarController.selectedIndex=3;
//    NSLog(@"asdgasdg");
}
@end
