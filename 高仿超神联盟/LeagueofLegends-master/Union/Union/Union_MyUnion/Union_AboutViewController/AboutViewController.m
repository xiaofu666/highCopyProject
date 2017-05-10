//
//  AboutViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic , retain ) UIImageView *picImageView;

@property (nonatomic , retain ) UILabel *titleLabel;//标题Label

@property (nonatomic , retain ) UILabel *versionLabel;//版本Label

@property (nonatomic , retain ) UILabel *copyrightLabel;//版权Label


@end

@implementation AboutViewController

-(void)dealloc{
    
   
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于";
    
    
    //初始化视图控件
    
    [self initViews];
    
}

#pragma mark ---初始化视图控件

- (void)initViews{
    
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 20 , 200 , 200)];
    
    _picImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2 , _picImageView.center.y);
    
    _picImageView.backgroundColor = [UIColor clearColor];
    
    _picImageView.image = [UIImage imageNamed:@"aboutlogo"];
    
    [self.view addSubview:_picImageView];
    
    //初始化标题Label
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 200 , CGRectGetWidth(self.view.frame) - 20 , 30)];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.textColor = [UIColor grayColor];
    
    _titleLabel.text = @"超神联盟";
    
    _titleLabel.font = [UIFont systemFontOfSize:20];
    
    [self.view addSubview:_titleLabel];
    
    //初始化版本Label
    
    _versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 230 , CGRectGetWidth(self.view.frame) - 20 , 30)];
    
    _versionLabel.textAlignment = NSTextAlignmentCenter;
    
    _versionLabel.textColor = [UIColor grayColor];
    
    _versionLabel.text = @"V1.0.0";
    
    _versionLabel.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:_versionLabel];

    
    //初始化版权Label
    
    _copyrightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , CGRectGetHeight(self.view.frame) - 113 , CGRectGetWidth(self.view.frame) - 20 , 30)];
    
    _copyrightLabel.textAlignment = NSTextAlignmentCenter;
    
    _copyrightLabel.textColor = [UIColor grayColor];
    
    _copyrightLabel.text = @"Copyright © 2015 LiXiang. All Rights Reserved.";
    
    _copyrightLabel.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:_copyrightLabel];
    
    
    
    [_picImageView release];
    
    [_titleLabel release];
    
    [_versionLabel release];
    
    [_copyrightLabel release];

    
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
