//
//  RunesCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/14.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "RunesCell.h"


@interface RunesCell ()

@property (nonatomic , retain ) UIImageView *picImageView;//符文图片视图

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UILabel *priceLabel;//价格

@property (nonatomic , retain ) UILabel *propLabel;//属性

@end

@implementation RunesCell

-(void)dealloc{
    
    [_picImageView release];
    
    [_titleLabel release];
    
    [_priceLabel release];
    
    [_propLabel release];
    
    [_model release];
    
    [super dealloc];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        //初始化图片
        
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5 , 10 , 70 , 80 )];
        
        _picImageView.image = [UIImage imageNamed:@"poluoimage_gray"];
        
        _picImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_picImageView];
        
        //初始化标题
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 , CGRectGetHeight(_picImageView.frame) + 25 , CGRectGetWidth(self.frame) - 10 , 20)];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor blackColor];
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [self addSubview:_titleLabel];
        
        
        //初始化价格
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 , _titleLabel.frame.origin.y + CGRectGetHeight(_titleLabel.frame) , CGRectGetWidth(_titleLabel.frame) , 20)];
        
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        _priceLabel.textColor = [UIColor blackColor];
        
        _priceLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_priceLabel];


        //初始化属性
        
        _propLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 , _priceLabel.frame.origin.y + CGRectGetHeight(_priceLabel.frame) , CGRectGetWidth(_priceLabel.frame) , 55)];
        
        _propLabel.textAlignment = NSTextAlignmentCenter;
        
        _propLabel.textColor = [UIColor blackColor];
        
        _propLabel.font = [UIFont systemFontOfSize:14];
        
        _propLabel.numberOfLines = 0;
        
        [self addSubview:_propLabel];

        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //图片
    
    _picImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , _picImageView.center.y);
    
    //初始化标题
    
    _titleLabel.frame = CGRectMake(5 , CGRectGetHeight(_picImageView.frame) + 25 , CGRectGetWidth(self.frame) - 10  , 20);
    
    //初始化价格
    
    _priceLabel.frame = CGRectMake(5 , _titleLabel.frame.origin.y + CGRectGetHeight(_titleLabel.frame) , CGRectGetWidth(_titleLabel.frame) , 20);
    
    //初始化属性
    
    _propLabel.frame = CGRectMake(5 , _priceLabel.frame.origin.y + CGRectGetHeight(_priceLabel.frame) , CGRectGetWidth(_priceLabel.frame) , 55);
    
}

#pragma mark ---获取数据

-(void)setModel:(RunesModel *)model {
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
    }
    
    //处理数据
    
    //SDWebImage异步加载图片
    
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_RunesImageURL , model.Img , model.level ] ] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
    
    _titleLabel.text = model.Name;
    
    //计算当前等级数据
    
    switch (model.level) {
        case 1:
            
            _priceLabel.text = [NSString stringWithFormat:@"%ld级 金币:%@" , model.level , model.iplev1 ];
            
            _propLabel.text = [NSString stringWithFormat:@"%@%@%@" , model.lev1 , model.Units , model.Prop ];
            
            break;
            
        case 2:
            
            _priceLabel.text = [NSString stringWithFormat:@"%ld级 金币:%@" , model.level , model.iplev2 ];
            
            _propLabel.text = [NSString stringWithFormat:@"%@%@%@" , model.lev2 , model.Units , model.Prop ];
            
            break;
            
        case 3:
            
            _priceLabel.text = [NSString stringWithFormat:@"%ld级 金币:%@" , model.level , model.iplev3 ];
            
            _propLabel.text = [NSString stringWithFormat:@"%@%@%@" , model.lev3 , model.Units , model.Prop ];
            
            break;
            
        default:
            break;
    }
    
}




@end
