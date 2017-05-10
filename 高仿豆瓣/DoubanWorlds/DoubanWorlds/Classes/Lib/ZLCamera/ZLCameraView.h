//
//  BQCameraView.h
//  carame
//
//  Created by ZL on 14-9-24.
//  Copyright (c) 2014年 beiqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLCameraView;

@protocol ZLCameraViewDelegate <NSObject>

@optional
- (void) cameraDidSelected : (ZLCameraView *) camera;

@end

@interface ZLCameraView : UIView

@property (weak, nonatomic) id <ZLCameraViewDelegate> delegate;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com