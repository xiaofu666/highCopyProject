//
//  GearPowered.h
//  
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol GearPoweredDelegate <NSObject>

- (void)didLoadData:(id)data;

@optional

- (NSURL *)settingBottomLoadDataURL;

- (void)didBottomLoadData:(id)data;

@end

@interface GearPowered : NSObject

@property (nonatomic , retain)UIScrollView *scrollView;//滑动视图

@property (nonatomic , retain) NSURL *url;//请求的URL

@property (nonatomic , retain) NSURL *bottomUrl;//底部刷新请求的URL

@property (nonatomic , assign) BOOL isAuxiliaryGear;//是否在加载时显示辅助齿轮(默认为NO)

@property (nonatomic , assign) id<GearPoweredDelegate> delegate;//代理对象



//正在滑动

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;

//滑动停止

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

//停止加载

-(void)stopLoading;


@end
