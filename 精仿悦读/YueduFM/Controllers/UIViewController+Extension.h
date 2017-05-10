//
//  UIViewController+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/26/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

+ (UIViewController* )topViewController;

+ (void)showActivityWithURL:(NSURL* )url completion:(void (^)(void))completion;

- (void)showActivityWithURL:(NSURL* )url completion:(void (^)(void))completion;

@end
