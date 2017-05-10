//
//  WebViewController.h
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "DZNWebViewController.h"

@interface WebViewController : DZNWebViewController

+ (instancetype)controllerWithURL:(NSURL* )url didDisappear:(void(^)())disappear;

+ (void)presentWithURL:(NSURL* )url;

@end
