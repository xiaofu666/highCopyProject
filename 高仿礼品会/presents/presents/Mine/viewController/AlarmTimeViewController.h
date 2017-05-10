//
//  AlarmTimeViewController.h
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alarmTimeDelegate <NSObject>

- (void)passText:(NSString *)text;

@end

@interface AlarmTimeViewController : UIViewController
@property (nonatomic, assign) id<alarmTimeDelegate> timeDelegate;
@property (nonatomic, strong) NSArray *array;

@end
