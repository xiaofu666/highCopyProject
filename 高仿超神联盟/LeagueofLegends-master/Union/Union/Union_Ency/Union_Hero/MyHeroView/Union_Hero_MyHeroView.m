//
//  Union_Hero_MyHeroView.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Hero_MyHeroView.h"

#import "MyHeroTableView.h"


@interface Union_Hero_MyHeroView ()

@property (nonatomic , copy ) NSString *summonerName;//用户名称(召唤师名称)

@property (nonatomic , copy ) NSString *serverName;//服务器名称(召唤师区名称)

@property (nonatomic , retain ) UIImageView *promptImageView;//提示图片

@property (nonatomic , retain ) MyHeroTableView *myHeroTableView;//我的英雄表视图

@end

@implementation Union_Hero_MyHeroView

- (void)dealloc{
    
    [_summonerName release];
    
    [_serverName release];
    
    [_promptImageView release];
    
    [_myHeroTableView release];
    
    //移除通知
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    [super dealloc];
}

//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //添加通知
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSuccess:) name:@"AddSuccess" object:nil];
        
    }
    
    return self;
    
}

//添加成功通知

- (void)AddSuccess:(NSNotificationCenter *)no{
    
    //重新调用加载数据
    
    [self showMyHeroView];
    
    
}

#pragma mark ---显示我的英雄视图

- (void)showMyHeroView{
    
    //--获取当前召唤师名称 服务器名称
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *summnonerStr = [defaults stringForKey:@"SummonerName"];
    
    NSString *serverNameStr = [defaults stringForKey:@"ServerName"];
    
    //非空判断
    
    if (summnonerStr == nil && serverNameStr == nil) {
            
            //当前召唤师名称与服务器名不存在 提示添加召唤师
            
            //提示图片非空判断 如果为空 初始化 如果不为空 显示
            
            if (_promptImageView == nil) {
                
                //初始化提示图片 添加点击手势
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(promptImageViewAction:)];
                
                _promptImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"myheropromptImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
                
                _promptImageView.frame = CGRectMake(0, 0, 150, 150);
                
                _promptImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2 , CGRectGetHeight(self.frame) / 2 - 50);
                
                [_promptImageView addGestureRecognizer:tap];
                
                _promptImageView.tintColor = [UIColor lightGrayColor];
                
                _promptImageView.userInteractionEnabled = YES;
                
                [self addSubview:_promptImageView];
                
                
            } else {
                
                //显示提示图片
                
                _promptImageView.hidden = NO;
                
            }
        
        //隐藏表视图
        
        self.myHeroTableView.hidden = YES;
        
    } else {
        
        //显示表视图
        
        self.myHeroTableView.hidden = NO;
        
        //隐藏提示图片
        
        _promptImageView.hidden = YES;
        
        //非空判断
        
        if (_summonerName == nil && _serverName == nil) {
            
            //赋值操作
            
            _summonerName = summnonerStr;
            
            _serverName = serverNameStr;
            
            //不为空 创建我的英雄表视图
            
            self.myHeroTableView.serverName = _serverName;
            
            self.myHeroTableView.summonerName = _summonerName;
            
            //加载数据
            
            [self.myHeroTableView loadData];

            
        }
        
        if (![summnonerStr isEqualToString:_summonerName] || ![serverNameStr isEqualToString:_serverName] ) {
            
            //赋值操作
            
            _summonerName = summnonerStr;
            
            _serverName = serverNameStr;
            
            //不为空 创建我的英雄表视图
            
            self.myHeroTableView.serverName = _serverName;
            
            self.myHeroTableView.summonerName = _summonerName;
            
            //加载数据
            
            [self.myHeroTableView loadData];
 
        }

    }
    
}

#pragma mark ---提示图片点击事件

- (void)promptImageViewAction:(UITapGestureRecognizer *)tap{
    
    //调用跳转添加召唤师视图控制器block
    
    self.addSummonerBlock();

}






#pragma mark ---LazyLoading

-(MyHeroTableView *)myHeroTableView{
    
    if (_myHeroTableView == nil) {
        
        _myHeroTableView = [[MyHeroTableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStyleGrouped];
        
        //英雄详情页面block回调
        
        __block Union_Hero_MyHeroView *Self = self;
        
        _myHeroTableView.heroDetailBlock = ^(NSString *heroName){
            
            //调用英雄详情Block 传入英雄英文名.
            
            Self.heroDetailBlock(heroName);
            
        };
        
        [self addSubview:_myHeroTableView];
        
    }
    
    return _myHeroTableView;
    
}









@end
