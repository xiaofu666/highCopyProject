//
//  EquipSelectDetailsItemCustomImageView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipSelectDetailsItemCustomImageView.h"

@interface EquipSelectDetailsItemCustomImageView ()

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@end

@implementation EquipSelectDetailsItemCustomImageView

-(void)dealloc{
    
    [_titleLabel release];
    
    [_title release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
        [self addSubview:_titleLabel];
        
        
    }
    
    return self;
}


-(void)setTitle:(NSString *)title{
    
    if (_title != title) {
        
        [_title release];
        
        _title = [title retain];
        
    }
    
    //添加数据
    
    _titleLabel.text = title;
    
}


@end
