//
//  EquipDetailsModel.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/5.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipDetailsModel.h"

@implementation EquipDetailsModel

-(void)dealloc{
    
    [_name release];
    
    [_need release];
    
    [_compose release];
    
    [_equipDescription release];
    
    [_extAttrs release];
    
    [_needArray release];
    
    [_composeArray release];
    
    [super dealloc];
    
}

-(void)setNeed:(NSString *)need{
    
    if (_need != need) {
        
        [_need release];
        
        _need = [need retain];
        
    }
    
    //处理数据
    
    _needArray = [[need componentsSeparatedByString:@","] retain];

}

-(void)setCompose:(NSString *)compose{
    
    if (_compose != compose) {
        
        [_compose release];
        
        _compose = [compose retain];
        
    }
    
    //处理数据
    
    _composeArray = [[compose componentsSeparatedByString:@","] retain];
    
}




@end
