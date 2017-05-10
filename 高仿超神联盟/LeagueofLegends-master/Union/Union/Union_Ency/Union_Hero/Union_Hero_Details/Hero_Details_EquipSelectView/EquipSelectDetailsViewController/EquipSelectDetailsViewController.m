//
//  EquipSelectDetailsViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/12.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipSelectDetailsViewController.h"

#import "EquipSelectDetailsItemView.h"

#import "EquipDetailsViewController.h"

@interface EquipSelectDetailsViewController ()

@property (nonatomic , retain ) UIView *headerView;//顶部视图

@property (nonatomic , retain ) UIScrollView *scrollView;//滑动视图

@property (nonatomic , retain ) UIImageView  *picImageView;//英雄头像视图

@property (nonatomic , retain ) UIButton *backButton;//返回按钮

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , retain ) UILabel *authorLabel;//作者

@property (nonatomic , retain ) UILabel *serverLabel;//服务器

@property (nonatomic , retain ) UILabel *goodAndBadLabel;//赞 不赞

@property (nonatomic , retain ) UILabel *combatLabel;//战斗力


@property (nonatomic , retain ) EquipSelectDetailsItemView *preItemView;//前期出装视图

@property (nonatomic , retain ) EquipSelectDetailsItemView *midItemView;//中期出装视图

@property (nonatomic , retain ) EquipSelectDetailsItemView *endItemView;//后期出装视图

@property (nonatomic , retain ) EquipSelectDetailsItemView *nfItemView;//逆风出装视图


@property (nonatomic , retain ) EquipDetailsViewController *equipDetailsVC;//装备详情视图控制器


@property (nonatomic , assign ) BOOL isDismiss;//是否退出 (YES为已退出 NO为未退出)


@property (nonatomic , retain ) UIDynamicAnimator *theAnimator;

@end

@implementation EquipSelectDetailsViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //设置默认值
        
        _isDismiss = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0];
    
    //加载顶部视图
    
    [self loadHeaderView];
    
    //加载返回按钮
    
    [self loadBackButton];
    
    //加载滑动视图
    
    [self loadScrollView];
    
    //加载出装Item视图
    
    [self loadItemView];
    
}

#pragma mark ---加载返回按钮

- (void)loadBackButton{
    
    //初始化返回按钮
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backButton.backgroundColor = [UIColor clearColor];
    
    _backButton.tintColor = [UIColor whiteColor];
    
    [_backButton setImage:[[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    _backButton.frame = CGRectMake(0, 20, 80, 44);
    
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_backButton];
    
}

- (void)backButtonAction:(UIButton *)sender{
    
    __block typeof(self) Self = self;
    
    //结束动画
    
    [self endAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [Self dismissViewControllerAnimated:NO completion:^{
            
            _isDismiss = YES;
            
        }];
    
    });
    
}

#pragma mark ---加载顶部视图

-(void)loadHeaderView{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 - 128 , CGRectGetWidth(self.view.frame), 128)];
    
    _headerView.backgroundColor = MAINCOLOER;
    
    [self.view addSubview:_headerView];
    
    //初始化标题
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60 , 20 , CGRectGetWidth(self.view.frame) - 120 , 44)];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.textColor = [UIColor whiteColor];
    
    _titleLabel.autoresizesSubviews = YES;
    
    [_headerView addSubview:_titleLabel];
    
    //初始化作者
    
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, ( CGRectGetWidth(_headerView.frame) - 80 ) / 2 , 20)];
    
    _authorLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    
    _authorLabel.font = [UIFont systemFontOfSize:14];
    
    _authorLabel.textAlignment = NSTextAlignmentLeft;
    
    [_headerView addSubview:_authorLabel];
    
    //初始化服务器
    
    _serverLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 95, ( CGRectGetWidth(_headerView.frame) - 80 ) / 2 , 20)];
    
    _serverLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    
    _serverLabel.font = [UIFont systemFontOfSize:14];
    
    _serverLabel.textAlignment = NSTextAlignmentLeft;
    
    [_headerView addSubview:_serverLabel];
    
    //赞和不赞
    
    _goodAndBadLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_headerView.frame) / 2 + 40 , 65, ( CGRectGetWidth(_headerView.frame) - 80 ) / 2 - 10 , 20)];
    
    _goodAndBadLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    
    _goodAndBadLabel.font = [UIFont systemFontOfSize:14];
    
    _goodAndBadLabel.textAlignment = NSTextAlignmentRight;
    
    [_headerView addSubview:_goodAndBadLabel];
    
    
    //初始化战斗力
    
    _combatLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_headerView.frame) / 2 + 40 , 95, ( CGRectGetWidth(_headerView.frame) - 80 ) / 2 - 10 , 20)];
    
    _combatLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    
    _combatLabel.font = [UIFont systemFontOfSize:14];
    
    _combatLabel.textAlignment = NSTextAlignmentRight;
    
    [_headerView addSubview:_combatLabel];
    
    
    
    //初始化英雄头像
    
    _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 - 80 , 80, 80)];
    
    _picImageView.clipsToBounds = YES;
    
    _picImageView.layer.cornerRadius = 40;
    
    _preItemView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f].CGColor;
    
    _preItemView.layer.borderWidth = 2.0f;
    
    _picImageView.center = CGPointMake(CGRectGetWidth(_headerView.frame) / 2 , _picImageView.center.y);
    
    [self.view addSubview:_picImageView];
    
    
    
}


#pragma mark ---加载滑动视图

-(void)loadScrollView{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , 128 , CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame) - 128 )];
    
    _scrollView.backgroundColor = [UIColor clearColor];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) , 840);
    
    [self.view addSubview:_scrollView];
    
    [self.view sendSubviewToBack:_scrollView];
    
}



#pragma mark ---加载出装Item视图

-(void)loadItemView{
    
    __block typeof(self) Self = self;
    
    //初始化前期出装视图
    
    _preItemView = [[EquipSelectDetailsItemView alloc]initWithFrame:CGRectMake(10 , 20 , CGRectGetWidth(_scrollView.frame) - 20 , 200) isSkill:YES];
    
    _preItemView.center = CGPointMake(0 - CGRectGetWidth(_scrollView.frame) , _preItemView.center.y);
    
    _preItemView.title = @"前期";
    
    //选中技能图标Block
    
    _preItemView.selectedSkillImageViewBlock = ^(Hero_Details_SkillModel *model){
        
        
    };
    
    //选中装备图标Block
    
    _preItemView.selectedEquipImageViewBlock = ^(NSInteger equipID){
        
        Self.equipDetailsVC.eid = equipID;
        
        [Self presentViewController:Self.equipDetailsVC animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_preItemView];
    

    //初始化中期出装视图
    
    _midItemView = [[EquipSelectDetailsItemView alloc]initWithFrame:CGRectMake(10 , 240 , CGRectGetWidth(_scrollView.frame) - 20 , 200) isSkill:YES];
    
    _midItemView.title = @"中期";
    
    _midItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) * 1.5  , _midItemView.center.y);
    
    //选中技能图标Block
    
    _midItemView.selectedSkillImageViewBlock = ^(Hero_Details_SkillModel *model){
        
        
    };
    
    //选中装备图标Block
    
    _midItemView.selectedEquipImageViewBlock = ^(NSInteger equipID){
        
        Self.equipDetailsVC.eid = equipID;
        
        [Self presentViewController:Self.equipDetailsVC animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_midItemView];

    
    //初始化后期出装视图
    
    _endItemView = [[EquipSelectDetailsItemView alloc]initWithFrame:CGRectMake(10 , 460 , CGRectGetWidth(_scrollView.frame) - 20 , 200) isSkill:YES];
    
    _endItemView.title = @"后期";
    
    _endItemView.center = CGPointMake( 0 - CGRectGetWidth(_scrollView.frame)  , _endItemView.center.y);
    
    //选中技能图标Block
    
    _endItemView.selectedSkillImageViewBlock = ^(Hero_Details_SkillModel *model){
        
        
    };
    
    //选中装备图标Block
    
    _endItemView.selectedEquipImageViewBlock = ^(NSInteger equipID){
        
        Self.equipDetailsVC.eid = equipID;
        
        [Self presentViewController:Self.equipDetailsVC animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_endItemView];
    
    
    
    //初始化逆风出装视图
    
    
    _nfItemView = [[EquipSelectDetailsItemView alloc]initWithFrame:CGRectMake(10 , 640 , CGRectGetWidth(_scrollView.frame) - 20 , 200) isSkill:NO];
    
    _nfItemView.title = @"逆风";
    
    _nfItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) * 1.5 , _nfItemView.center.y);
    
    //选中技能图标Block
    
    _nfItemView.selectedSkillImageViewBlock = ^(Hero_Details_SkillModel *model){
        
        
    };
    
    //选中装备图标Block
    
    _nfItemView.selectedEquipImageViewBlock = ^(NSInteger equipID){
        
        Self.equipDetailsVC.eid = equipID;
        
        [Self presentViewController:Self.equipDetailsVC animated:YES completion:^{
            
        }];
        
    };
    
    [_scrollView addSubview:_nfItemView];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---获取数据

-(void)setModel:(EquipSelectModel *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
        _scrollView.contentOffset = CGPointMake(0 , 0 );
        
    }
    
    //处理数据
    
    //添加标题
    
    _titleLabel.text = model.title;
    
    //添加作者
    
    _authorLabel.text = [NSString stringWithFormat:@"%@",model.author];
    
    //添加服务器
    
    _serverLabel.text = [NSString stringWithFormat:@"来自%@",model.server];
    
    //添加赞和不赞
    
    _goodAndBadLabel.text = [NSString stringWithFormat:@"赞:%@  菜:%@",model.good , model.bad];
    
    //添加战斗力
    
    _combatLabel.text = [NSString stringWithFormat:@"战斗力:%@",model.combat];
    
    //添加英雄头像
    
    //SDWebImage异步加载英雄头像
    
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnion_Ency_HeroImageURL , model.en_name]] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];

    
    
    //添加英雄英文名
    
    _preItemView.enHeroName = model.en_name;
    
    _midItemView.enHeroName = model.en_name;
    
    _endItemView.enHeroName = model.en_name;
    
    _nfItemView.enHeroName = model.en_name;
    
    //获取前期 中期 后期 技能数组
    
    NSArray *skillAllArray = [model.skill componentsSeparatedByString:@","];
    
    NSRange preRange = NSMakeRange(0, 6);
    
    NSRange midRange = NSMakeRange(6, 6);
    
    NSRange endRange = NSMakeRange(12, 6);
    
    NSArray *preSkillArray = [skillAllArray subarrayWithRange:preRange];
    
    NSArray *midSkillArray = [skillAllArray subarrayWithRange:midRange];
    
    NSArray *endSkillArray = [skillAllArray subarrayWithRange:endRange];
    
    //添加技能数组
    
    _preItemView.skillArray = preSkillArray;
    
    _midItemView.skillArray = midSkillArray;
    
    _endItemView.skillArray = endSkillArray;
    
    //添加装备数组
    
    _preItemView.equipArray = [model.pre_cz componentsSeparatedByString:@","];
    
    _midItemView.equipArray = [model.mid_cz componentsSeparatedByString:@","];
    
    _endItemView.equipArray = [model.end_cz componentsSeparatedByString:@","];
    
    _nfItemView.equipArray = [model.nf_cz componentsSeparatedByString:@","];
    
    //添加描述注释
    
    _preItemView.explainStr = model.pre_explain;
    
    _midItemView.explainStr = model.mid_explain;
    
    _endItemView.explainStr = model.end_explain;
    
    _nfItemView.explainStr = model.nf_explain;
    
    
    //添加数据完成 计算出装视图尺寸 并设置滑块视图
    
    _midItemView.frame = CGRectMake(_midItemView.frame.origin.x, _preItemView.frame.origin.y + CGRectGetHeight(_preItemView.frame) + 20 , CGRectGetWidth(_midItemView.frame) , CGRectGetHeight(_midItemView.frame));
    
    _endItemView.frame = CGRectMake(_endItemView.frame.origin.x, _midItemView.frame.origin.y + CGRectGetHeight(_midItemView.frame) + 20 , CGRectGetWidth(_endItemView.frame) , CGRectGetHeight(_endItemView.frame));
    
    _nfItemView.frame = CGRectMake(_nfItemView.frame.origin.x, _endItemView.frame.origin.y + CGRectGetHeight(_endItemView.frame) + 20 , CGRectGetWidth(_nfItemView.frame) , CGRectGetHeight(_nfItemView.frame));
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) , _nfItemView.frame.origin.y + CGRectGetHeight(_nfItemView.frame) + 20 );
    
    
}

-(void)setSkillDataArray:(NSMutableArray *)skillDataArray{
    
    if (_skillDataArray != skillDataArray) {
        
        [_skillDataArray release];
        
        _skillDataArray = [skillDataArray retain];
        
    }
    
    //添加数据
    
    _preItemView.skillDataArray = skillDataArray;
    
    _midItemView.skillDataArray = skillDataArray;

    _endItemView.skillDataArray = skillDataArray;
    
    _nfItemView.skillDataArray = skillDataArray;
    
}




#pragma mark ---LazyLoading

-(EquipDetailsViewController *)equipDetailsVC{
  
    if (_equipDetailsVC == nil) {
        
        _equipDetailsVC = [[EquipDetailsViewController alloc]init];
        
    }
    
    return _equipDetailsVC;
    
}






#pragma mark ---视图即将出现

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_isDismiss) {
        
        [self startAnimations];
        
        _isDismiss = NO;
        
    }
    
    
    
}

#pragma mark ---视图即将消失

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

#pragma mark ---开始动画

-(void)startAnimations{
    
    [UIView animateWithDuration:0.8f animations:^{
       
        //背景颜色动画
        
        self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
        
    }];
    
    //顶部视图动画
    
    [UIView animateWithDuration:0.1f animations:^{
        
        _headerView.frame = CGRectMake(_headerView.frame.origin.x , 0 , CGRectGetWidth(_headerView.frame), CGRectGetHeight(_headerView.frame));
        
        
    } completion:^(BOOL finished) {
        
        //弹出英雄头像
        
        [self viewGravityAnimation:_picImageView Point:CGPointMake(CGRectGetWidth(_headerView.frame)/ 2 , 104)];
        
        //出装视图动画
        
        [UIView animateWithDuration:0.25f animations:^{
            
            _preItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) / 2 , _preItemView.center.y);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.25f animations:^{
                
                _midItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) / 2 , _midItemView.center.y);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.2f animations:^{
                    
                    _endItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) / 2 , _endItemView.center.y);
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.1f animations:^{
                        
                        _nfItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) / 2 , _nfItemView.center.y);
                        
                    } completion:^(BOOL finished) {
                        
                        
                        
                    }];
                    
                }];
                
            }];
            
        }];
        
    }];
    
    
}


#pragma mark ---结束动画

-(void)endAnimations{
    
    [UIView animateWithDuration:0.8f animations:^{
        
        //背景颜色动画
        
        self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.0f];
        
    }];
    
    //顶部视图动画
    
    [UIView animateWithDuration:0.3f animations:^{
        
        _headerView.frame = CGRectMake(_headerView.frame.origin.x , 0 - 128 , CGRectGetWidth(_headerView.frame), CGRectGetHeight(_headerView.frame));
        
        [self viewGravityAnimation:_picImageView Point:CGPointMake(CGRectGetWidth(_headerView.frame)/ 2  , 0 - 104 )];
        
    } completion:^(BOOL finished) {
        
        //移除英雄头像
        
       //[self viewGravityAnimation:_picImageView Point:CGPointMake(160 , 0 - 104 )];
        
        
        
    }];
    
    
    
    //出装视图动画
    
    [UIView animateWithDuration:0.25f animations:^{
        
        _preItemView.center = CGPointMake( 0 - CGRectGetWidth(_scrollView.frame) , _preItemView.center.y);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25f animations:^{
            
            _midItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) * 1.5 , _midItemView.center.y);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f animations:^{
                
                _endItemView.center = CGPointMake( 0 - CGRectGetWidth(_scrollView.frame) , _endItemView.center.y);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.1f animations:^{
                    
                    _nfItemView.center = CGPointMake( CGRectGetWidth(_scrollView.frame) * 1.5 , _nfItemView.center.y);
                    
                } completion:^(BOOL finished) {
                    
                    
                    
                }];
                
            }];
            
        }];
        
    }];

    
    
}


#pragma mark ---重力动画

-(void)viewGravityAnimation:(UIView *)view Point:(CGPoint) point {
    
    _theAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[view]];
    
    [_theAnimator addBehavior:gravityBehaviour];
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:point];
    
    [attachmentBehavior setLength:0.0f];
    
    [attachmentBehavior setDamping:0.1f];
    
    [attachmentBehavior setFrequency:10];
    
    [_theAnimator addBehavior:attachmentBehavior];
    
}



#pragma mark ---当前viewcontroller支持哪些转屏方向

-(NSUInteger)supportedInterfaceOrientations{
    
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark ---设置电池条前景部分样式类型 (白色)

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}












@end
