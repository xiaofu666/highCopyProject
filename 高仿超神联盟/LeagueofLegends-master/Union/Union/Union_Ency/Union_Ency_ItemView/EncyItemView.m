//
//  EncyItemView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EncyItemView.h"

@implementation EncyItemView

-(void)dealloc{
    
    [_imageView release];
    
    [_label release];
    
    [_model release];
    
    [super dealloc];
    
}

//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor] ;
        
        _imageView = [[UIImageView alloc]init];
        
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc]init];
        
        _label.textColor = [UIColor lightGrayColor];
        
        _label.textAlignment = NSTextAlignmentCenter;
        
        _label.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_label];
        
    }
    
    return self;
    
}

//设置frame

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(CGRectGetWidth(self.frame) / 7, CGRectGetWidth(self.frame) / 7, CGRectGetWidth(self.frame) / 7 * 5, CGRectGetWidth(self.frame)  / 7 * 5);
    
    self.label.frame = CGRectMake(0, CGRectGetWidth(self.frame)  / 7 * 6 , CGRectGetWidth(self.frame) , CGRectGetWidth(self.frame) / 7);
    
}

-(void)setModel:(EncyModel *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
    }

    //赋值数据
    
    self.imageView.image = [[UIImage imageNamed:model.iconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.label.text = model.name;
    
}



@end
