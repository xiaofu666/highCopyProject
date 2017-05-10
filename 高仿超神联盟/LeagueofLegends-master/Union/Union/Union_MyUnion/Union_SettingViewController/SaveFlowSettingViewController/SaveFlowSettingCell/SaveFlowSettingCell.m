//
//  SaveFlowSettingCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SaveFlowSettingCell.h"

@interface SaveFlowSettingCell ()

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UIImageView *stateImageView;//状态图片视图

@end

@implementation SaveFlowSettingCell

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
        
        //初始化
        
        _titleLabel = [[UILabel alloc]init];
        
        [self addSubview:_titleLabel];
        
        
        _stateImageView = [[UIImageView alloc]init];
        
        _stateImageView.image = [UIImage imageNamed:@"stateImageisNo"];
        
        [self addSubview:_stateImageView];
        
        
    }

    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(20 , 0 , CGRectGetWidth(self.frame) - 80 , CGRectGetHeight(self.frame));
    
    _stateImageView.frame = CGRectMake(CGRectGetWidth(self.frame) - 50 , 0 , 32 , 32);
    
    _stateImageView.center = CGPointMake(_stateImageView.center.x, CGRectGetHeight(self.frame) / 2);
    
}

#pragma mark ---获取数据

- (void)setTitleStr:(NSString *)titleStr{
    
    if (_titleStr != titleStr) {
        
        [_titleStr release];
        
        _titleStr = [titleStr retain];
        
    }
    
    _titleLabel.text = titleStr;
    
}

- (void)setIsSelected:(BOOL)isSelected{
    
    if (_isSelected != isSelected) {
        
        _isSelected = isSelected;
        
    }
    
    if (isSelected) {
        
        _stateImageView.image = [UIImage imageNamed:@"stateImageisYes"];
        
    } else {
        
        _stateImageView.image = [UIImage imageNamed:@"stateImageisNo"];
        
    }
    
}


@end
