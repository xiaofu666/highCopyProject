//
//  SummonerListTableViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SummonerListTableViewCell.h"

#import "PCH.h"

#import "NSString+GetWidthHeight.h"

#import "NSString+URL.h"

#import <UIImageView+WebCache.h>

#import "SummonerDataBaseManager.h"

@interface SummonerListTableViewCell ()

@property (nonatomic , retain ) SummonerDataBaseManager * SDBM;//召唤师数据库管理对象

@property (nonatomic , retain ) UIImageView *picImageView;//头像图片

@property (nonatomic , retain ) UILabel *userNameLabel;//用户名

@property (nonatomic , retain ) UILabel *serverFullNameLabel;//服务器全名

@property (nonatomic , retain ) UILabel *serverNameLabel;//服务器名

@property (nonatomic , retain ) UILabel *tierDescLabel;//段位描述

@property (nonatomic , retain ) UILabel *levelLabel;//等级

@property (nonatomic , retain ) UILabel *zdlLabel;//战斗力

@property (nonatomic , retain ) UIImageView *zdlImageView;//战斗力图标

@property (nonatomic , retain ) UIButton *isDefaultButton;//默认按钮

@property (nonatomic , retain ) UIButton *notDefaultButton;//非默认按钮

@property (nonatomic , retain ) AFHTTPRequestOperationManager *manager;//AFNetWorking


@end

@implementation SummonerListTableViewCell

-(void)dealloc{
    
    [_summonerModel release];
    
    [_picImageView release];
    
    [_userNameLabel release];
    
    [_serverFullNameLabel release];
    
    [_serverNameLabel release];
    
    [_tierDescLabel release];
    
    [_levelLabel release];
    
    [_zdlLabel release];
    
    [_zdlImageView release];
    
    [_isDefaultButton release];
    
    [_notDefaultButton release];
    
    [_manager release];
    
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
        
        self.clipsToBounds = YES;
        
        self.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 100);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化头像图片
        
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
        
        _picImageView.layer.cornerRadius = 30;
        
        _picImageView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_picImageView];
        
        //初始化等级
        
        UIView *levelView = [[UIView alloc]initWithFrame:CGRectMake(42, 42, 16, 16)];
        
        levelView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        
        [_picImageView addSubview:levelView];
        
        _levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        
        _levelLabel.text = @"30";
        
        _levelLabel.font = [UIFont systemFontOfSize:12];
        
        _levelLabel.textColor = [UIColor whiteColor];
        
        _levelLabel.backgroundColor = [UIColor clearColor];
        
        _levelLabel.textAlignment = NSTextAlignmentCenter;
        
        [levelView addSubview:_levelLabel];
        
        [levelView release];
        
        //初始化用户名
        
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 5 , CGRectGetWidth(self.frame) - 160, 30)];
        
        _userNameLabel.textColor = [UIColor blackColor];
        
        _userNameLabel.font = [UIFont boldSystemFontOfSize:16];
        
        _userNameLabel.text = @"Terminator丶LX";
        
        [self addSubview:_userNameLabel];
        
        //初始化服务器全名
        
        _serverFullNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 70, 20)];
        
        _serverFullNameLabel.textColor = [UIColor lightGrayColor];
        
        _serverFullNameLabel.font = [UIFont systemFontOfSize:14];
        
        _serverFullNameLabel.text = @"比尔吉沃特";
        
        [self addSubview:_serverFullNameLabel];
        
        //服务器名
        
        _serverNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 35, 70, 20)];
        
        _serverNameLabel.textColor = [UIColor lightGrayColor];
        
        _serverNameLabel.font = [UIFont systemFontOfSize:14];
        
        _serverNameLabel.text = @"网通一";
        
        [self addSubview:_serverNameLabel];
        
        
        //初始化段位描述
        
        _tierDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 55, 60 , 20)];
        
        _tierDescLabel.textColor = MAINCOLOER;
        
        _tierDescLabel.font = [UIFont systemFontOfSize:14];
        
        _tierDescLabel.text = @"大师/II";
        
        [self addSubview:_tierDescLabel];
        
        //初始化战斗力
        
        _zdlImageView = [[UIImageView alloc]initWithFrame:CGRectMake(150, 60, 12 , 12)];
        
        _zdlImageView.tintColor = MAINCOLOER;
        
        _zdlImageView.image = [[UIImage imageNamed:@"iconfont-zhandou"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _zdlImageView.backgroundColor = [UIColor clearColor];
        
        _zdlImageView.alpha = 1;
        
        [self addSubview:_zdlImageView];
        
        _zdlLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 55, 80 , 20)];
        
        _zdlLabel.textColor = MAINCOLOER;
        
        _zdlLabel.textAlignment = NSTextAlignmentCenter;
        
        _zdlLabel.text = @"99999";
        
        _zdlLabel.font = [UIFont systemFontOfSize:14];//HelveticaNeue-UltraLight
        
        [self addSubview:_zdlLabel];
        
        
        //初始化默认按钮
        
        _isDefaultButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
        _isDefaultButton.frame = CGRectMake( CGRectGetWidth(self.frame) - 100, 25 , 80, 30);
        
        [_isDefaultButton setTitle:@"默认" forState:UIControlStateNormal];
        
        [_isDefaultButton setTitleColor:MAINCOLOER forState:UIControlStateNormal];
        
        _isDefaultButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_isDefaultButton];
        
        
        //初始化非默认按钮
        
        _notDefaultButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
        _notDefaultButton.frame = CGRectMake( CGRectGetWidth(self.frame) - 100, 25 , 80, 30);
        
        _notDefaultButton.layer.cornerRadius = 4;
        
        [_notDefaultButton setTitle:@"设为默认" forState:UIControlStateNormal];
        
        [_notDefaultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _notDefaultButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_notDefaultButton setBackgroundColor:MAINCOLOER];
        
        [_notDefaultButton addTarget:self action:@selector(notDefaultButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_notDefaultButton];
        
        
    }
    
    return self;
    
}

#pragma mark ---设为默认事件

- (void)notDefaultButtonAction:(UIButton *)sender{
    
    if (self.isDefault == NO) {
        
        [self saveSummonerData:_summonerModel.summonerName ServerName:_summonerModel.serverName];
        
        //调用更新数据block 更新表视图
        
        self.reloadDataBlock();
    }
    
}

- (void)saveSummonerData:(NSString *)summonerName ServerName:(NSString *)serverName{
    
    //持久化存储召唤师数据 (召唤师名称 服务器名称)
    
    //1.获取NSUserDefaults对象
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    //2.读取保存的数据
    
    [defaults setValue:summonerName forKey:@"SummonerName"];
    
    [defaults setValue:serverName forKey:@"ServerName"];
    
    //3.强制让数据立刻保存
    
    [defaults synchronize];

    
}



//获取数据

-(void)setSummonerModel:(SummonerModel *)summonerModel{
    
    if (_summonerModel != summonerModel) {
        
        [_summonerModel release];
        
        _summonerModel = [summonerModel retain];
        
    }
    
    //判断是否为默认
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *summonerStr = [defaults stringForKey:@"SummonerName"];
    
    NSString *serverNameStr = [defaults stringForKey:@"ServerName"];
    
    
    if ([summonerStr isEqualToString:summonerModel.summonerName] && [serverNameStr isEqualToString:summonerModel.serverName]) {
        
        //显示默认按钮 隐藏设为默认按钮
        
        _isDefaultButton.hidden = NO;
        
        _notDefaultButton.hidden = YES;
        
    } else {
        
        _isDefaultButton.hidden = YES;
        
        _notDefaultButton.hidden = NO;
        
    }
    
    //计算服务器全名所需宽度 并设置相关frame
    
    CGFloat serverFullNameWidth = [NSString getWidthWithstring:summonerModel.serverFullName Width:70 FontSize:14];
    
    _serverFullNameLabel.frame = CGRectMake(_serverFullNameLabel.frame.origin.x, _serverFullNameLabel.frame.origin.y, serverFullNameWidth, 20);
    
    _serverNameLabel.frame = CGRectMake(_serverFullNameLabel.frame.origin.x + serverFullNameWidth + 10, _serverNameLabel.frame.origin.y, CGRectGetWidth(_serverNameLabel.frame), 20);
    
    
    //添加数据
    
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_MyUnion_IconURL , summonerModel.icon]]];
    
    _serverFullNameLabel.text = summonerModel.serverFullName;
    
    _serverNameLabel.text = summonerModel.serverName;
    
    _userNameLabel.text = summonerModel.summonerName;
    
    _tierDescLabel.text = summonerModel.tierDesc;
    
    _zdlLabel.text = [NSString stringWithFormat:@"%ld" , (long)summonerModel.zdl];
    
    _levelLabel.text = summonerModel.level;
    
    
    //请求数据 并更新数据库中的信息
    
    [self requestData:summonerModel.serverName SummonerName:summonerModel.summonerName];
    
}

#pragma mark ---请求数据

- (void)requestData:(NSString *)serverName SummonerName:(NSString *)summonerName{
    
    __block SummonerListTableViewCell *Self = self;
    
    //取消之前的请求
    
    [[self.manager operationQueue ] cancelAllOperations];
    
    //执行新的请求操作
    
    NSString *url = [[NSString stringWithFormat:kUnion_MyUion_AddSummonerURL , serverName , summonerName] URLEncodedString];
    
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject != nil) {
            
            //解析数据
            
            [Self JSONAnalyticalWithData:responseObject];
            
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}


#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(id)data{
    
    if (data != nil) {
        
        NSDictionary *dic = data;
        
        NSDictionary *itemDic = [dic valueForKey:self.summonerModel.summonerName];
        
        SummonerModel *SM = [[SummonerModel alloc]init];
        
        SM.serverName = [[itemDic valueForKey:@"sn"] retain];
        
        SM.serverFullName = [[itemDic valueForKey:@"snFullName"] retain];
        
        SM.summonerName = [[itemDic valueForKey:@"pn"] retain];
        
        SM.level = [[itemDic valueForKey:@"level"] retain];
        
        SM.icon = [[itemDic valueForKey:@"icon"] retain];
        
        SM.zdl = [[itemDic valueForKey:@"zdl"] integerValue];
        
        SM.tier = [[itemDic valueForKey:@"tier"] integerValue];
        
        SM.rank = [[itemDic valueForKey:@"rank"] integerValue];
        
        SM.leaguePoints = [[itemDic valueForKey:@"league_points"] integerValue];
        
        SM.tierDesc = [[itemDic valueForKey:@"tierDesc"] retain];
        
        //更新数据库中数据
        
        [self updateSummonerDataBase:SM];
        
        //判断战斗力是否有改变 如果不相等 则重新刷新数据
        
        if (SM.leaguePoints != self.summonerModel.leaguePoints) {
            
            //重新加载数据
            
            self.summonerModel = SM;
            
            //调用更新数据block 更新表视图
            
            self.reloadDataBlock();
            
        }

    }
    
    
}

#pragma mark ---更新数据库中数据

- (void)updateSummonerDataBase:(SummonerModel *)summonerModel{
    
    //更新操作
    
    [self.SDBM updateSummonerWithSID:summonerModel];
    
   


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

-(AFHTTPRequestOperationManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [[AFHTTPRequestOperationManager manager] retain];
        
        // 设置超时时间
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer.timeoutInterval = 15.0f;
        
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    
    return _manager;
    
}

@end
