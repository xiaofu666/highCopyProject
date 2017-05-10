//
//  AppDelegate.h
//  DouYU
//
//  Created by Alesary on 15/10/29.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL _isFull; // 是否全屏
}

@property (nonatomic)BOOL isFull;

@property (strong, nonatomic) UIWindow *window;


@property(nonatomic,strong)NSMutableArray *Array;


@end

