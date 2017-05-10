//
//  UIView+MJAlertView.h
//  LXAlertView
//
//  Created by HarrisHan on 2/16/15.
//  Copyright (c) 2015 Persource. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LXAlertView)

+ (void) addLXNotifierWithText : (NSString* ) text dismissAutomatically : (BOOL) shouldDismiss;

+ (void) dismissLXNotifier;

@end
