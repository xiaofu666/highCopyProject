//
//  Hero_Details_Details_SkillCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_Details_SkillCell.h"

#import "Hero_Details_SkillModel.h"

#import <UIButton+WebCache.h>

#define kButtonSize 50

@interface Hero_Details_Details_SkillCell ()

@property (nonatomic , retain ) NSArray *skillArray;//技能数组 (存储B,Q,W,E,R)

@property (nonatomic , retain ) NSMutableArray *buttonArray;//按钮数组

@property (nonatomic , retain ) UIView *skillView;//技能视图


@property (nonatomic , retain ) UILabel *header_costLabel;//技能消耗

@property (nonatomic , retain ) UILabel *header_cooldownLabel;//技能冷却时间

@property (nonatomic , retain ) UILabel *header_skillDescriptionLabel;//技能描述

@property (nonatomic , retain ) UILabel *header_rangeLabel;//技能范围

@property (nonatomic , retain ) UILabel *header_effectLabel;//技能效果


@property (nonatomic , retain ) UILabel *nameLabel;//技能名称

@property (nonatomic , retain ) UILabel *costLabel;//技能消耗

@property (nonatomic , retain ) UILabel *cooldownLabel;//技能冷却时间

@property (nonatomic , retain ) UILabel *skillDescriptionLabel;//技能描述

@property (nonatomic , retain ) UILabel *rangeLabel;//技能范围

@property (nonatomic , retain ) UILabel *effectLabel;//技能效果



@property (nonatomic , assign ) NSInteger selectedIndex;//选中下标

@end

@implementation Hero_Details_Details_SkillCell

-(void)dealloc{
    
    [_dataArray release];
    
    [_skillArray release];
    
    [_buttonArray release];
    
    [_skillView release];
    
    [_header_costLabel release];
    
    [_header_cooldownLabel release];
    
    [_header_skillDescriptionLabel release];
    
    [_header_rangeLabel release];
    
    [_header_effectLabel release];
    
    [_nameLabel release];
    
    [_costLabel release];
    
    [_cooldownLabel release];
    
    [_skillDescriptionLabel release];
    
    [_rangeLabel release];
    
    [_effectLabel release];
    
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
        
        _skillArray = [[NSArray alloc]initWithArray:@[@"B",@"Q",@"W",@"E",@"R"]];
        
        //加载技能按钮
        
        [self loadButtons];
        
        //加载技能介绍视图
        
        [self loadSkillView];
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
}

#pragma mark ---加载技能按钮

- (void)loadButtons{
    
    //循环创建button
    
    NSInteger count = 5;
    
    CGFloat buttonX = (CGRectGetWidth(self.rootView.frame) - (kButtonSize * count) ) / ( count + 1 );
    
    for (int i = 0; i < count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake( buttonX * (i + 1) + kButtonSize * i , 50 , kButtonSize, kButtonSize);
        
        [button setImage:[UIImage imageNamed:@"poluoimage_gray"] forState:UIControlStateNormal];
        
        button.layer.cornerRadius = 8.0f;
        
        button.clipsToBounds = YES;
        
        [button addTarget:self action:@selector(skillButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.rootView addSubview:button];
        
        [self.buttonArray addObject:button];
        
    }
    
    
}

#pragma mark ---技能按钮点击响应事件

- (void)skillButtonAction:(UIButton *)sender{
    
    self.selectedIndex = [self.buttonArray indexOfObject:sender];
    
}

#pragma mark ---加载技能介绍视图

- (void)loadSkillView{
    
    _skillView = [[UIView alloc]initWithFrame:CGRectMake( 0 , 110, CGRectGetWidth(self.rootView.frame), 200)];
    
    [self.rootView addSubview:_skillView];
    
    //初始化技能名称
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 0, CGRectGetWidth(_skillView.frame) - 20 , 20)];
    
    _nameLabel.text = @"";
    
    _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    
    _nameLabel.textColor = [UIColor blackColor];
    
    [_skillView addSubview:_nameLabel];
    
    
    //初始化技能描述
    
    _header_skillDescriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 30 , 50 , 20)];
    
    _header_skillDescriptionLabel.textColor = [UIColor lightGrayColor];
    
    _header_skillDescriptionLabel.textAlignment = NSTextAlignmentLeft;
    
    _header_skillDescriptionLabel.text = @"描述";
    
    _header_skillDescriptionLabel.font = [UIFont systemFontOfSize:16];
    
    [_skillView addSubview:_header_skillDescriptionLabel];
    
    
    
    _skillDescriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 , _header_skillDescriptionLabel.frame.origin.y , CGRectGetWidth(_skillView.frame) - 80 , 20)];
    
    _skillDescriptionLabel.textColor = [UIColor blackColor];
    
    _skillDescriptionLabel.font = [UIFont systemFontOfSize:16];
    
    _skillDescriptionLabel.numberOfLines = 0;
    
    [_skillView addSubview:_skillDescriptionLabel];
    
    
    
    //初始化技能消耗
    
    _header_costLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , _skillDescriptionLabel.frame.origin.y + CGRectGetHeight(_skillDescriptionLabel.frame) + 10 , 50 , 20)];
    
    _header_costLabel.textColor = [UIColor lightGrayColor];
    
    _header_costLabel.textAlignment = NSTextAlignmentLeft;
    
    _header_costLabel.text = @"消耗";
    
    _header_costLabel.font = [UIFont systemFontOfSize:16];
    
    [_skillView addSubview:_header_costLabel];
    
    _costLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 , _header_costLabel.frame.origin.y , CGRectGetWidth(_skillView.frame) - 80 , 20)];
    
    _costLabel.textColor = [UIColor blackColor];
    
    _costLabel.font = [UIFont systemFontOfSize:16];
    
    _costLabel.numberOfLines = 0;
    
    [_skillView addSubview:_costLabel];
    
    
    //初始化技能冷却时间
    
    _header_cooldownLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , _costLabel.frame.origin.y + CGRectGetHeight(_costLabel.frame) + 10 , 50 , 20)];
    
    _header_cooldownLabel.textColor = [UIColor lightGrayColor];
    
    _header_cooldownLabel.textAlignment = NSTextAlignmentLeft;
    
    _header_cooldownLabel.text = @"冷却";
    
    _header_cooldownLabel.font = [UIFont systemFontOfSize:16];
    
    [_skillView addSubview:_header_cooldownLabel];
    
    _cooldownLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 , _header_cooldownLabel.frame.origin.y , CGRectGetWidth(_skillView.frame) - 80 , 20)];
    
    _cooldownLabel.textColor = [UIColor blackColor];
    
    _cooldownLabel.font = [UIFont systemFontOfSize:16];
    
    _cooldownLabel.numberOfLines = 0;
    
    [_skillView addSubview:_cooldownLabel];

    
    
    
    //初始化技能范围
    
    
    _header_rangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , _cooldownLabel.frame.origin.y + CGRectGetHeight(_cooldownLabel.frame) + 10 , 50 , 20)];
    
    _header_rangeLabel.textColor = [UIColor lightGrayColor];
    
    _header_rangeLabel.textAlignment = NSTextAlignmentLeft;
    
    _header_rangeLabel.text = @"范围";
    
    _header_rangeLabel.font = [UIFont systemFontOfSize:16];
    
    [_skillView addSubview:_header_rangeLabel];
    
    _rangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 , _header_rangeLabel.frame.origin.y , CGRectGetWidth(_skillView.frame) - 80 , 20)];
    
    _rangeLabel.textColor = [UIColor blackColor];
    
    _rangeLabel.font = [UIFont systemFontOfSize:16];
    
    _rangeLabel.numberOfLines = 0;
    
    [_skillView addSubview:_rangeLabel];
    
    
    
    //初始化技能效果
    
    _header_effectLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , _rangeLabel.frame.origin.y + CGRectGetHeight(_rangeLabel.frame) + 10 , 50 , 20)];
    
    _header_effectLabel.textColor = [UIColor lightGrayColor];
    
    _header_effectLabel.textAlignment = NSTextAlignmentLeft;
    
    _header_effectLabel.text = @"效果";
    
    _header_effectLabel.font = [UIFont systemFontOfSize:16];
    
    [_skillView addSubview:_header_effectLabel];
    
    _effectLabel = [[UILabel alloc]initWithFrame:CGRectMake(70 , _header_effectLabel.frame.origin.y , CGRectGetWidth(_skillView.frame) - 80 , 20)];
    
    _effectLabel.textColor = [UIColor blackColor];
    
    _effectLabel.font = [UIFont systemFontOfSize:16];
    
    _effectLabel.numberOfLines = 0;
    
    [_skillView addSubview:_effectLabel];
    
}



-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (_selectedIndex != selectedIndex) {
        
        _selectedIndex = selectedIndex;
        
    }
    
    //获取选中的按钮 并设置其按钮样式
    
    UIButton *selectdButton = [self.buttonArray objectAtIndex:selectedIndex];
    
    for (UIButton *button in self.buttonArray) {
        
        if (button != selectdButton) {
            
            //设置其他按钮为默认样式
            
            [self defaultButtonStyle:button];
            
        } else {
            
            //设置其他按钮为选中样式
            
            [self selectedButtonStyle:button];
            
        }
        
    }
    
    if (self.dataArray != nil) {
        
        //为技能视图添加相应内容
        
        Hero_Details_SkillModel *model = [self.dataArray objectAtIndex:selectedIndex];
        
        //技能名称
        
        _nameLabel.text = [NSString stringWithFormat:@"%@ [%@]",model.name , [self.skillArray objectAtIndex:selectedIndex]];
        
        //技能介绍
        
        [self addDataToSkillViewWithSkillModel:model];
        
    }
    
    
    
}

#pragma mark ---选中按钮样式

-(void)selectedButtonStyle:(UIButton *)sender{
    
    sender.alpha = 1.0f;
    
}

#pragma mark ---默认按钮样式

-(void)defaultButtonStyle:(UIButton *)sender{
    
    sender.alpha = 0.6f;
    
}

#pragma mark ---添加数据到技能视图

-(void)addDataToSkillViewWithSkillModel:(Hero_Details_SkillModel *)model{
    
    //添加数据 并计算label所需高度 动态调整控件位置
    
    
    //技能描述
    
    CGFloat skillDescriptionLabelHeight = [self addDataToLabelSettingFrameWithHeaderLabel:_header_skillDescriptionLabel ContentLabel:_skillDescriptionLabel Text:model.skillDescription LabelY:_skillDescriptionLabel.frame.origin.y];
    
    //技能消耗
    
    CGFloat costLabelHeight = [self addDataToLabelSettingFrameWithHeaderLabel:_header_costLabel ContentLabel:_costLabel Text:model.cost LabelY:skillDescriptionLabelHeight + 5];
    
    //技能冷却
    
    CGFloat cooldownLabelHeight = [self addDataToLabelSettingFrameWithHeaderLabel:_header_cooldownLabel ContentLabel:_cooldownLabel Text:model.cooldown LabelY:costLabelHeight + 5];
    
    //技能范围
    
    CGFloat rangeLabelHeight = [self addDataToLabelSettingFrameWithHeaderLabel:_header_rangeLabel ContentLabel:_rangeLabel Text:model.range LabelY:cooldownLabelHeight + 5];
    
    //技能效果
    
    CGFloat effectLabelHeight = [self addDataToLabelSettingFrameWithHeaderLabel:_header_effectLabel ContentLabel:_effectLabel Text:model.effect LabelY:rangeLabelHeight + 5];
    
    //设置技能视图大小
    
    _skillView.frame = CGRectMake(_skillView.frame.origin.x, _skillView.frame.origin.y, CGRectGetWidth(_skillView.frame), effectLabelHeight + 20);
    
    //设置Cell大小
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth(self.frame), _skillView.frame.origin.y + _skillView.frame.size.height + 10);
    
    //调用block传递indexpath和高度
    
    self.changeCellHeight(self.indexpath , CGRectGetHeight(self.frame));
    
}

//为Label添加数据并设置其Frame属性 (参数 头Label , 内容Label , 字符串内容 ,LabelY轴 (上一个label[高度 + y轴 + 间距] ))返回 此label的y轴+高度

-(CGFloat)addDataToLabelSettingFrameWithHeaderLabel:(UILabel *)headerLabel ContentLabel:(UILabel *)contentLabel Text:(NSString *)text LabelY:(CGFloat) LabelY{
    
    //内容非空判断 如果没有内容隐藏该Label 返回原高度
    
    if ([text isEqualToString:@""]) {
        
        //隐藏Label
        
        headerLabel.hidden = YES;
        
        contentLabel.hidden = YES;
        
        return LabelY;
    
    } else {
        
        //显示Label
        
        headerLabel.hidden = NO;
        
        contentLabel.hidden = NO;
        
        //设置内容Label内容
        
        contentLabel.text = text;
        
        //计算内容所需高度
        
        CGFloat contentLabelHeight = [NSString getHeightWithstring:text Width:CGRectGetWidth(contentLabel.frame) FontSize:16];
        
        //设置内容label的frame
        
        contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, LabelY , CGRectGetWidth(contentLabel.frame), contentLabelHeight);
        
        //设置头Label位置
        
        headerLabel.frame = CGRectMake(headerLabel.frame.origin.x, LabelY , CGRectGetWidth(headerLabel.frame), CGRectGetHeight(headerLabel.frame) );
        
        //返回 Y轴+高度
        
        return contentLabel.frame.origin.y + CGRectGetHeight(contentLabel.frame);
        
    }
    
}

#pragma mark ---获取数据


- (void)setDataArray:(NSMutableArray *)dataArray {
    
    if (_dataArray != dataArray) {
        
        [_dataArray release];
        
        _dataArray = [dataArray retain];
        
        //默认选中第一个按钮
        
        self.selectedIndex = 0;
        
    }
    
    //循环SDWebImage异步加载图片
    
    NSInteger index = 0;
    
    for (Hero_Details_SkillModel *model in self.dataArray) {
        
        UIButton *button = [self.buttonArray objectAtIndex:index];
        
        [button sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:KUnion_Ency_HeroSkillImageURL , model.key]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
        
        index ++;
        
    }
    
}





#pragma mark ---LazyLoading

-(NSMutableArray *)buttonArray {
    
    if (_buttonArray == nil) {
        
        _buttonArray  = [[NSMutableArray alloc]init];
        
    }
    
    return _buttonArray;
    
}


@end
