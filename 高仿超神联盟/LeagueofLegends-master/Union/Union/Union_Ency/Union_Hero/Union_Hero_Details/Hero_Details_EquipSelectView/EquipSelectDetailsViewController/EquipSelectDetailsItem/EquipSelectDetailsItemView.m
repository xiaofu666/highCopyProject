//
//  EquipSelectDetailsItemView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipSelectDetailsItemView.h"

#import <UIImageView+WebCache.h>

#import "NSString+GetWidthHeight.h"

#import "EquipSelectDetailsItemCustomImageView.h"

@interface EquipSelectDetailsItemView ()

@property (nonatomic , retain ) NSArray *tempSkillArray;//技能临时数组

@property (nonatomic , retain ) NSMutableArray *skillImageArray;//技能图标数组

@property (nonatomic , retain ) NSMutableArray *equipImageArray;//装备图标数组

@property (nonatomic , retain ) UILabel *titleLabel;//标题Label

@property (nonatomic , retain ) UIView *titleView;//标题前视图

@property (nonatomic , retain ) UILabel *explainLabel;//注释Label

@property (nonatomic , assign ) BOOL isSkill;//是否有技能

@end

@implementation EquipSelectDetailsItemView

-(void)dealloc{
    
    [_tempSkillArray release];
    
    [_skillImageArray release];
    
    [_equipImageArray release];
    
    [_skillArray release];
    
    [_equipArray release];
    
    [_titleLabel release];
    
    [_titleView release];
    
    [_explainLabel release];
    
    [_enHeroName release];
    
    [_skillDataArray release];
    
    [_title release];
    
    [_explainStr release];
    
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame isSkill:(BOOL)isSkill
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _isSkill = isSkill;
        
        self.backgroundColor = [UIColor whiteColor];
        
        //初始化技能临时数组
        
        _tempSkillArray = [[NSArray alloc]initWithArray:@[@"B",@"Q",@"W",@"E",@"R"]];
        
        //初始化标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor grayColor];
        
        _titleLabel.text = @"前期";
        
        [self addSubview:_titleLabel];
        
        //初始化前视图
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, 5, 20)];
        
        _titleView.backgroundColor = MAINCOLOER;
        
        [self addSubview:_titleView];
        
        [_titleView release];
        
        //初始化注释Label
        
        _explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , self.isSkill ? 150 : 100 , CGRectGetWidth(self.frame) - 20 , 20)];
        
        _explainLabel.textColor = [UIColor blackColor];
        
        _explainLabel.font = [UIFont systemFontOfSize:14];
        
        _explainLabel.numberOfLines = 0;
        
        [self addSubview:_explainLabel];
        
        if (self.isSkill) {
            
            //加载技能图片视图
            
            [self loadSkillImageViews];
            
        }
        
        //加载装备图片视图
        
        [self loadEquipImageViews];
        
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

#pragma mark ---加载技能图片视图

-(void)loadSkillImageViews{
    
    //初始化技能图片数组
    
    _skillImageArray = [[NSMutableArray alloc]init];
    
    //循环创建图片视图
    
    NSInteger count = 6;
    
    CGFloat imageViewSize = 40;
    
    CGFloat imageViewX = ((CGRectGetWidth(self.frame)) - (imageViewSize * count) ) / (count + 1);
    
    for (int i = 0 ; i < count ; i++ ) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skillImageViewTapAction:)];
        
        EquipSelectDetailsItemCustomImageView *imageView = [[EquipSelectDetailsItemCustomImageView alloc]initWithFrame:CGRectMake(imageViewX * ( i + 1 ) + imageViewSize * i , 50 , imageViewSize, imageViewSize)];
        
        imageView.clipsToBounds = YES;
        
        imageView.layer.cornerRadius = 8.0f;
        
        imageView.userInteractionEnabled = YES;
        
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
        
        [_skillImageArray addObject:imageView];
        
    }

    
}

#pragma mark ---加载装备图片视图

-(void)loadEquipImageViews{
    
    //初始化装备图片数组
    
    _equipImageArray = [[NSMutableArray alloc]init];
    
    //循环创建图片视图
    
    NSInteger count = 6;
    
    CGFloat imageViewSize = 40;
    
    CGFloat imageViewX = ((CGRectGetWidth(self.frame)) - (imageViewSize * count) ) / (count + 1);
    
    for (int i = 0 ; i < count ; i++ ) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(equipImageViewTapAction:)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX * ( i + 1 ) + imageViewSize * i , self.isSkill ? 100 : 50 , imageViewSize, imageViewSize)];
        
        imageView.clipsToBounds = YES;
        
        imageView.layer.cornerRadius = 8.0f;
        
        imageView.userInteractionEnabled = YES;
        
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
        
        [_equipImageArray addObject:imageView];
        
    }
    
}

#pragma mark ---技能图片视图点击事件

- (void)skillImageViewTapAction:(UITapGestureRecognizer *)tap{

    //获取点击的图片视图
    
    EquipSelectDetailsItemCustomImageView *imageView = (EquipSelectDetailsItemCustomImageView *)tap.view;
    
    //获取下标
    
    NSInteger index = [self.skillImageArray indexOfObject:imageView];
    
    //获取技能字符串
    
    NSString *skillStr = [self.skillArray objectAtIndex:index];
    
    //根据技能字符串获取对应的技能数据数组中的下标
    
    NSInteger skillDataIndex = [_tempSkillArray indexOfObject:skillStr];
    
    //根据下标从技能数据数组中获取技能数据模型 调用Block传递
    
    self.selectedSkillImageViewBlock([self.skillDataArray objectAtIndex:skillDataIndex]);
    
}

#pragma mark ---装备图片视图点击事件

- (void)equipImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    //获取点击的图片视图
    
    UIImageView *imageView = (UIImageView *)tap.view;
    
    //获取下标
    
    NSInteger index = [self.equipImageArray indexOfObject:imageView];
    
    //根据下标获取装备ID
    
    NSString *equipID = [self.equipArray objectAtIndex:index];
    
    //调用Block传递选中的装备ID
    
    self.selectedEquipImageViewBlock([equipID integerValue]);
    
}

#pragma mark ---获取数据

-(void)setTitle:(NSString *)title {
    
    if (_title != title) {
        
        [_title release];
        
        _title = [title retain];
        
    }
    
    _titleLabel.text = title;
    
}

-(void)setExplainStr:(NSString *)explainStr{
    
    if (_explainStr != explainStr) {
        
        [_explainStr release];
        
        _explainStr = [explainStr retain];
        
    }
    
    _explainLabel.text = explainStr;
    
    //计算注释所需高度
    
    CGFloat explainLabelHeight = [NSString getHeightWithstring:explainStr Width:CGRectGetWidth(_explainLabel.frame) FontSize:14];
    
    //设置Frame
    
    _explainLabel.frame = CGRectMake(_explainLabel.frame.origin.x, _explainLabel.frame.origin.y, CGRectGetWidth(_explainLabel.frame), explainLabelHeight);
    
    //设置self的Frame
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth(self.frame), _explainLabel.frame.origin.y + CGRectGetHeight(_explainLabel.frame) + 20 );
    
    
}

- (void)setSkillArray:(NSArray *)skillArray{
    
    if (_skillArray != skillArray) {
        
        [_skillArray release];
        
        _skillArray = [skillArray retain];
        
    }
    
    //清空装备图片内容
    
    for (UIImageView *imageView in _skillImageArray) {
        
        imageView.image = nil;
        
    }
    
    //加载技能图片内容
    
    for (NSInteger i = 0 ; i < skillArray.count ; i ++ ) {
        
        NSString *skillStr = skillArray[i];
        
        NSInteger index = [_tempSkillArray indexOfObject:skillStr];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:KUnion_Ency_HeroSkillImageURL , [self.skillDataArray[index] key] ]];
        
        EquipSelectDetailsItemCustomImageView *imageView = _skillImageArray[i];
        
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
        
        imageView.title = skillStr;
        
    }
    
}

-(void)setEquipArray:(NSArray *)equipArray{
    
    if (_equipArray != equipArray) {
        
        [_equipArray release];
        
        _equipArray = [equipArray retain];
        
    }
    
    //清空装备图片内容
    
    for (UIImageView *imageView in _equipImageArray) {
        
        imageView.image = nil;
        
    }
    
    //加载装备图片内容
    
    for (NSInteger i = 0 ; i < equipArray.count ; i ++ ) {
        
        NSString *equipID = equipArray[i];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kUnion_Equip_ListImageURL , [equipID integerValue]]];
        
        UIImageView *imageView = _equipImageArray[i];
        
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
        
    }
    
}




@end
