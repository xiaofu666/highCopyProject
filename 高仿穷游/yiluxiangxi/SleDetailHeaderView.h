//
//  SleDetailHeaderView.h
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/7.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SleDetailHeaderViewDelegate <NSObject>

-(void)downloandSleeve:(UIButton* )btn;

@end
@interface SleDetailHeaderView : UIView

@property(nonatomic,strong) UIImageView* imageHeader;
@property(nonatomic,strong) UIButton* downlondBtn;
@property(nonatomic,strong) UIProgressView* progress;
@property(nonatomic,assign) id<SleDetailHeaderViewDelegate> delegate;

@end
