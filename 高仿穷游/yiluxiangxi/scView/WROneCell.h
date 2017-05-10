//
//  WROneCell.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRDestinationAppModel.h"
@protocol WROneCellDelegate <NSObject>

-(void)sendControl:(UIControl*)control;

@end

@interface WROneCell : UITableViewCell

@property(nonatomic,assign) id<WROneCellDelegate> delegate;
-(void)showAppModel:(WRDestinationAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath;

@end
