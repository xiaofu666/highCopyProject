//
//  RepeatViewController.h
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RepeatViewControllerDelegate <NSObject>

- (void)passRepeat:(NSString *)text;

@end
@interface RepeatViewController : UIViewController
@property (nonatomic, assign) id<RepeatViewControllerDelegate> repeatDelegate;
@end
