//
//  FAQViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FAQViewController.h"

#import "DownloadDynamicEffectView.h"

@interface FAQViewController ()

@property (nonatomic , retain ) DownloadDynamicEffectView *testView;

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常见问题";
    
    _testView = [[DownloadDynamicEffectView alloc]initWithFrame:CGRectMake(0, 100 , CGRectGetWidth(self.view.frame), 100)];
    
    _testView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [self.view addSubview:_testView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
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
