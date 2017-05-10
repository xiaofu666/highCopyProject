//
//  ExpandObject.m
//  YueduFM
//
//  Created by StarNet on 9/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ExpandObject.h"

@implementation ExpandObject

+ (instancetype)objectWithModel:(id)model {
    ExpandObject* object = [[ExpandObject alloc] init];
    object.model = model;
    return object;
}

@end
