//
//  PictureCycleItem.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "PictureCycleItem.h"

#import <UIImageView+WebCache.h>


@interface PictureCycleItem ()

@property (nonatomic , retain ) UIImageView *imageView;//图片

@property (nonatomic , retain ) UILabel *titleLabel;//标题标签

@end

@implementation PictureCycleItem

- (void)dealloc {
    
    [_model release];
    
    [_imageView release];
    
    [_titleLabel release];
    
    [super dealloc];
    
}

//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //初始化图片
        
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lollogo"]];
        
        
        
        [self addSubview:_imageView];
        
        //初始化标题标签
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 45 , CGRectGetWidth(self.frame), 30)];
        
        _titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;

        [self addSubview:_titleLabel];
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    if (_titleLabel != nil) {
        
        _titleLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 45 , CGRectGetWidth(self.frame), 30);
        
    }
    
}

//获取数据

-(void)setModel:(PictureCycleModel *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
    }
    
    //处理数据
    
    if (model != nil) {
        
        //SDWebImage加载图片
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"lollogo"]];
        
        if (model.picTitle != nil) {
            
            _titleLabel.hidden = NO;
            
            _titleLabel.text = model.picTitle;
            
        } else {
            
            _titleLabel.hidden = YES;
            
        }
        
        
    }
    
    
    
}


@end
