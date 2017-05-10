//
//  UIViewController+MessageKit.m
//  YueduFM
//
//  Created by StarNet on 9/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "UIViewController+MessageKit.h"

@interface MessageView : UIView
@property (nonatomic, assign) IBOutlet UILabel* messageLabel;
@end


@implementation MessageView

@end

@implementation UIViewController (MessageKit)
CATEGORY_PROPERTY_GET_SET(MessageView*, messageView, setMessageView:)


- (void)showWithSuccessedMessage:(NSString* )message {
    MessageView* view = [MessageView viewWithNibName:@"SuccessedMessageView"];
    view.messageLabel.text = message;
    view.left = 0;
    view.width = self.view.width;
    [self.messageView removeFromSuperview];
    self.messageView = view;
    [self.view addSubview:view];
    [self showMessageView:view];
}

- (void)showWithFailedMessage:(NSString* )message {
    MessageView* view = [MessageView viewWithNibName:@"FailedMessageView"];
    view.messageLabel.text = message;
    view.width = self.view.width;
    [self.messageView removeFromSuperview];
    self.messageView = view;
    [self.view addSubview:view];
    [self showMessageView:view];
}

- (void)showMessageView:(MessageView* )view {
    @synchronized(self) {
        view.top -= view.height;
        [UIView animateWithDuration:0.3f animations:^{
            view.top = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3f delay:2.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                view.top -= view.height;
            } completion:^(BOOL finished) {
            }];
        }];
    }
}
@end
