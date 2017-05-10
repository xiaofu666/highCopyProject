//
//  DownloadDataBaseManager.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "DownloadDataBaseManager.h"

@implementation DownloadDataBaseManager

+ (DownloadDataBaseManager *)shareDownloadDataBaseManager{
    
    static DownloadDataBaseManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[DownloadDataBaseManager alloc]init];
        
    });
    
    return manager;
    
}

















@end
