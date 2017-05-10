//
//  ExpandObject.h
//  YueduFM
//
//  Created by StarNet on 9/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpandObject : NSObject

+ (instancetype)objectWithModel:(id)model;

@property (nonatomic, strong) id model;

@end
