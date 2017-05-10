//
//  UMSocialScrShoter.h
//  SocialSDK
//
//  Created by yeahugo on 13-11-18.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MPMoviePlayerController;

/**
 截图对象基类
 
 */
@interface UMSocialScreenShoter  : NSObject

/**
 得到截图对象
 
 @return 截图对象
 */
+(UMSocialScreenShoter *)screenShoter;

/**
 得到截图图片
 
 */
-(UIImage *)getScreenShot;
@end

/**
 一般应用使用的截图类
 
 */
@interface UMSocialScreenShoterDefault : UMSocialScreenShoter

@end


/**
 使用iOS 系统的Media Player播放器播放视频，所用的截屏对象
 
 */
@interface UMSocialScreenShoterMediaPlayer : UMSocialScreenShoter

+(UMSocialScreenShoter *)screenShoterFromMoviePlayer:(MPMoviePlayerController *)player;

@end

/**
 cocos2d游戏所用的截屏对象
 
 */
@interface UMSocialScreenShoterCocos2d : UMSocialScreenShoter

+(UMSocialScreenShoter *)screenShoterFromEaglView:(UIView *)eaglview;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com