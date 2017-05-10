//
//  BaseViewController.h
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, strong) NSString* emptyString;
- (UIView* )emptyContainer;

@end
