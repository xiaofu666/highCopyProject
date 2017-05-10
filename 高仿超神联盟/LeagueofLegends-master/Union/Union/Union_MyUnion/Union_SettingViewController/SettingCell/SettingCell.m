//
//  SettingCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SettingCell.h"

#import "PCH.h"

#import "SettingManager.h"

@interface SettingCell ()

@property (nonatomic , retain ) UILabel *titleLabel;

@property (nonatomic , retain ) UILabel *detailTitleLabel;

@property (nonatomic , retain ) UISwitch *stateSwitch;//状态Switch

@end

@implementation SettingCell

-(void)dealloc{
    
    [_titleStr release];
    
    [_titleLabel release];
    
    [_detailStr release];
    
    [_detailTitleLabel release];
    
    [_stateSwitch release];
    
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
        
        _titleLabel.textColor = [UIColor grayColor];
        
        
        [self addSubview:_titleLabel];
        
        _detailTitleLabel = [[UILabel alloc]init];
        
        _detailTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _detailTitleLabel.font = [UIFont systemFontOfSize:14];
        
        _detailTitleLabel.textColor = [UIColor lightGrayColor];
        
        [self addSubview:_detailTitleLabel];
        
        
        _stateSwitch = [[UISwitch alloc]init];
        
        _stateSwitch.on = NO;
        
        _stateSwitch.onTintColor = MAINCOLOER;
        
        [_stateSwitch addTarget:self action:@selector(stateSwitchAction:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_stateSwitch];
        
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(20 , 0 , CGRectGetWidth(self.frame) - 10 - 150 - 30 , CGRectGetHeight(self.frame));
    
    _detailTitleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 20 - 150 - 30 , 0 , 150 , CGRectGetHeight(self.frame));
    
    _stateSwitch.frame = CGRectMake(CGRectGetWidth(self.frame) - 80, 0 , 80 , CGRectGetHeight(self.frame));
    
    _stateSwitch.center = CGPointMake(_stateSwitch.center.x, CGRectGetHeight(self.frame) / 2);
    
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

-(void)setIsOpen:(BOOL)isOpen{
    
    if (_isOpen != isOpen) {
        
        _isOpen = isOpen;
        
    }
    
    _stateSwitch.on = isOpen;
    
}

#pragma mark ---设置cell样式

-(void)setStyle:(SettingCellStyle)style{
    
    switch (style) {
        case SettingCellStyleLabel:
            
            //隐藏Switch
            
            _stateSwitch.hidden = YES;
            
            //显示Label
            
            _detailTitleLabel.hidden = NO;
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
            
        case SettingCellStyleSwitch:
            
            //显示Switch
            
            _stateSwitch.hidden = NO;
            
            //隐藏Label
            
            _detailTitleLabel.hidden = YES;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
            
        default:
            
            
            break;
    }
    
}


#pragma mark ---Switch响应事件

- (void)stateSwitchAction:(UISwitch *)sw{
    
    //存储设置的状态
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSString stringWithFormat:@"%d",sw.on ] forKey:@"settingDownloadviewHiddenOrShow"];
    
    [defaults synchronize];
    
    [[SettingManager shareSettingManager] downloadViewHiddenOrShow:sw.on];
    
}

@end
