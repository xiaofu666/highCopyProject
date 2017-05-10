//
//  MyHeroTableViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MyHeroTableViewCell.h"

#import "PCH.h"

#import "NSString+GetWidthHeight.h"

#import <UIImageView+WebCache.h>

@interface MyHeroTableViewCell ()

@property (nonatomic , retain ) UIImageView *picImageView;//英雄头像

@property (nonatomic , retain ) UILabel *titleLabel;//英雄标题

@property (nonatomic , retain ) UILabel *nameLabel;//英雄中文名字

@property (nonatomic , retain ) UILabel *presentTimesLabel;//最近使用场次

@property (nonatomic , retain ) UILabel *ptLabel;//场次标签

@property (nonatomic , retain ) UILabel *rating;//评级标签

@end

@implementation MyHeroTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    
    [_picImageView release];
    
    [_titleLabel release];
    
    [_nameLabel release];
    
    [_presentTimesLabel release];
    
    [_listHero release];
    
    [_ptLabel release];
    
    [_rating release];
    
    [super dealloc];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //初始化英雄头像
        
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        
        _picImageView.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _picImageView.tintColor = [UIColor lightGrayColor];
        
        [self addSubview:_picImageView];
        
        //初始化英雄标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 0, 30)];
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.numberOfLines = 0;
        
        [self addSubview:_titleLabel];
        
        //初始化英雄中文名
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 30)];
        
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = [UIColor lightGrayColor];
        
        _nameLabel.numberOfLines = 0;
        
        [self addSubview:_nameLabel];
        
        
        //初始化英雄场次
        
        _ptLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 40, 20)];
        
        _ptLabel.font = [UIFont systemFontOfSize:14];
        
        _ptLabel.textAlignment = NSTextAlignmentLeft;
        
        _ptLabel.textColor = [UIColor lightGrayColor];
        
        _ptLabel.text = @"场次:";
        
        [self addSubview:_ptLabel];
        
        _presentTimesLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 40, CGRectGetWidth(self.frame) - 130 , 20)];
        
        _presentTimesLabel.font = [UIFont systemFontOfSize:14];
        
        _presentTimesLabel.textAlignment = NSTextAlignmentLeft;
        
        _presentTimesLabel.textColor = MAINCOLOER;//主题颜色
        
        _presentTimesLabel.numberOfLines = 0;
        
        [self addSubview:_presentTimesLabel];
        
        
        //初始化英雄评级
        
        _rating = [[UILabel alloc]initWithFrame:CGRectMake(90 , 40, CGRectGetWidth(self.frame) - 90 , 20)];
        
        _rating.font = [UIFont systemFontOfSize:14];
        
        _rating.textAlignment = NSTextAlignmentLeft;
        
        _rating.textColor = [UIColor lightGrayColor];
        
        [self addSubview:_rating];
        
        
    }
    
    return self;
    
}


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
        
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        //添加英雄标题
        
        _titleLabel.text = listHero.title;
        
        //计算标题所需宽度
        
        CGFloat titleWidth = [NSString getWidthWithstring:listHero.title Width:CGRectGetWidth(self.frame) - 90 FontSize:16];
        
        _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, titleWidth, _titleLabel.frame.size.height);
        
        //添加英雄中文名字
        
        _nameLabel.text = listHero.cnName;
        
        _nameLabel.frame = CGRectMake(_titleLabel.frame.origin.x + titleWidth + 10, _nameLabel.frame.origin.y, _nameLabel.frame.size.width, _nameLabel.frame.size.height);
        
        //添加英雄最近使用场次
        
        //判断场次是否为空
        
        if ([listHero.presentTimes isEqualToString:@""]) {
            
            //如果没有场次 隐藏场次Label
            
            _ptLabel.hidden = YES;
            
            _presentTimesLabel.hidden = YES;
            
            _rating.hidden = NO;
            
            _rating.text = [NSString stringWithFormat:@"攻: %@ 防: %@ 法: %@ 难度: %@" , listHero.ratingA , listHero.ratingB , listHero.ratingC , listHero.ratingD ];
            
            
            
        } else {
            
            //隐藏评级标签
            
            _rating.hidden = YES;
            
            _ptLabel.hidden = NO;
            
            _presentTimesLabel.hidden = NO;
            
            _presentTimesLabel.text = listHero.presentTimes;
            
        }

    }

}



@end
