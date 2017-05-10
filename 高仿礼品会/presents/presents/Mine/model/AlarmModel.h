//
//  AlarmModel.h
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmModel : BaseModel
@property (nonatomic, copy) NSString *event;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, copy) NSString *repeat;
@end
