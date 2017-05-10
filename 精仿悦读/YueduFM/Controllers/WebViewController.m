//
//  WebViewController.m
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, copy) void(^viewDidDisappearBlock)();

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)controllerWithURL:(NSURL* )url didDisappear:(void(^)())disappear {
    if (!url) return nil;
    WebViewController* wvc = [[WebViewController alloc] initWithURL:url];
    wvc.supportedWebNavigationTools = DZNWebNavigationToolAll;
    wvc.supportedWebActions = DZNWebActionAll;
    wvc.showLoadingProgress = YES;
    wvc.allowHistory = YES;
    wvc.hideBarsWithGestures = YES;
    wvc.viewDidDisappearBlock = disappear;
    return wvc;
}

+ (void)presentWithURL:(NSURL* )url {
    ReachabilityService* service = SRV(ReachabilityService);
    if (service.status == NotReachable) {
        [SVProgressHUD showInfoWithStatus:service.statusString];
    } else {
        BOOL hidden = [PlayerBar shareBar].forceHidden;
        [[PlayerBar shareBar] setForceHidden:YES];
        [[UIViewController topViewController].navigationController pushViewController:[WebViewController controllerWithURL:url didDisappear:^{
            if (!hidden) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[PlayerBar shareBar] setForceHidden:NO];
                });
            }
        }] animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock();
    }
}

@end
