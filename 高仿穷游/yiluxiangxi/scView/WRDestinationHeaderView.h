//
//  WRDestinationHeaderView.h
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRDestinationHeaderView : UIView<UIScrollViewDelegate>
@property(nonatomic,assign) int imageArrCount;
-(void)reloadDataWithArray:(NSArray* )array;

-(void) stopTimer;

@end
