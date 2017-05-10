//
//  UIViewController+MessageKit.h
//  YueduFM
//
//  Created by StarNet on 9/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageView;
@interface UIViewController (MessageKit)

@property (nonatomic, strong) MessageView* messageView;

- (void)showWithSuccessedMessage:(NSString* )message;
- (void)showWithFailedMessage:(NSString* )message;

@end
