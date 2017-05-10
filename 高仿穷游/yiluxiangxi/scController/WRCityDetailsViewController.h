//
//  WRCityDetailsViewController.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRCityDetailsViewController : UIViewController
@property (nonatomic,copy) NSString* city_id;
-(void)loadRequestInfo;
@end
