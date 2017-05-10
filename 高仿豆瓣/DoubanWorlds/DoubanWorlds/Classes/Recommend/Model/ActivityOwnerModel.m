//
//  ActivityOwnerModel.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "ActivityOwnerModel.h"

@implementation ActivityOwnerModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        if (dic[@"id"]) {
            self.ID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        }
    }
    return self;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(id)valueForKeyPath:(NSString *)keyPath
{
    return nil;
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com