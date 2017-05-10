//
//  LXPlaySound.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "LXPlaySound.h"

@implementation LXPlaySound


#pragma mark ---震动

-(id)initForPlayingVibrate
{
    self = [super init];
    
    if (self) {
        
        soundID = kSystemSoundID_Vibrate;
        
    }
    
    return self;
}

#pragma mark ---系统音效

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type  {
    
    self = [super init];
    
    if (self) {
        
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        
        if (path) {
            
            SystemSoundID theSoundID;
            
            OSStatus error =AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            
            if (error == kAudioServicesNoError) {
                
                soundID = theSoundID;
                
            }else {
                
                NSLog(@"创建声音失败 ");
                
            }
            
        }
        
    }
    
    return self;
    
}

#pragma mark ---自定义音效

-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    
    self = [super init];
    
    if (self) {
        
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (fileURL != nil)
            
        {
            
            SystemSoundID theSoundID;
            
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            
            if (error == kAudioServicesNoError){
                
                soundID = theSoundID;
                
            }else {
                
                NSLog(@"创建声音失败");
                
            }
            
        }
        
    }
    
    return self;
    
}

#pragma mark ---播放音效

-(void)play
{
 
    AudioServicesPlaySystemSound(soundID);

}



-(void)dealloc
{
    
    [super dealloc];
    
    AudioServicesDisposeSystemSoundID(soundID);
    
}



@end
