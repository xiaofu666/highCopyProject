//
//  MyUnion_UserTableViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MyUnion_UserTableViewCell.h"

#import "SummonerModel.h"

#import "Networking.h"

#import "SummonerDataBaseManager.h"

#import "PCH.h"

#import <UIImageView+WebCache.h>

@interface MyUnion_UserTableViewCell ()

@property (nonatomic , retain ) SummonerModel *summonerModel;//召唤师数据模型

@property (nonatomic , retain ) UIImageView *picImageView;//头像图片

@property (nonatomic , retain ) UILabel *userNameLabel;//用户名

@property (nonatomic , retain ) UILabel *serverFullNameLabel;//服务器全名

@property (nonatomic , retain ) UILabel *tierDescLabel;//段位描述

@property (nonatomic , retain ) UILabel *levelLabel;//等级

@property (nonatomic , retain ) UILabel *zdlLabel;//战斗力

@property (nonatomic , retain ) UIImageView *zdlImageView;//战斗力图标

@property (nonatomic , retain ) UIView *zdlView;//战斗力背景视图



@property (nonatomic , copy ) NSString *summonerName;//用户名称(召唤师名称)

@property (nonatomic , copy ) NSString *serverName;//服务器名称(召唤师区名称)

@property (nonatomic , retain ) SummonerDataBaseManager * SDBM;//召唤师数据库管理对象


@property (nonatomic , retain ) UILabel *promptLabel;//提示标签


@end

@implementation MyUnion_UserTableViewCell


-(void)dealloc{
    
    [_summonerModel release];
    
    [_picImageView release];
    
    [_userNameLabel release];
    
    [_serverFullNameLabel release];
    
    [_tierDescLabel release];
    
    [_levelLabel release];
    
    [_zdlLabel release];
    
    [_zdlImageView release];
    
    [_zdlView release];
    
    [_summonerName release] ;
    
    [_serverName release];
    
    [_promptLabel release];
    
    //移除通知
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    [super dealloc];
}

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = MAINCOLOER;
        
        self.clipsToBounds = YES;
        
        self.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 100);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化头像图片
        
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
        
        _picImageView.image = [UIImage imageNamed:@"poluoimage_gray"];
        
        _picImageView.layer.cornerRadius = 30;
        
        _picImageView.clipsToBounds = YES;
        
        _picImageView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_picImageView];
        
        //初始化等级
        
        UIView *levelView = [[UIView alloc]initWithFrame:CGRectMake(58, 55, 20, 20)];
        
        levelView.layer.cornerRadius = 10;
        
        levelView.backgroundColor = MAINCOLOER;
        
        [self addSubview:levelView];
        
        _levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 16, 16)];
        
        _levelLabel.font = [UIFont systemFontOfSize:12];
        
        _levelLabel.textColor = [UIColor whiteColor];
        
        _levelLabel.backgroundColor = [UIColor clearColor];
        
        _levelLabel.textAlignment = NSTextAlignmentCenter;
        
        [levelView addSubview:_levelLabel];
        
        [levelView release];
        
        
        //初始化用户名
        
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, CGRectGetWidth(self.frame) - 160, 30)];
        
        _userNameLabel.textColor = [UIColor whiteColor];
        
        _userNameLabel.font = [UIFont boldSystemFontOfSize:18];
        
//        _userNameLabel.text = @"Terminator丶LX";
        
        [self addSubview:_userNameLabel];
        
        //初始化服务器全名
        
        _serverFullNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 70, 30)];
        
        _serverFullNameLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        
        _serverFullNameLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_serverFullNameLabel];
        
        //初始化段位描述
        
        _tierDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 50, 60 , 30)];
        
        _tierDescLabel.textColor = [UIColor whiteColor];
        
        _tierDescLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_tierDescLabel];
        
        //初始化战斗力
        
        _zdlView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 100, 0, 240, 240)];
        
        _zdlView.backgroundColor = [UIColor whiteColor];
        
        _zdlView.layer.cornerRadius = 120;
        
        _zdlView.center = CGPointMake(CGRectGetWidth(self.frame) + 20, CGRectGetHeight(self.frame) / 2);
        
        [self addSubview:_zdlView];
        
        _zdlImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 80, 80 , 80)];
        
        _zdlImageView.tintColor = MAINCOLOER;
        
        _zdlImageView.image = [[UIImage imageNamed:@"iconfont-zhandouli"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _zdlImageView.backgroundColor = [UIColor clearColor];
        
        _zdlImageView.alpha = 0.1;
        
        [_zdlView addSubview:_zdlImageView];
        
        _zdlLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 105 , 60)];
        
        _zdlLabel.textColor = MAINCOLOER;
        
        _zdlLabel.textAlignment = NSTextAlignmentCenter;
        
        _zdlLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:34];//HelveticaNeue-UltraLight
        
        [_zdlView addSubview:_zdlLabel];
        
        
        //初始化提示标签
        
        _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, CGRectGetWidth(self.frame) - 160, 30)];
        
        _promptLabel.textColor = [UIColor whiteColor];
        
        _promptLabel.font = [UIFont boldSystemFontOfSize:20];
        
        _promptLabel.text = @"赶快添加召唤师吧";
        
        [self addSubview:_promptLabel];
    
        
        //添加通知
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSuccess:) name:@"AddSuccess" object:nil];
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //适配 iPhone6以上布局
    
    if (CGRectGetWidth(self.frame) > 320 && CGRectGetWidth(self.frame) < 414) {
        
        _zdlImageView.superview.center =  CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2);
        
        _zdlImageView.frame = CGRectMake(30, 80, 80 , 80);
        
        _zdlLabel.frame = CGRectMake(5, 90, 120 , 60);
        
        _zdlLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
        
    } else if (CGRectGetWidth(self.frame) >= 414) {
        
        _zdlImageView.superview.center =  CGPointMake(CGRectGetWidth(self.frame) - 20, CGRectGetHeight(self.frame) / 2);
        
        _zdlImageView.frame = CGRectMake(30, 80, 80 , 80);
        
        _zdlLabel.frame = CGRectMake(5, 90, 130 , 60);
        
        _zdlLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:46];
        
    }
    
    
}


//添加成功通知

- (void)AddSuccess:(NSNotificationCenter *)no{
    
    //重新调用加载数据
    
    [self loadData];
    
    
}

#pragma mark ---加载数据

- (void)loadData{
    
    //--获取当前召唤师名称 服务器名称
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *summonerStr = [defaults stringForKey:@"SummonerName"];
    
    NSString *serverNameStr = [defaults stringForKey:@"ServerName"];

    
    if (summonerStr != nil && serverNameStr != nil) {
        
        _zdlView.center = CGPointMake(CGRectGetWidth(self.frame) + 20, CGRectGetHeight(self.frame) / 2);
        
        //隐藏提示标签
        
        _promptLabel.hidden = YES;
        
        //显示控件
        
        [self showViews];
        
        if (_summonerName == nil && _serverName == nil) {
            
            self.summonerName = @"";
            
            self.serverName = @"";
            
        }
        
        if ( ![_summonerName isEqualToString:summonerStr] || ![_serverName isEqualToString:serverNameStr] ) {
            
            _zdlView.center = CGPointMake(CGRectGetWidth(self.frame) + 20, CGRectGetHeight(self.frame) / 2);
            
            
            self.summonerName = summonerStr;
            
            self.serverName = serverNameStr;
            
            
            //查询数据库 获取召唤师信息
            
            _summonerModel = [self.SDBM selectSummonerWithSummonerName:_summonerName ServerName:_serverName];
            
            if (_summonerModel != nil) {
                
                
                
                //为控件添加数据
                
                [_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_MyUnion_IconURL , _summonerModel.icon]]];
                
                _serverFullNameLabel.text = _summonerModel.serverFullName;
                
                _userNameLabel.text = _summonerModel.summonerName;
                
                _tierDescLabel.text = _summonerModel.tierDesc;
                
                _zdlLabel.text = [NSString stringWithFormat:@"%ld" , (long)_summonerModel.zdl];
                
                _levelLabel.text = _summonerModel.level;
                
            }
            
            
        }

        
        
    } else {
        
        //显示提示标签 隐藏其他控件
        
        _promptLabel.hidden = NO;
        
        _zdlView.center = CGPointMake(CGRectGetWidth(self.frame) + 100, CGRectGetHeight(self.frame) / 2);
        
        [self hiddenViews];
        
    }
    
    
}


#pragma mark ---隐藏控件

- (void)hiddenViews{
    
    _picImageView.image = [UIImage imageNamed:@"poluoimage_gray"];
    
    _serverFullNameLabel.hidden = YES;
    
    _userNameLabel.hidden = YES;
    
    _tierDescLabel.hidden = YES;
    
    _levelLabel.hidden = YES;
    
    _zdlLabel.hidden = YES;
    
}

#pragma mark ---显示控件

- (void)showViews{
    
    [self hiddenViews];
    
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_MyUnion_IconURL , _summonerModel.icon]]];
    
    _serverFullNameLabel.hidden = NO;
    
    _userNameLabel.hidden = NO;
    
    _tierDescLabel.hidden = NO;
    
    _levelLabel.hidden = NO;
    
    _zdlLabel.hidden = NO;
    
}





#pragma mark ---LazyLoading

- (SummonerDataBaseManager *)SDBM{
    
    if (_SDBM == nil) {
        
        _SDBM = [SummonerDataBaseManager shareSummonerDataBaseManager];
        
        //创建数据库对象
        
        [_SDBM createDB];
        
        //创建召唤师表
        
        [_SDBM createSummoner];
        
    }
    
    return _SDBM;
    
}







@end
