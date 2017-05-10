//
//  SortCollectionReusableView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SortCollectionReusableView.h"

#import "PCH.h"

@interface SortCollectionReusableView ()

@property (nonatomic , retain ) UIView *lineView;//分隔线视图

@end


@implementation SortCollectionReusableView

-(void)dealloc{
    
    [_myHeader release];
    
    [_textField release];
    
    [_button release];
    
    [_lineView release];
    
    [super dealloc];
    
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        _myHeader = [[UILabel alloc]init];
        
        _myHeader.textColor = [UIColor lightGrayColor];
        
        _myHeader.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:_myHeader];
        
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        
        [self addSubview:_lineView];
        
        
        _textField = [[UITextField alloc]init];
        
        _textField.placeholder = @"请输入关键字";
        
        _textField.textAlignment = NSTextAlignmentCenter;
        
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        
        _textField.delegate = self;
        
        //设置return按键样式
        
        _textField.returnKeyType=UIReturnKeySearch;
        
        //自适应宽度
        
        _textField.adjustsFontSizeToFitWidth=YES;
        
        //设置编辑已显示内容清空 (默认不清空)
        
        _textField.clearsOnBeginEditing = YES;
        
        //设置编辑已显示内容清空的按钮
        
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        
        
        
        [self addSubview:_textField];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.myHeader.frame =CGRectMake(10, self.frame.size.height - 25, self.frame.size.width - 20, 20);
    
    self.textField.frame = CGRectMake(10, 10, self.frame.size.width - 20, 30);
    
    self.lineView.frame = CGRectMake(10, self.myHeader.frame.origin.y + CGRectGetHeight(self.myHeader.frame), CGRectGetWidth(self.frame) - 20, 1);

    
}

#pragma mark ---UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (![textField.text isEqualToString:@""]) {
        
        //搜索
        
        self.videoSearchBlock(textField.text);
        
        //清空输入框内容
        
        textField.text = @"";

    }
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
