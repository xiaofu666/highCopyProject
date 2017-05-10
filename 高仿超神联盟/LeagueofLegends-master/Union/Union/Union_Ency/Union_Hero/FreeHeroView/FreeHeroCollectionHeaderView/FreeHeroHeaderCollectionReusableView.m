//
//  FreeHeroHeaderCollectionReusableView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FreeHeroHeaderCollectionReusableView.h"

@implementation FreeHeroHeaderCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, 15)];
        
        _titleLabel.textColor = [UIColor lightGrayColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_titleLabel];
        
    }
    return self;
}

-(void)dealloc{
    
    [_titleLabel release];
    
    [super dealloc];
    
}

@end
