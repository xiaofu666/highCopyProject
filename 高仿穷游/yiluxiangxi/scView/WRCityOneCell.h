//
//  WRCityOneCell.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCityAppModel.h"
@protocol WRCityOneCellDelegate <NSObject>
-(void)sendControl:(UIControl*)control;
@end
@interface WRCityOneCell : UITableViewCell
@property (nonatomic,assign) NSInteger imageArrCount;
@property (nonatomic,assign) id <WRCityOneCellDelegate> delegate;
-(void)showAppModel:(WRCityAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath;
@end
