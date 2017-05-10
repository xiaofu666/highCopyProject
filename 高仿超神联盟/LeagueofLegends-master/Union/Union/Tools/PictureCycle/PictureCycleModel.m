//
//  PictureCycleModel.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "PictureCycleModel.h"

@implementation PictureCycleModel

-(void)dealloc{
    
    [_pid release];
    
    [_photoUrl release];
    
    [_picTitle release];
    
    [super dealloc];
    
}

@end
