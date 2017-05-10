//
//  BaseModel.h
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, strong) NSString *nId;


- (instancetype)initWithDictionary:(NSDictionary *)dataSource;

@end
