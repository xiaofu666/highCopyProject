//
//  ModalViewController.m
//  Popping
//
//  Created by André Schneider on 16.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "ModalViewController.h"

#import "PCH.h"

@interface ModalViewController()

- (void)addDismissButton;

- (void)dismiss:(id)sender;

@end

@implementation ModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 8.f;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.clipsToBounds = YES;
    
    //添加自定义视图
    
    [self addCustomView];
    
    [self addDismissButton];
}

#pragma mark - Private Instance methods

- (void)addDismissButton
{
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor grayColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:@"关 闭" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dismissButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[dismissButton]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dismissButton)]];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - addCustomView

- (void)addCustomView{
    
    if (_addView != nil) {
        
        _addView.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]) /4 * 3 , CGRectGetHeight([[UIScreen mainScreen] bounds]) / 5 * 3 - 40);
        
        [self.view addSubview:_addView];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_addView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.f
                                                               constant:0.f]];
        
    }
    
}



#pragma mark ---设置电池条前景部分样式类型 (白色)

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}






@end
