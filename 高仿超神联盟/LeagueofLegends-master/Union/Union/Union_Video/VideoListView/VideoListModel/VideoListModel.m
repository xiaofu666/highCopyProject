//
//  NewModel.m
//  Union
//
//  Created by lanou3g on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "VideoListModel.h"

@implementation VideoListModel



-(void)dealloc{

    [_cover_url release];
    
    [_video_length release];
    
    [_vid release];
    
    [_upload_time release];
    
    [_title release];
    
    [super dealloc];


}












@end
