//
//  MyHeroTableViewHeaderView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MyHeroTableViewHeaderView.h"

#import "PCH.h"

@interface MyHeroTableViewHeaderView ()


@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UILabel *descLabel;//描述

@end

@implementation MyHeroTableViewHeaderView

-(void)dealloc {
    
    [_titleLabel release];
    
    [_descLabel release];
    
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = MAINCOLOER;
        
        //初始化标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.frame) - 20, 15)];
        
        _titleLabel.font = [UIFont systemFontOfSize:12];
        
        _titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_titleLabel];
        
        //初始化描述
        
        _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.frame) - 20, 15)];
        
        _descLabel.font = [UIFont systemFontOfSize:12];
        
        _descLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        
        _descLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_descLabel];
        
    }
    return self;
}

//添加数据

- (void)addData{
    
    if (self.serverFullName != nil && self.heroCount != 0 && self.heroGoldPrice != 0) {
        
        _titleLabel.text = [NSString stringWithFormat:@"英雄资产(%@)",self.serverFullName];
        
        _descLabel.text = [NSString stringWithFormat:@"您总共有%ld个英雄,价值%ld金币",(long)self.heroCount , (long)self.heroGoldPrice];
        
    }
    
}


@end
