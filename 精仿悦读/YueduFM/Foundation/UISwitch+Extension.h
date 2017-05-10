//
//  UISwitch+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (Extension)

+ (instancetype)switchWithOn:(BOOL)on action:(void(^)(BOOL isOn))action;

@end
