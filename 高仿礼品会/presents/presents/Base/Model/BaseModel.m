//
//  BaseModel.m
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dataSource
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dataSource];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.nId = value;
    }
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
