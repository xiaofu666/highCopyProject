//
//  UINavigationItem+Extension.m
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "UINavigationItem+Extension.h"

@implementation UINavigationItem (Extension)

- (void)customBackBarButton:(id)target action:(SEL)action {
    UIButton *lBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [lBtn setImage:[UIImage imageNamed:@"nav_icon_back.png"] forState:UIControlStateNormal];
    [lBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lItem = [[UIBarButtonItem alloc] initWithCustomView:lBtn];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -10;
    self.leftBarButtonItems = [NSArray arrayWithObjects:space, lItem, nil];
}

@end
