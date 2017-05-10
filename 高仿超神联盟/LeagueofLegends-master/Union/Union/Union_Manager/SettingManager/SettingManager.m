//
//  SettingManager.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SettingManager.h"

#import "CoreStatus.h"

#import "LXPlaySound.h"

#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, SaveFlowSettingType) {
    
    SaveFlowSettingTypeAllNetWorking,
    
    SaveFlowSettingTypeOnlyWiFi,
    
    SaveFlowSettingTypeClose,
    
};

@implementation SettingManager



+(SettingManager *)shareSettingManager{
    
    static SettingManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SettingManager alloc]init];
        
    });
    
    return manager;
}

#pragma mark ---根据设置类型加载图片 (所有网络,仅WiFi等..)

-(BOOL)loadImageAccordingToTheSetType{
    
    //获取省流量设置选项下标 (0 -- 2)
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    SaveFlowSettingType type = [[defaults objectForKey:@"setting_saveflow_selectedindexpath"] integerValue];
    
    switch (type) {
            
        case SaveFlowSettingTypeAllNetWorking:
        {
            
            //所有网络
            
            return YES;
            
        }
            break;
            
        case SaveFlowSettingTypeOnlyWiFi:
        {
            
            //获取当前网络状态
            
            CoreNetWorkStatus currentStatus = [CoreStatus currentNetWorkStatus];
            
            //判断是否为WiFi网络
            
            if (currentStatus == CoreNetWorkStatusWifi) {
                
                return YES;
                
            } else {
                
                return NO;
            }
            
        }
            break;
            
        case SaveFlowSettingTypeClose:
        {
            
            //关闭图片加载
            
            return NO;
            
        }
            break;
            
        default:
        {
            
            return YES;
            
        }
            break;
            
    }

}

#pragma mark ---根据设置类型播放提示声效

-(void)playSoundAccordingToTheSetType{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //获取是否开启震动
    
    BOOL isVibration = [[defaults objectForKey:@""]boolValue];
    
    //获取是否开启声音
    
    BOOL isSound = [[defaults objectForKey:@""]boolValue];
    
    
    if (isVibration) {
        
        //开启震动
        
        LXPlaySound *lxplay = [[[LXPlaySound alloc] initForPlayingVibrate] autorelease];
        
        [lxplay play];
        
    }
    
    if (isSound) {
        
       //开启声音
        
        LXPlaySound *lxplay = [[[LXPlaySound alloc] initForPlayingSystemSoundEffectWith:@"Tock" ofType:@"caf"] autorelease];
        
        [lxplay play];
        
    }
    
}

#pragma mark ---设置下载气泡视图显示与隐藏 (YES为隐藏 NO为显示)

-(void)downloadViewHiddenOrShow:(BOOL)isHidden{
    
    if (isHidden) {
        
        //隐藏下载气泡
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        app.downloadView.hidden = YES;
        
    } else {
        
        //显示下载气泡
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        app.downloadView.hidden = NO;
        
    }
    
}


@end
