//
//  XyGiftModel.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "BaseModel.h"
#import "XyGiftCollectionModel.h"

@interface XyGiftModel : BaseModel

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *sub;
//@property (strong, nonatomic) XyGiftCollectionModel *collectionModel;


@end
