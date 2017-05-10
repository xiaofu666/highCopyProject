//
//  MessageKit.m
//  YueduFM
//
//  Created by StarNet on 9/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "MessageKit.h"

@implementation MessageKit

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

+ (void)showWithSuccessedMessage:(NSString* )message {
    [[self topViewController] showWithSuccessedMessage:message];
}

+ (void)showWithFailedMessage:(NSString* )message {
    [[self topViewController] showWithFailedMessage:message];
}
@end
