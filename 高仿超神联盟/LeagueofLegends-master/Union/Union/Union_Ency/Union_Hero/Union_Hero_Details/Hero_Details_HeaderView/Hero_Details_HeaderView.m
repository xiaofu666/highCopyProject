//
//  Hero_Details_HeaderView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/8.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_HeaderView.h"

#import "PCH.h"

#import "CircleView.h"

#import "UIView+Shadow.h"



@interface Hero_Details_HeaderView ()

@property (nonatomic , retain ) UILabel *titleLabel;//英雄标题

@property (nonatomic , retain ) UILabel *heroNameLabel;//英雄中文名

@property (nonatomic , retain ) UILabel *tagsLabel;//英雄定位(战士)

@property (nonatomic , retain ) UILabel *priceLabel;//价格

@property (nonatomic , retain ) CircleView *ratingAttackCV;//评级(攻)

@property (nonatomic , retain ) CircleView *ratingDefenseCV;//评级(防)

@property (nonatomic , retain ) CircleView *ratingMagicCV;//评级(法)

@property (nonatomic , retain ) CircleView *ratingDifficultyCV;//评级(难)

@property (nonatomic , retain ) UIImageView *poluoImageView;//魄罗图片

@end

@implementation Hero_Details_HeaderView


-(void)dealloc{
    
    [_titleLabel release];
    
    [_heroNameLabel release];
    
    [_tagsLabel release];
    
    [_priceLabel release];
    
    [_ratingAttackCV release];
    
    [_ratingDefenseCV release];
    
    [_ratingMagicCV release];
    
    [_ratingDifficultyCV release];
    
    [_poluoImageView release];
    
    [_basicModel release];
    
    [super dealloc];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = MAINCOLOER;
        
        self.clipsToBounds = YES;
        
        //初始化英雄标题
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = [UIFont systemFontOfSize:18];
        
        _titleLabel.text = @"这里是称号";
        
        [self addSubview:_titleLabel];
        
        //初始化英雄名字
        
        _heroNameLabel = [[UILabel alloc]init];
        
        _heroNameLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
        
        _heroNameLabel.textAlignment = NSTextAlignmentCenter;
        
        _heroNameLabel.font = [UIFont boldSystemFontOfSize:30];
        
        _heroNameLabel.text = @"这里是名字";
        
        [self addSubview:_heroNameLabel];
        
        
        //初始化英雄定位
        
        _tagsLabel = [[UILabel alloc]init];
        
        _tagsLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
        
        _tagsLabel.textColor = [UIColor whiteColor];
        
        _tagsLabel.textAlignment = NSTextAlignmentCenter;
        
        _tagsLabel.font = [UIFont systemFontOfSize:16];
        
        _tagsLabel.text = @"加载中..";
        
        [self addSubview:_tagsLabel];
        
        //添加阴影
        
        [_tagsLabel dropShadowWithOffset:CGSizeMake(0, 1) radius:2 color:[UIColor darkGrayColor] opacity: 0.6];

        
        //初始化英雄价格
        
        _priceLabel = [[UILabel alloc]init];
        
        _priceLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
        
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        
        _priceLabel.font = [UIFont systemFontOfSize:14];
        
        _priceLabel.numberOfLines = 0;
        
        _priceLabel.text = @"这里是价格";
        
        [self addSubview:_priceLabel];
        
        
        CGFloat ratingX = ( CGRectGetWidth(self.frame) - 130  - 160) / 4;
        
        
        //初始化评级(攻)
        
        _ratingAttackCV = [[CircleView alloc]initWithFrame:CGRectMake(130 , 115, 30, 30)];
        
        _ratingAttackCV.strokeColor = [UIColor colorWithRed:234/255.0 green:57/255.0 blue:53/255.0 alpha:0.9];
        
        _ratingAttackCV.backColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
        _ratingAttackCV.title = @"攻";
        
        [self addSubview:_ratingAttackCV];
        
        //初始化评级(防)
        
        _ratingDefenseCV = [[CircleView alloc]initWithFrame:CGRectMake(130 + 40 + ratingX , 115, 30, 30)];
        
        _ratingDefenseCV.strokeColor = [UIColor colorWithRed:90/255.0 green:212/255.0 blue:38/255.0 alpha:0.9];
        
        _ratingDefenseCV.backColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
        _ratingDefenseCV.title = @"防";
        
        [self addSubview:_ratingDefenseCV];
        
        //初始化评级(法)
        
        _ratingMagicCV = [[CircleView alloc]initWithFrame:CGRectMake(130 + 40 * 2 + ratingX * 2 , 115, 30, 30)];
        
        _ratingMagicCV.strokeColor = [UIColor colorWithRed:45/255.0 green:203/255.0 blue:255/255.0 alpha:0.9];
        
        _ratingMagicCV.backColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
        _ratingMagicCV.title = @"法";
        
        [self addSubview:_ratingMagicCV];
        
        //初始化评级(难)
        
        _ratingDifficultyCV = [[CircleView alloc]initWithFrame:CGRectMake(130 + 40 * 3 + ratingX * 3  , 115, 30, 30)];
        
        _ratingDifficultyCV.strokeColor = [UIColor colorWithRed:148/255.0 green:99/255.0 blue:251/255.0 alpha:0.9];
        
        _ratingDifficultyCV.backColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
        _ratingDifficultyCV.title = @"难";
        
        [self addSubview:_ratingDifficultyCV];
        
        
        //初始化魄罗图标
        
        _poluoImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"poluoimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
        _poluoImageView.tintColor = [UIColor whiteColor];
        
        [self addSubview:_poluoImageView];
        
    }
    
    return self;

}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //英雄标题
    
    _titleLabel.frame = CGRectMake(80, 20, CGRectGetWidth(self.frame) - 160 , 40);
    
    //英雄名字
    
    _heroNameLabel.frame = CGRectMake((CGRectGetWidth(self.frame) - 150) / 2 , 70 , 150, 30);
    
    //英雄定位
    
    _tagsLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 80, 70, 80, 30);
    
    //英雄价格
    
    _priceLabel.frame = CGRectMake(0, 65 , (CGRectGetWidth(self.frame) - 150) / 2, 34);
    
    //魄罗图片
    
    _poluoImageView.frame = CGRectMake(15 , 160 - 50 , 50, 50);
    
}


- (void)setBasicModel:(Hero_Details_BasicModel *)basicModel {
    
    if (_basicModel != basicModel) {
        
        [_basicModel release];
        
        _basicModel = [basicModel retain];
        
    }
    
    //处理数据
    
    _titleLabel.text = basicModel.displayName;
    
    _heroNameLabel.text = basicModel.title;
    
    _tagsLabel.text = basicModel.tags;
    
    NSArray *priceArray = [basicModel.price componentsSeparatedByString:@","];
    
    _priceLabel.text = [NSString stringWithFormat:@"金:%@\n劵:%@",priceArray[0],priceArray[1]];
    
    //延迟0.8秒为环形进度条评级视图赋值
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [_ratingAttackCV setStrokeEnd:[_basicModel.ratingAttack floatValue] /10 animated:YES];
        
        [_ratingDefenseCV setStrokeEnd:[_basicModel.ratingDefense floatValue] /10 animated:YES];
        
        [_ratingMagicCV setStrokeEnd:[_basicModel.ratingMagic floatValue] /10 animated:YES];
        
        [_ratingDifficultyCV setStrokeEnd:[_basicModel.ratingDifficulty floatValue] /10 animated:YES];
        
        
    });
    
    
    
}

#pragma mark ---初始化数据

- (void)initData{
    
    _titleLabel.text = @"这里是称号";
    
    _heroNameLabel.text = @"这里是名字";
    
    _priceLabel.text = @"这里是价格";
    
    _tagsLabel.text = @"加载中..";
    
    //初始化评级数据
    
    [_ratingAttackCV setStrokeEnd:1.0f animated:NO];
    
    [_ratingDefenseCV setStrokeEnd:1.0f animated:NO];
    
    [_ratingMagicCV setStrokeEnd:1.0f animated:NO];
    
    [_ratingDifficultyCV setStrokeEnd:1.0f animated:NO];

    
}



@end
