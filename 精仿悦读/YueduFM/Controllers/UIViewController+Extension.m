//
//  UIViewController+Extension.m
//  YueduFM
//
//  Created by StarNet on 9/26/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "DZNPolyActivity.h"

@implementation UIViewController (Extension)

+ (UIViewController* )topViewController {
    UIViewController* vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    while (1) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController* )vc topViewController];
            continue;
        } else if ([vc isKindOfClass:[RESideMenu class]]) {
            vc = [(RESideMenu* )vc contentViewController];
            continue;
        }
        break;
    }
    return vc;
}

+ (void)showActivityWithURL:(NSURL* )url completion:(void (^)(void))completion {
    [[self topViewController] showActivityWithURL:url completion:completion];
}

- (void)showActivityWithURL:(NSURL* )url completion:(void (^)(void))completion {
    if (url) {
        NSArray* activityItems = @[url];
        
        UIActivityViewController *activityVC = \
        [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                          applicationActivities:nil];
        
        activityVC.excludedActivityTypes = @[UIActivityTypePrint,
                                             UIActivityTypeAssignToContact,
                                             UIActivityTypeSaveToCameraRoll,
                                             UIActivityTypeAddToReadingList,
                                             UIActivityTypePostToFlickr,
                                             UIActivityTypePostToVimeo];
        
        [self presentViewController:activityVC animated:TRUE completion:nil];
    }
}

@end
