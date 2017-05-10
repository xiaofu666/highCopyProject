//
//  LXPlaySound.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>

@interface LXPlaySound : NSObject


{
    SystemSoundID soundID;
    
}

/**
 
 *@brief为播放震动效果初始化
 
 *
 
 *@return self
 
 */


-(id)initForPlayingVibrate;

/**
 
 *@brief为播放系统音效初始化(无需提供音频文件)
 
 *
 
 *@param resourceName 系统音效名称
 
 *@param type 系统音效类型
 
 *
 
 *@return self
 
 */

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;

/**
 
 *@brief为播放特定的音频文件初始化（需提供音频文件）
 
 *
 
 *@param filename 音频文件名（加在工程中）
 
 *
 
 *@return self64 65*/

-(id)initForPlayingSoundEffectWith:(NSString *)filename;

/**
 
 *@brief播放音效
 
 */

-(void)play;





@end
