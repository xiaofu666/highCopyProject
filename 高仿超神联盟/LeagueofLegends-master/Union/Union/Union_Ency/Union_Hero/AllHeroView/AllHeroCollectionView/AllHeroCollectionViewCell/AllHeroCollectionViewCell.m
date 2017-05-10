//
//  AllHeroCollectionViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/17.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AllHeroCollectionViewCell.h"

#import "PCH.h"

#import <UIImageView+WebCache.h>

@interface AllHeroCollectionViewCell ()


@property (nonatomic , retain ) UIImageView *picImageView;//英雄头像

@property (nonatomic , retain ) UILabel *titleLabel;//英雄标题


@end

@implementation AllHeroCollectionViewCell

-(void)dealloc{
    
    [_picImageView release];
    
    [_titleLabel release];
    
    [_listHero release];
    
    [super dealloc];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //初始化英雄头像
        
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        
        [self addSubview:_picImageView];
        
        //初始化英雄标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetWidth(self.frame) +15, CGRectGetWidth(self.frame) , 20)];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.numberOfLines = 0;
        
        [self addSubview:_titleLabel];
        
    }
    return self;
}


//获取英雄数据

-(void)setListHero:(ListHero *)listHero{
    
    if (_listHero != listHero) {
        
        [_listHero release];
        
        _listHero = [listHero retain];
        
    }
    
    //非空判断
    
    if (listHero != nil) {
        
        //拼接英雄头像url
        
        NSString *picURL = [NSString stringWithFormat:kUnion_Ency_HeroImageURL , listHero.enName];
        
        //SDWebImage 异步请求加载英雄图片 <根据英雄英文名字为参数>
        
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@""]];
        
        //添加英雄标题
        
        _titleLabel.text = listHero.title;
        
        
    }
    
    
    
}

@end
