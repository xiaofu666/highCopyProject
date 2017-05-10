//
//  WRCityAppModel.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRCityAppModel : NSObject
@property (nonatomic,copy) NSString* cnname;
@property (nonatomic,copy) NSString* enname;
@property (nonatomic,copy) NSString* entryCont;
@property (nonatomic,strong) NSArray* photos;
@property (nonatomic,strong) NSArray* local_discount;
@property (nonatomic,strong) NSArray* New_discount;

@end
