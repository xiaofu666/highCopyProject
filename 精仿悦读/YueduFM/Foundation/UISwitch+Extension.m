//
//  UISwitch+Extension.m
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "UISwitch+Extension.h"

@implementation UISwitch (Extension)

+ (instancetype)switchWithOn:(BOOL)on action:(void(^)(BOOL isOn))action {
    UISwitch* sw = [[UISwitch alloc] init];
    [sw bk_addEventHandler:^(id sender) {
        if (action) action(sw.isOn);
    } forControlEvents:UIControlEventValueChanged];
    sw.on = on;
    return sw;
}

@end
