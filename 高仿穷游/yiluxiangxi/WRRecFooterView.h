//
//  WRRecFooterView.h
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WRRecFooterViewDelegate <NSObject>

-(void)sendBtnTitle:(UIButton* )btn;

@end

@interface WRRecFooterView : UICollectionReusableView

@property(nonatomic,assign) id<WRRecFooterViewDelegate> delegate;

@property(nonatomic,strong) UIButton* footBtn;

@end
