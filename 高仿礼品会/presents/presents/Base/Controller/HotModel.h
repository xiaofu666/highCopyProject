//
//  HotModel.h
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "BaseModel.h"

@interface HotModel : BaseModel

@property (nonatomic, strong) NSString *cover_image_url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSNumber *favorites_count;
@property (nonatomic, strong) NSString *descriptions;

@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *purchase_url;
@property (nonatomic, strong) NSString *likes_count;

@property (nonatomic, strong) NSArray *image_urls;

@property (nonatomic, strong) NSString *url;


@end
