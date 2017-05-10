//
//  WRTwoCell.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRDestinationAppModel.h"
@interface WRTwoCell : UITableViewCell
-(void)showAppModel:(WRDestinationAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath;

@end
