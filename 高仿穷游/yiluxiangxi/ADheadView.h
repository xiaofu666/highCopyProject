//
//  ADheadView.h
//  风行电影
//
//  Created by 唐僧 on 15/10/26.
//  Copyright (c) 2015年 于延宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADheadViewDelegate <NSObject>

-(void)sendADheaderViewBtn:(UIButton* )btn;

@end

@interface ADheadView : UICollectionReusableView <UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,assign) id<ADheadViewDelegate> delegate;
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UIPageControl* pageControl;


@end
