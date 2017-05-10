//
//  AboutViewController.m
//  YueduFM
//
//  Created by StarNet on 10/12/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController () <UIScrollViewDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = LOC(@"settings_about");
    
    NSString* URLString = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:URLString encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    self.webView.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
