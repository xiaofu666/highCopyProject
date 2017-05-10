//
//  MessageKit.h
//  YueduFM
//
//  Created by StarNet on 9/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+MessageKit.h"

@interface MessageKit : NSObject

+ (void)showWithSuccessedMessage:(NSString* )message;
+ (void)showWithFailedMessage:(NSString* )message;

@end
