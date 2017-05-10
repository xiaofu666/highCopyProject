//
//  HotModel.m
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.descriptions = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}

@end
