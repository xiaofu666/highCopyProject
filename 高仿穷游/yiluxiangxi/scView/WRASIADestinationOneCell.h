//
//  WRASIADestinationOneCell.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRDestinationCountryAppModel.h"

@protocol WRASIADestinationOneCellDelegate <NSObject>
-(void)sendControl:(UIControl*)control;
@end

@interface WRASIADestinationOneCell : UITableViewCell

@property (nonatomic,assign) NSInteger imageArrCount;
-(void)showAppModel:(WRDestinationCountryAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath;
@property (nonatomic,assign) id <WRASIADestinationOneCellDelegate>delegate;
@end
