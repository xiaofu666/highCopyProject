//
//  Hero_Details_Details_DataCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_Details_DataCell.h"


@interface Hero_Details_Details_DataCell ()


@property (nonatomic , retain ) UILabel *header_rangeLabel;//攻击距离

@property (nonatomic , retain ) UILabel *header_moveSpeedLabel;//移动速度

@property (nonatomic , retain ) UILabel *header_attackBaseLabel;//基础攻击

@property (nonatomic , retain ) UILabel *header_armorBaseLabel;//基础护甲

@property (nonatomic , retain ) UILabel *header_healthBaseLabel;//基础生命值

@property (nonatomic , retain ) UILabel *header_manaBaseLabel;//基础魔法值

@property (nonatomic , retain ) UILabel *header_criticalChanceBaseLabel;//基础暴击概率

@property (nonatomic , retain ) UILabel *header_healthRegenBaseLabel;//基础生命回复

@property (nonatomic , retain ) UILabel *header_manaRegenBaseLabel;//基础魔法回复

@property (nonatomic , retain ) UILabel *header_magicResistBaseLabel;//基础魔法抗性


@property (nonatomic , retain ) UILabel *rangeLabel;//攻击距离

@property (nonatomic , retain ) UILabel *moveSpeedLabel;//移动速度

@property (nonatomic , retain ) UILabel *attackBaseLabel;//基础攻击

@property (nonatomic , retain ) UILabel *armorBaseLabel;//基础护甲

@property (nonatomic , retain ) UILabel *healthBaseLabel;//基础生命值

@property (nonatomic , retain ) UILabel *manaBaseLabel;//基础魔法值

@property (nonatomic , retain ) UILabel *criticalChanceBaseLabel;//基础暴击概率

@property (nonatomic , retain ) UILabel *healthRegenBaseLabel;//基础生命回复

@property (nonatomic , retain ) UILabel *manaRegenBaseLabel;//基础魔法回复

@property (nonatomic , retain ) UILabel *magicResistBaseLabel;//基础魔法抗性


@property (nonatomic , assign ) NSInteger level;//当前等级

@property (nonatomic , retain ) UILabel *levelLabel;//等级

@property (nonatomic , retain ) UIView *levelView;//当前等级视图

@property (nonatomic , retain ) UISlider *levelSlider;//等级滑块视图

@property (nonatomic , retain ) UIButton *levelJiaButton;//等级加按钮

@property (nonatomic , retain ) UIButton *levelJianButton;//等级减按钮

@end

@implementation Hero_Details_Details_DataCell

-(void)dealloc{
    
    [_model release];
    
    [_header_rangeLabel release];
    
    [_header_moveSpeedLabel release];
    
    [_header_attackBaseLabel release];
    
    [_header_armorBaseLabel release];
    
    [_header_healthBaseLabel release];
    
    [_header_manaBaseLabel release];
    
    [_header_criticalChanceBaseLabel release];
    
    [_header_healthRegenBaseLabel release];
    
    [_header_manaRegenBaseLabel release];
    
    [_header_magicResistBaseLabel release];
    
    [_rangeLabel release];
    
    [_moveSpeedLabel release];
    
    [_attackBaseLabel release];
    
    [_armorBaseLabel release];
    
    [_healthBaseLabel release];
    
    [_manaBaseLabel release];
    
    [_criticalChanceBaseLabel release];
    
    [_healthRegenBaseLabel release];
    
    [_manaRegenBaseLabel release];
    
    [_magicResistBaseLabel release];
    
    [_levelLabel release];
    
    [_levelView release];
    
    [_levelSlider release];
    
    [_levelJiaButton release];
    
    [_levelJianButton release];
    
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
        
        //初始化等级
        
        _level = 1;
        
        //初始化等级父视图
        
        UIView *levelRootView = [[UIView alloc]initWithFrame:CGRectMake( 0 , 0 , 100 , 50 )];
        
        levelRootView.center = CGPointMake(CGRectGetWidth(self.rootView.frame) / 2 , levelRootView.center.y);
        
        levelRootView.clipsToBounds = YES;
        
        [self.rootView addSubview:levelRootView];
        
        //初始化等级视图
        
        _levelView = [[UIView alloc]initWithFrame:CGRectMake(0 , 0 , 100 , 100)];
        
        _levelView.layer.cornerRadius = 50;
        
        _levelView.clipsToBounds = YES;
        
        _levelView.backgroundColor = [MAINCOLOER colorWithAlphaComponent:0.8f];
        
        _levelView.center = CGPointMake(CGRectGetWidth(levelRootView.frame) / 2 , 0);
        
        [levelRootView addSubview:_levelView];
        
        //初始化等级Label
        
        _levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_levelView.frame) / 2 , CGRectGetWidth(_levelView.frame), CGRectGetHeight(_levelView.frame) / 2)];
        
        _levelLabel.textColor = [UIColor whiteColor];
        
        _levelLabel.textAlignment = NSTextAlignmentCenter;
        
        _levelLabel.font = [UIFont systemFontOfSize:28];
        
        _levelLabel.numberOfLines = 0;
        
        _levelLabel.text = [NSString stringWithFormat:@"%ld" , self.level];
        
        [_levelView addSubview:_levelLabel];
        
        
        //初始化滑块视图
        
        _levelSlider = [[UISlider alloc]initWithFrame:CGRectMake(50, 56 , CGRectGetWidth(self.rootView.frame) - 100, 20)];
        
        _levelSlider.minimumValue = 1;
        
        _levelSlider.maximumValue = 18;
        
        _levelSlider.minimumTrackTintColor = MAINCOLOER;
        
        [_levelSlider addTarget:self action:@selector(levelSliderAction:) forControlEvents:UIControlEventValueChanged];
        
        [self.rootView addSubview:_levelSlider];
        
        //初始化等级加按钮
        
        _levelJiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _levelJiaButton.frame = CGRectMake(CGRectGetWidth(self.rootView.frame) - 42, 50, 32, 32);
        
        [_levelJiaButton setImage:[[UIImage imageNamed:@"iconfont-herodatajia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        _levelJiaButton.tintColor = MAINCOLOER;
        
        [_levelJiaButton addTarget:self action:@selector(levelJiaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.rootView addSubview:_levelJiaButton];
        
        //初始化等级减按钮
        
        _levelJianButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _levelJianButton.frame = CGRectMake(10, 50, 32, 32);
        
        [_levelJianButton setImage:[[UIImage imageNamed:@"iconfont-herodatajian"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        _levelJianButton.tintColor = MAINCOLOER;
        
        [_levelJianButton addTarget:self action:@selector(levelJianButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.rootView addSubview:_levelJianButton];
        
        
        //初始化Label
        
        [self loadLabels];
        
        
        //设置Cell的Frame
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth(self.frame), 430);
        
    }
    
    return self;
    
}

//初始化Label

-(void)loadLabels{
    
    //攻击距离
    
    _header_rangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100 , 100 , 20)];
    
    _header_rangeLabel.textAlignment = NSTextAlignmentRight;
    
    _header_rangeLabel.textColor = [UIColor lightGrayColor];
    
    _header_rangeLabel.font = [UIFont systemFontOfSize:14];
    
    _header_rangeLabel.text = @"攻击距离:";
    
    [self.rootView addSubview:_header_rangeLabel];
    
    _rangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 100 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _rangeLabel.textAlignment = NSTextAlignmentLeft;
    
    _rangeLabel.textColor = [UIColor blackColor];
    
    _rangeLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_rangeLabel];
    
    
    //移动速度
    
    _header_moveSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 130 , 100 , 20)];
    
    _header_moveSpeedLabel.textAlignment = NSTextAlignmentRight;
    
    _header_moveSpeedLabel.textColor = [UIColor lightGrayColor];
    
    _header_moveSpeedLabel.font = [UIFont systemFontOfSize:14];
    
    _header_moveSpeedLabel.text = @"移动速度:";
    
    [self.rootView addSubview:_header_moveSpeedLabel];
    
    _moveSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 130 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _moveSpeedLabel.textAlignment = NSTextAlignmentLeft;
    
    _moveSpeedLabel.textColor = [UIColor blackColor];
    
    _moveSpeedLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_moveSpeedLabel];
    
    
    //基础攻击
    
    _header_attackBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160 , 100 , 20)];
    
    _header_attackBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_attackBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_attackBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_attackBaseLabel.text = @"基础攻击:";
    
    [self.rootView addSubview:_header_attackBaseLabel];

    
    _attackBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 160 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _attackBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _attackBaseLabel.textColor = [UIColor blackColor];
    
    _attackBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_attackBaseLabel];
    
    
    //基础防御
    
    _header_armorBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 190 , 100 , 20)];
    
    _header_armorBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_armorBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_armorBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_armorBaseLabel.text = @"基础防御:";
    
    [self.rootView addSubview:_header_armorBaseLabel];

    
    _armorBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 190 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _armorBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _armorBaseLabel.textColor = [UIColor blackColor];
    
    _armorBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_armorBaseLabel];
    
    //基础魔抗
    
    _header_magicResistBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 220 , 100 , 20)];
    
    _header_magicResistBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_magicResistBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_magicResistBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_magicResistBaseLabel.text = @"基础魔抗:";
    
    [self.rootView addSubview:_header_magicResistBaseLabel];
    
    
    _magicResistBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 220 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _magicResistBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _magicResistBaseLabel.textColor = [UIColor blackColor];
    
    _magicResistBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_magicResistBaseLabel];
    
    
    //基础生命值
    
    _header_healthBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 250 , 100 , 20)];
    
    _header_healthBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_healthBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_healthBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_healthBaseLabel.text = @"基础生命值:";
    
    [self.rootView addSubview:_header_healthBaseLabel];
    
    _healthBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 250 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _healthBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _healthBaseLabel.textColor = [UIColor blackColor];
    
    _healthBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_healthBaseLabel];
    
    
    //基础魔法值
    
    _header_manaBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 280 , 100 , 20)];
    
    _header_manaBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_manaBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_manaBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_manaBaseLabel.text = @"基础魔法值:";
    
    [self.rootView addSubview:_header_manaBaseLabel];
    
    _manaBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 280 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _manaBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _manaBaseLabel.textColor = [UIColor blackColor];
    
    _manaBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_manaBaseLabel];
    
    //暴击概率
    
    _header_criticalChanceBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 310 , 100 , 20)];
    
    _header_criticalChanceBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_criticalChanceBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_criticalChanceBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_criticalChanceBaseLabel.text = @"暴击概率:";
    
    [self.rootView addSubview:_header_criticalChanceBaseLabel];
    
    _criticalChanceBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 310 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _criticalChanceBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _criticalChanceBaseLabel.textColor = [UIColor blackColor];
    
    _criticalChanceBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_criticalChanceBaseLabel];
    
    //生命回复
    
    _header_healthRegenBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 340 , 100 , 20)];
    
    _header_healthRegenBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_healthRegenBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_healthRegenBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_healthRegenBaseLabel.text = @"生命回复:";
    
    [self.rootView addSubview:_header_healthRegenBaseLabel];
    
    _healthRegenBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 340 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _healthRegenBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _healthRegenBaseLabel.textColor = [UIColor blackColor];
    
    _healthRegenBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_healthRegenBaseLabel];
    
    
    //魔法回复
    
    _header_manaRegenBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 370 , 100 , 20)];
    
    _header_manaRegenBaseLabel.textAlignment = NSTextAlignmentRight;
    
    _header_manaRegenBaseLabel.textColor = [UIColor lightGrayColor];
    
    _header_manaRegenBaseLabel.font = [UIFont systemFontOfSize:14];
    
    _header_manaRegenBaseLabel.text = @"魔法回复:";
    
    [self.rootView addSubview:_header_manaRegenBaseLabel];
    
    _manaRegenBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , 370 , CGRectGetWidth(self.rootView.frame) - 130 , 20)];
    
    _manaRegenBaseLabel.textAlignment = NSTextAlignmentLeft;
    
    _manaRegenBaseLabel.textColor = [UIColor blackColor];
    
    _manaRegenBaseLabel.font = [UIFont systemFontOfSize:14];
    
    [self.rootView addSubview:_manaRegenBaseLabel];
 
    
    [_header_rangeLabel release];
    
    [_header_moveSpeedLabel release];
    
    [_header_attackBaseLabel release];
    
    [_header_armorBaseLabel release];
    
    [_header_magicResistBaseLabel release];
    
    [_header_healthBaseLabel release];
    
    [_header_manaBaseLabel release];
    
    [_header_criticalChanceBaseLabel release];
    
    [_header_healthRegenBaseLabel release];
    
    [_header_manaRegenBaseLabel release];
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    
}

#pragma mark ---等级加按钮事件

- (void)levelJiaButtonAction:(UIButton *)sender{
    
    if (self.level < 18) {
        
        self.level += 1;
        
    }
    
}

#pragma mark ---等级减按钮事件

- (void)levelJianButtonAction:(UIButton *)sender{
    
    if (self.level > 1) {
        
        self.level -= 1;
        
    }
    
}

#pragma mark ---滑块视图滑动事件

- (void)levelSliderAction:(UISlider *)slider{
    
    self.level = slider.value;
    
}

- (void)setLevel:(NSInteger)level{
    
    if (_level != level) {
        
        _level = level;
        
    }
    
    //判断按钮状态
    
    if (level == 1) {
        
        _levelJianButton.enabled = NO;
        
    } else {
        
        _levelJianButton.enabled = YES;
        
    }
    
    if (level == 18) {
        
        _levelJiaButton.enabled = NO;
        
    } else {
        
        _levelJiaButton.enabled = YES;
        
    }
    
    
    //设置等级Label
    
    _levelLabel.text = [NSString stringWithFormat:@"%ld" , level ];
    
    
    //设置滑块视图
    
    _levelSlider.value = level;
    
    //设置属性数值
    
    //攻击距离
    
    _rangeLabel.text = self.model.range;
    
    //移动速度
    
    _moveSpeedLabel.text = self.model.moveSpeed;
    
    //基础攻击
    
    _attackBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.attackBase floatValue] + [self.model.attackLevel floatValue] * level , [self.model.attackLevel floatValue]];
    
    //基础护甲
    
    _armorBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.armorBase floatValue] + [self.model.armorLevel floatValue] * level , [self.model.armorLevel floatValue]];
    
    //基础魔法抗性
    
    _magicResistBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.magicResistBase floatValue] + [self.model.magicResistLevel floatValue] * level , [self.model.magicResistLevel floatValue]];
    
    //基础生命值
    
    _healthBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.healthBase floatValue] + [self.model.healthLevel floatValue] * level , [self.model.healthLevel floatValue]];
    
    //基础魔法值
    
    _manaBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.manaBase floatValue] + [self.model.manaLevel floatValue] * level , [self.model.manaLevel floatValue]];
    
    //暴击概率
    
    _criticalChanceBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.criticalChanceBase floatValue] + [self.model.criticalChanceLevel floatValue] * level , [self.model.criticalChanceLevel floatValue]];
    
    //生命回复
    
    _healthRegenBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.healthRegenBase floatValue] + [self.model.healthRegenLevel floatValue] * level , [self.model.healthRegenLevel floatValue]];
    
    //魔法回复
    
    _manaRegenBaseLabel.text = [NSString stringWithFormat:@"%.2f ( +%.2f/每级 )" , [self.model.manaRegenBase floatValue] + [self.model.manaRegenLevel floatValue] *level , [self.model.manaRegenLevel floatValue]];
    
    
}

#pragma mark ---获取数据

- (void)setModel:(Hero_Details_DataModel *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        //设置等级 并添加数据
        
        self.level = 1;
        
    }
    
}


@end

