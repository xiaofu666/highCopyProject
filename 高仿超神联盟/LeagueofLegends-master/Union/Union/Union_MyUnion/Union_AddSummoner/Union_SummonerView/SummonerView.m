//
//  SummonerView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SummonerView.h"

#import <UIImageView+WebCache.h>

#import "NSString+GetWidthHeight.h"

#import "PCH.h"


@interface SummonerView ()

@property (nonatomic , retain ) UIImageView *picImageView;//召唤师头像

@property (nonatomic , retain ) UILabel *summonerNameLabel;//召唤师名字

@property (nonatomic , retain ) UILabel *serverFullNameLabel;//服务器全名

@property (nonatomic , retain ) UILabel *tierDescLabel;//段位描述

@property (nonatomic , retain ) UILabel *zdlLabel;//战斗力


@property (nonatomic , retain ) UIImageView *promptImageView;//提示图片

@end

@implementation SummonerView

-(void)dealloc{
    
    [_picImageView release];
    
    [_summonerNameLabel release];
    
    [_serverFullNameLabel release];
    
    [_tierDescLabel release];
    
    [_zdlLabel release];
    
    [_customColor release];
    
    [_promptImageView release];
    
    [super dealloc];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        //初始化召唤师头像
        
        _picImageView = [[UIImageView alloc]init];
        
        _picImageView.layer.borderColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.8f] CGColor];
        
        _picImageView.layer.borderWidth = 3;
        
        _picImageView.layer.cornerRadius = 40;
        
        _picImageView.clipsToBounds = YES;
        
        [self addSubview:_picImageView];
        
        //初始化召唤师名字
        
        _summonerNameLabel = [[UILabel alloc]init];
        
        _summonerNameLabel.textColor = _customColor;
        
        _summonerNameLabel.font = [UIFont boldSystemFontOfSize: 22];
        
        _summonerNameLabel.textAlignment = NSTextAlignmentCenter;

        
        [self addSubview:_summonerNameLabel];
        
        
        //初始化服务器全名
        
        _serverFullNameLabel = [[UILabel alloc]init];
        
        _serverFullNameLabel.textColor = _customColor;
        
        _serverFullNameLabel.font = [UIFont systemFontOfSize:16];
        
        _serverFullNameLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_serverFullNameLabel];
        
        
        //初始化段位描述
        
        _tierDescLabel = [[UILabel alloc]init];
        
        _tierDescLabel.textColor = _customColor;
        
        _tierDescLabel.font = [UIFont systemFontOfSize:16];
        
        _tierDescLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_tierDescLabel];

        
        
        //初始化战斗力
        
        _zdlLabel = [[UILabel alloc]init];
        
        _zdlLabel.textColor = _customColor;
        
        _zdlLabel.font = [UIFont systemFontOfSize:18];
        
        _zdlLabel.textAlignment = NSTextAlignmentCenter;
        
        _zdlLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self addSubview:_zdlLabel];
        
        //初始化提示视图
        
        _promptImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        
        _promptImageView.frame = CGRectMake(0, 0, 150, 150);
        
        _promptImageView.center = CGPointMake(CGRectGetWidth(self.frame)/2 , CGRectGetHeight(self.frame) / 2);
        
        _promptImageView.backgroundColor = [UIColor lightGrayColor];
        
        _promptImageView.hidden = YES; //默认隐藏
        
        [self addSubview:_promptImageView];
 
    }
    return self;
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置布局
    
    _picImageView.frame = CGRectMake(0, 0, 80, 80);
    
    _picImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , (CGRectGetHeight(self.frame) - 40) / 9 * 3 );
    
    _summonerNameLabel.frame = CGRectMake(0, 0 , CGRectGetWidth(self.frame), 30);
    
    _summonerNameLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , ( CGRectGetHeight(self.frame) - 40) / 9 * 6 - 10 );
    
    _serverFullNameLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 30);
    
    _serverFullNameLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2, (CGRectGetHeight(self.frame) - 40) / 9 *7 );
    
    _tierDescLabel.frame = CGRectMake(0 , 0, CGRectGetWidth(self.frame), 30);
    
    _tierDescLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2, (CGRectGetHeight(self.frame) - 40 ) / 9 * 8 );
    
    _zdlLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 40, CGRectGetWidth(self.frame), 40);
    
}

-(void)setSM:(SummonerModel *)SM{
    
    if (_SM != SM) {
        
        [_SM release];
        
        _SM = [SM retain];
        
    }
    
    if (SM != nil) {
        
        _picImageView.hidden = NO;
        
        _zdlLabel.hidden = NO;
        
        //添加数据
        
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_MyUnion_IconURL , SM.icon]]];
        
        _summonerNameLabel.text = SM.summonerName;
        
        _serverFullNameLabel.text = [NSString stringWithFormat:@"%@  %@",SM.serverFullName , SM.serverName];
        
        _tierDescLabel.text = [NSString stringWithFormat:@"%@  %ld",SM.tierDesc , (long)SM.leaguePoints];
        
        _zdlLabel.text = [NSString stringWithFormat:@"战斗力: %ld" , (long)SM.zdl];
        
    } else {
        
        //显示提示图片
        
        _promptImageView.hidden = NO;
        
        _picImageView.hidden = YES;
    
        _zdlLabel.hidden = YES;
        
    }
    
    
}


- (void)setCustomColor:(UIColor *)customColor{
    
    if (_customColor != customColor) {
        
        [_customColor release];
        
        _customColor = [customColor retain];
        
    }
    
    //设置颜色
    
    _summonerNameLabel.textColor = customColor;
    
    _serverFullNameLabel.textColor = customColor;
    
    _tierDescLabel.textColor = customColor;
    
    _zdlLabel.textColor = customColor;
    
}

@end
