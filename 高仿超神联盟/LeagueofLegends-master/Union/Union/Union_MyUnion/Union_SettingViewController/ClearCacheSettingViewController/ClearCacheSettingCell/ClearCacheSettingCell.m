//
//  ClearCacheSettingCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ClearCacheSettingCell.h"

#import "PCH.h"

@interface ClearCacheSettingCell ()

@property (nonatomic , retain ) UILabel *titleLabel;

@property (nonatomic , retain ) UILabel *detailTitleLabel;

@property (nonatomic , retain ) UISwitch *switchView;

@end

@implementation ClearCacheSettingCell

-(void)dealloc{
    
    [_titleStr release];
    
    [_titleLabel release];
    
    [_detailStr release];
    
    [_detailTitleLabel release];
    
    [_switchView release];
    
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
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textColor = [UIColor blackColor];
        
        [self addSubview:_titleLabel];
        
        _detailTitleLabel = [[UILabel alloc]init];
        
        _detailTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _detailTitleLabel.font = [UIFont systemFontOfSize:16];
        
        _detailTitleLabel.textColor = [UIColor grayColor];
        
        _detailTitleLabel.text = @"0.00KB";
        
        [self addSubview:_detailTitleLabel];
        
        _switchView = [[UISwitch alloc]init];
        
        _switchView.on = YES;
        
        _switchView.onTintColor = MAINCOLOER;
        
        [_switchView addTarget:self action:@selector(switchViewAction:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_switchView];
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(20 , 0 , CGRectGetWidth(self.frame) - 10 - 160 - 30 , CGRectGetHeight(self.frame));
    
    _detailTitleLabel.frame = CGRectMake(_titleLabel.frame.origin.x + CGRectGetWidth(_titleLabel.frame) + 10  , 0 , 80 , CGRectGetHeight(self.frame));
    
    _switchView.frame = CGRectMake(_detailTitleLabel.frame.origin.x + CGRectGetWidth(_detailTitleLabel.frame) + 10 , 0 , 80 , CGRectGetHeight(self.frame));
    
    _switchView.center = CGPointMake(_switchView.center.x, CGRectGetHeight(self.frame) / 2);
    
}

#pragma mark ---获取数据

-(void)setTitleStr:(NSString *)titleStr{
    
    if (_titleStr != titleStr) {
        
        [_titleStr release];
        
        _titleStr = [titleStr retain];
        
    }
    
    _titleLabel.text = titleStr;
    
}

-(void)setDetailStr:(NSString *)detailStr{
    
    if (_detailStr != detailStr) {
        
        [_detailStr release];
        
        _detailStr = [detailStr retain];
        
    }
    
    _detailTitleLabel.text = detailStr;
    
}

-(void)setIsClear:(BOOL)isClear{
    
    if (_isClear != isClear) {
        
        _isClear = isClear;
        
    }
    
    _switchView.on = isClear;
    
}

#pragma mark ---switch响应事件

-(void)switchViewAction:(UISwitch *)sw{
 
    _isClear = sw.on;
    
}


@end
