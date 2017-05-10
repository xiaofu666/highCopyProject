//
//  MessagePushSettingCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MessagePushSettingCell.h"

#import "PCH.h"

@interface MessagePushSettingCell ()

@property (nonatomic ,retain ) UILabel *titleLabel;//标题Label

@property (nonatomic , retain ) UILabel *stateLabel;//状态Label

@property (nonatomic , retain ) UISwitch *stateSwitch;//状态Switch

@end

@implementation MessagePushSettingCell

-(void)dealloc{
    
    [_titleLabel release];
    
    [_stateLabel release];
    
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
        
        [self addSubview:_titleLabel];
        
        _stateLabel = [[UILabel alloc]init];
        
        _stateLabel.textColor = [UIColor grayColor];
        
        _stateLabel.font = [UIFont systemFontOfSize:14];
        
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_stateLabel];
        
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
    
    _titleLabel.frame = CGRectMake(20 , 0 , CGRectGetWidth(self.frame) - 80 , CGRectGetHeight(self.frame));
    
    _stateLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 80, 0 , 80 , CGRectGetHeight(self.frame));
    
    _stateSwitch.frame = CGRectMake(CGRectGetWidth(self.frame) - 80, 0 , 80 , CGRectGetHeight(self.frame));
    
    _stateSwitch.center = CGPointMake(_stateSwitch.center.x, CGRectGetHeight(self.frame) / 2);
    
}

#pragma mark ---获取数据

-(void)setTitleStr:(NSString *)titleStr {
    
    if (_titleStr != titleStr) {
        
        [_titleStr release];
        
        _titleStr = [titleStr retain];
        
    }
    
    _titleLabel.text = titleStr;
    
}

-(void)setStateStr:(NSString *)stateStr{
    
    if (_stateStr != stateStr) {
        
        [_stateStr release];
        
        _stateStr = [stateStr retain];
    
    }
    
    _stateLabel.text = stateStr;
    
}

-(void)setIsOpen:(BOOL)isOpen{
    
    if (_isOpen != isOpen) {
        
        _isOpen = isOpen;
        
    }
    
    //存储设置的状态
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //判断存储设置的类型 (声音, 震动)
    
    if ([_titleStr isEqualToString:@"声音"]) {
        
        [defaults setObject:[NSString stringWithFormat:@"%d",isOpen] forKey:@"setting_messagepush_issound"];
        
    } else if ([_titleStr isEqualToString:@"震动"]){
        
        [defaults setObject:[NSString stringWithFormat:@"%d",isOpen] forKey:@"setting_messagepush_isvibration"];
        
    }
    
    [defaults synchronize];
    
    //同步开关视图属性
    
    _stateSwitch.on = isOpen;
    
}

#pragma mark ---设置cell样式

-(void)setStyle:(MessagePushSettingCellStyle)style{
    
    switch (style) {
        case MessagePushSettingCellStyleStateLabel:
            
            //隐藏Switch
            
            _stateSwitch.hidden = YES;
            
            //显示Label
            
            _stateLabel.hidden = NO;
            
            break;
           
        case MessagePushSettingCellStyleStateSwitch:
            
            //显示Switch
            
            _stateSwitch.hidden = NO;
            
            //隐藏Label
            
            _stateLabel.hidden = YES;
            
            break;
            
        default:
            
            
            break;
    }
    
}


#pragma mark ---Switch响应事件

- (void)stateSwitchAction:(UISwitch *)sw{
    
    //设置打开属性
    
    self.isOpen = sw.on;
    
}






@end
