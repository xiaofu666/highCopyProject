//
//  WRCityTwoCell.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCityAppModel.h"
@interface WRCityTwoCell : UITableViewCell
-(void)showAppModel:(WRCityAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath;
@end
