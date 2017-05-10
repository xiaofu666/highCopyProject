//
//  UIResponder+UIResponder_Router.m
//  QQ
//
//  Created by weida on 15/8/19.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

-(void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithType:eventType userInfo:userInfo];
}


@end
