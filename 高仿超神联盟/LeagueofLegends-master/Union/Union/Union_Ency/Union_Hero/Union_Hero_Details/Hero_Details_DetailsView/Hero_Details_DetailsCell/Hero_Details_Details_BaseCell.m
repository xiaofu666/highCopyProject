//
//  Hero_Details_Details_BaseCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/11.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_Details_BaseCell.h"



@implementation Hero_Details_Details_BaseCell

-(void)dealloc{
    
    [_rootView release];
    
    [_titleLabel release];
    
    [_titleView release];
    
    [_indexpath release];
    
    [_title release];
    
    [super dealloc];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetHeight(self.frame));
        
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化背景视图
        
        _rootView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame) - 20 , CGRectGetHeight(self.frame) - 20)];
        
        _rootView.backgroundColor = [UIColor whiteColor];
        
        [_rootView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity:0.4f];
        
        [self addSubview:_rootView];
        
        
        //初始化标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 30)];
        
        _titleLabel.backgroundColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor grayColor];
        
        _titleLabel.text = @"测试标题";
        
        //[_titleLabel dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity:0.4f];
        
        [_rootView addSubview:_titleLabel];
        
        //初始化前视图
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 5, 30)];
        
        _titleView.backgroundColor = MAINCOLOER;
        
        [_rootView addSubview:_titleView];
        
        
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置背景视图
    
    _rootView.frame = CGRectMake(10, 10, CGRectGetWidth(self.frame) - 20 , CGRectGetHeight(self.frame) - 20);
    
    [_rootView dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity:0.4f];
    
    
}

-(void)setTitle:(NSString *)title{
    
    if (_title != title) {
        
        [_title release];
        
        _title = [title retain];
        
    }
    
    //设置标题
    
    self.titleLabel.text = title;
    
}

@end
