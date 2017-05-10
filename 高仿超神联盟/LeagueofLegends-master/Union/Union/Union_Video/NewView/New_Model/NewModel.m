//
//  NewModel.m
//  Union
//
//  Created by lanou3g on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "NewModel.h"

@implementation NewModel

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];


}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{



}

-(void)dealloc{

    [_cover_url release];
    
    [_video_length release];
    
    [_vid release];
    
    [_upload_time release];
    
    [_title release];
    
    [super dealloc];


}












@end
