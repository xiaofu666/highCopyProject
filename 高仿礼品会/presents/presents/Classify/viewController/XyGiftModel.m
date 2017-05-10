//
//  XyGiftModel.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyGiftModel.h"

@implementation XyGiftModel
- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"subcategories"]) {
        NSArray *array = value;
        NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            XyGiftCollectionModel *model = [[XyGiftCollectionModel alloc] initWithDictionary:dic];
            [dataSource addObject:model];
        }
        self.sub = [NSArray arrayWithArray:dataSource];
    }
}
@end


