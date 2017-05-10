//
//  FilterMenuModel.m
//  筛选栏封装
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FilterMenuModel.h"

@implementation FilterMenuModel

-(void)dealloc{
    
    [_menuDic release];
    
    [_menuTitle release];
    
    [super dealloc];
    
}

@end
