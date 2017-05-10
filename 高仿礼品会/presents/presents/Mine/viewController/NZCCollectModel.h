//
//  NZCCollectModel.h
//  presents
//
//  Created by dllo on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "BaseModel.h"

@interface NZCCollectModel : BaseModel

@property (nonatomic, copy) NSString *cover_image_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *favorites_count;
@property (nonatomic, copy) NSString *purchase_url;
@property (nonatomic, strong) NSArray *image_urls;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *descriptions;


@end
