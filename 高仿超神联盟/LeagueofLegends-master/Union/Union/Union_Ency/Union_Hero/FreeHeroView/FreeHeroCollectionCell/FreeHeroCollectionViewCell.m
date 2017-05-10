//
//  FreeHeroCollectionViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/16.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "FreeHeroCollectionViewCell.h"

#import "PCH.h"

#import <UIImageView+WebCache.h>

@interface FreeHeroCollectionViewCell ()


@property (nonatomic , retain ) UIImageView *picImageView;//英雄头像

@property (nonatomic , retain ) UILabel *titleLabel;//英雄标题

@property (nonatomic , retain ) UILabel *nameLabel;//英雄中文名字

@property (nonatomic , retain ) UILabel *locationLabel;//英雄位置

@end

@implementation FreeHeroCollectionViewCell

-(void)dealloc{
    
    [_listHero release];
    
    [_titleLabel release];
    
    [_picImageView release];
    
    [_nameLabel release];
    
    [_locationLabel release];
    
    [super dealloc];
    
}

//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //初始化英雄头像
        
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 60, 60)];
        
        [self addSubview:_picImageView];
        
        //初始化英雄标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, CGRectGetWidth(self.frame) - 70 , 20)];
        
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.numberOfLines = 0;
        
        [self addSubview:_titleLabel];
        
        //初始化英雄中文名
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, CGRectGetWidth(self.frame) - 70 , 20)];
        
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = [UIColor lightGrayColor];
        
        _nameLabel.numberOfLines = 0;
        
        [self addSubview:_nameLabel];
        
        
        //初始化英雄位置
        
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, CGRectGetWidth(self.frame) - 70 , 20)];
        
        _locationLabel.font = [UIFont systemFontOfSize:12];
        
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        
        _locationLabel.textColor = MAINCOLOER;//主题颜色
        
        _locationLabel.numberOfLines = 0;
        
        [self addSubview:_locationLabel];
        
        
    }
    return self;
}


//获取免费英雄数据

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
        
        //添加英雄中文名字
        
        _nameLabel.text = listHero.cnName;
        
        //添加英雄位置
        
        _locationLabel.text = listHero.location;
        
    }
    
    
    
}

@end
