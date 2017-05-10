//
//  AddAlarmViewController.h
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddAlarmViewControllerDelegate <NSObject>

- (void)passAlarm:(NSMutableDictionary *)alarm;

@end

@interface AddAlarmViewController : UIViewController
@property (nonatomic, copy  ) NSString    *timeText;
@property (nonatomic, copy  ) NSString    *repeatText;
@property (nonatomic, copy  ) NSString    *dataText;
@property (nonatomic, strong) UITextField *event;
@property (nonatomic, strong) UITextField *notes;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *idEvent;
@property (nonatomic, assign) id<AddAlarmViewControllerDelegate> addDelegate;
@end
