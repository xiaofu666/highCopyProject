//
//  AlarmClockViewController.h
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmClockViewController : UIViewController<UIAlertViewDelegate,UIApplicationDelegate>
+ (void)registerLocalNotification:(NSInteger)alertTime withArray:(NSMutableArray *)array;

+ (void)cancelLocalNotificationWithKey:(NSString *)key;

@end
