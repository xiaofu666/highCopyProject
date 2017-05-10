//
//  SettingManager.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingManager : NSObject

+(SettingManager *)shareSettingManager;

//根据设置类型加载图片 (所有网络,仅WiFi等..)

-(BOOL)loadImageAccordingToTheSetType;

//根据设置类型播放提示声效

-(void)playSoundAccordingToTheSetType;

//设置下载气泡视图显示与隐藏 (YES为隐藏 NO为显示)

-(void)downloadViewHiddenOrShow:(BOOL)isHidden;





@end
