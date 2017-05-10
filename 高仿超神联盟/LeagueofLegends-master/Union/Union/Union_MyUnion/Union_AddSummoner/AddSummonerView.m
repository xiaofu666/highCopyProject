//
//  AddSummonerView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/18.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AddSummonerView.h"

#import "ServerNameInputPickerView.h"

#import "PCH.h"

#import "Networking.h"

#import "NSString+URL.h"

#import "SummonerModel.h"

#import <POP.h>

#import "SummonerDataBaseManager.h"

#import "SummonerView.h"

#import "UIView+LXAlertView.h"

#import "LoadingView.h"

@interface AddSummonerView ()<ServerNameInputPickerViewDelegate>

@property (nonatomic , retain ) SummonerDataBaseManager * SDBM;//召唤师数据库管理对象

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UIImageView *downImageView;//下箭头图片

@property (nonatomic , retain ) UITextField *summonerTF;//召唤师名称输入框

@property (nonatomic , retain ) UITextField *serverTF;//服务器名称输入框

@property (nonatomic , retain ) UIImageView *serverTFImageView;//服务器输入框三角图片

@property (nonatomic , retain ) ServerNameInputPickerView *sniPickerView;//服务器名称输入选择器视图

@property (nonatomic , retain ) UIButton *confirmButton;//确认按钮

@property (nonatomic , retain) LoadingView *loadingView;//加载视图

@property (nonatomic , retain ) SummonerView *summonerView;//召唤师视图

@property (nonatomic , retain) AFHTTPRequestOperationManager *manager;//AFNetWorking

@end

@implementation AddSummonerView

-(void)dealloc{
    
   
    
    [super dealloc];
    
}

//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = MAINCOLOER;
        
        //初始化控件
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:28];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.text = @"添加召唤师";
        
        [self addSubview:_titleLabel];
        
        //下箭头图片
        
        _downImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"iconfont-xiajiantou"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        _downImageView.backgroundColor = [UIColor clearColor];
        
        _downImageView.tintColor = [UIColor whiteColor];
        
        [self addSubview:_downImageView];
        
        //服务器名称选择器输入视图
        
        _sniPickerView = [[ServerNameInputPickerView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 252)];
        
        _sniPickerView.delegate = self;
        
        //召唤师输入框
        
        _summonerTF = [[UITextField alloc]init];
        
        _summonerTF.backgroundColor = [UIColor whiteColor];
        
        _summonerTF.borderStyle = UITextBorderStyleRoundedRect;
        
        _summonerTF.textAlignment = NSTextAlignmentCenter;
        
        _summonerTF.placeholder = @"召唤师名字";
        
        [self addSubview:_summonerTF];
        
        //服务器输入框

        
        _serverTF = [[UITextField alloc]init];
        
        _serverTF.borderStyle = UITextBorderStyleRoundedRect;
        
        _serverTF.textAlignment = NSTextAlignmentCenter;
        
        _serverTF.inputView = _sniPickerView;
        
        _serverTF.text = @"艾欧尼亚 电信一";
        
        [self addSubview:_serverTF];
        
        //服务器输入框三角图片
        
        _serverTFImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"iconfont-youxia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        _serverTFImageView.tintColor = MAINCOLOER;
        
        _serverTFImageView.backgroundColor = [UIColor clearColor];
        
        [_serverTF addSubview:_serverTFImageView];
        
        
        //确认按钮
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _confirmButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        
        [_confirmButton setTitle:@"添 加" forState:UIControlStateNormal];
        
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _confirmButton.layer.cornerRadius = 0;
        
        _confirmButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
        
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_confirmButton];
        
        
        //初始化召唤师视图
        
        _summonerView = [[SummonerView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _summonerView.customColor = [UIColor whiteColor];
        
        _summonerView.backgroundColor = [UIColor clearColor];
        
        _summonerView.hidden = YES;//默认隐藏
        
        _summonerView.alpha = 0.0f;
        
        [self addSubview:_summonerView];

        
    }
    return self;
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置frame
    
    _titleLabel.frame = CGRectMake(0, 20 , CGRectGetWidth(self.frame), 40);
    
    //设置召唤师视图
    
    _summonerView.frame = CGRectMake(0, 20 , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 20  );
    
    //判断视图高度 低于250 不显示下箭头按钮
    
    if (CGRectGetHeight(self.frame) >250) {
        
        _summonerTF.frame = CGRectMake(0, 0 , CGRectGetWidth(self.frame) - 20, 40);
        
        _summonerTF.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , (CGRectGetHeight(self.frame) - 40 - 60 ) /3 + 30 );
        
        _serverTF.frame = CGRectMake(0, 0 , CGRectGetWidth(self.frame) - 20, 40);
        
        _serverTF.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , (CGRectGetHeight(self.frame) - 40 - 60 ) /3 * 2 + 30 );
        
        _serverTFImageView.frame = CGRectMake(CGRectGetWidth(_serverTF.frame) - 15, 40 - 15 , 10, 10);
        
        _downImageView.frame = CGRectMake(0, 0, 64, 40);
        
        _downImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , (CGRectGetHeight(self.frame) - 40 - 60 ) /3 * 3 + 20);

        
    } else {
        
        _summonerTF.frame = CGRectMake(0, 0 , CGRectGetWidth(self.frame) - 20, 40);
        
        _summonerTF.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , (CGRectGetHeight(self.frame) - 40 - 60 ) /2 + 30 );
        
        _serverTF.frame = CGRectMake(0, 0 , CGRectGetWidth(self.frame) - 20, 40);
        
        _serverTF.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , (CGRectGetHeight(self.frame) - 40 - 60 ) /2 * 2 + 30 );
        
        _serverTFImageView.frame = CGRectMake(CGRectGetWidth(_serverTF.frame) - 15, 40 - 15 , 10, 10);
        
        _downImageView.frame = CGRectMake(0, 0, 0, 0);


    }
    
    
    _confirmButton.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 40, CGRectGetWidth(self.frame)  , 40);
}

//确认按钮响应事件

- (void)confirmButtonAction:(UIButton *)sender{
    
    //隐藏控件
    
    [self hiddenControl];
    
    //请求数据
    
    __block typeof (self) Self = self;
    
    //取消之前的请求
    
    [self.manager.operationQueue cancelAllOperations];
    
    //执行新的请求操作

    
    //处理服务器名称参数
    
    NSString *serverName = [[self.serverTF.text componentsSeparatedByString:@" "] objectAtIndex:1];
    
    NSString *url = [[NSString stringWithFormat:kUnion_MyUion_AddSummonerURL , serverName , self.summonerTF.text] URLEncodedString];
    
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *tempData = responseObject;
        
        if (![tempData isEqualToData:[NSData data]]) {
            
            
            [Self JSONAnalyticalWithData:tempData];
            
            
        } else {
            
            //显示控件
            
            [Self showControl];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        //显示控件
        
        [Self showControl];
        
    }];
    
}



#pragma mark ---解析数据

- (void)JSONAnalyticalWithData:(NSData *)data{
    
    if (data != nil) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *itemDic = [dic valueForKey:self.summonerTF.text];
        
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
        
        
        //查询数据库是否存在召唤师 如果不存在 设置该召唤师为默认召唤师
        
        if ([self.SDBM selectSummoner] == nil || [self.SDBM selectSummoner].count == 0) {
            
            //持久化存储召唤师名称 服务器名称
            
            [self saveSummonerData:SM.summonerName ServerName:SM.serverName];
            
        }
        
        //查询数据库判断是否已经存在
        
        if (![self.SDBM selectSummonerWithSummonerName:SM.summonerName ServerName:SM.serverName]) {
            
            //存储到数据库
            
            [self.SDBM insertSummoner:SM];
            
        }
        
        //显示召唤师视图并添加数据
        
        [self showSummonerView:SM];
        
        //发送通知
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddSuccess" object:self userInfo:nil];
        
        
    }
    

}

//持久化存储召唤师数据 (召唤师名称 服务器名称)

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



#pragma mark ---隐藏控件

- (void)hiddenControl{
    
    __block typeof(self) Self = self;
    
    //隐藏控件
    
    [UIView animateWithDuration:0.5f animations:^{
        
        _titleLabel.alpha = 0.0f;
        
        _downImageView.alpha = 0.0f;
        
        _summonerTF.alpha = 0.0f;
        
        _serverTF.alpha = 0.0f;
        
        _serverTFImageView.alpha = 0.0f;
        
        _confirmButton.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        //显示加载视图
        
        Self.loadingView.hidden = NO;
        
    }];
    
}

#pragma mark ---显示控件

- (void)showControl{
    
    __block typeof(self) Self = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //显示控件
        
        [UIView animateWithDuration:0.5f animations:^{
            
            _titleLabel.alpha = 1.0f;
            
            _downImageView.alpha = 1.0f;
            
            _summonerTF.alpha = 1.0f;
            
            _serverTF.alpha = 1.0f;
            
            _serverTFImageView.alpha = 1.0f;
            
            _confirmButton.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        [UIView addLXNotifierWithText:@"召唤师不存在 请注意大小写标点符号" dismissAutomatically:YES];
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
    });
    
    
    
}

#pragma mark ---显示召唤师视图并添加数据

- (void)showSummonerView:(SummonerModel *)SM{
    
    __block typeof(self) Self = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //隐藏加载视图
        
        Self.loadingView.hidden = YES;
        
        [UIView animateWithDuration:1.0f animations:^{
            
            _summonerView.SM = SM;
            
            _summonerView.hidden = NO;
            
            _summonerView.alpha = 1.0f;
            
            _titleLabel.text = @"添加成功";
            
            _titleLabel.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            
            
            
        }];
        
    });
 
}



#pragma mark ---ServerNameInputPickerViewDelegate

-(void)selectedPickerValue:(NSString *)value{
    
    self.serverTF.text = value;
    
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

-(LoadingView *)loadingView{
    
    if (_loadingView == nil) {
        
        //初始化加载视图
        
        _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        
        _loadingView.loadingColor = [UIColor whiteColor];
        
        _loadingView.hidden = YES;//默认隐藏
        
        [self addSubview:_loadingView];
        
    }
    
    return _loadingView;
}

-(AFHTTPRequestOperationManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [[AFHTTPRequestOperationManager manager] retain];
        
        // 设置超时时间
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer.timeoutInterval = 15.0f;
        
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    
    return _manager;
    
}


@end
