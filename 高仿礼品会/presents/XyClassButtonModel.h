//
//  XyClassButtonModel.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "BaseModel.h"
#import "ButtonArrayModel.h"
@interface XyClassButtonModel : BaseModel
@property (copy, nonatomic) NSArray *chan;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) ButtonArrayModel *buttonModel;

@end
