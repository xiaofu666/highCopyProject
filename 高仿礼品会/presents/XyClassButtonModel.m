//
//  XyClassButtonModel.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyClassButtonModel.h"

@implementation XyClassButtonModel

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"channels"]) {
        NSArray *array = value;
        NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            ButtonArrayModel *model = [[ButtonArrayModel alloc] initWithDictionary:dic];
            [dataSource addObject:model];
        }
        self.chan = [NSArray arrayWithArray:dataSource];
    }
}
@end
