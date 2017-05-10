//
//  UIBarButtonItem+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(UIImage* )image action:(void(^)())action;

@end
