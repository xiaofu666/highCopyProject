//
//  Union_MyUnionViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/6/30.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_MyUnionViewController.h"

#import "MyUnion_UserTableViewCell.h"

#import "MyUnion_TableViewCell.h"


#import "SummonerDetailsViewController.h"

#import "SummonerListViewController.h"

#import "SettingViewController.h"

#import "FAQViewController.h"

#import "FeedbackViewController.h"

#import "AboutViewController.h"




#import "AddSummonerView.h"

#import "ModalViewController.h"

#import "PresentingAnimator.h"

#import "DismissingAnimator.h"

#import <UMFeedback.h>


@interface Union_MyUnionViewController ()<UITableViewDataSource , UITableViewDelegate , UIViewControllerTransitioningDelegate>

@property (nonatomic , retain ) UITableView *tableView;

@property (nonatomic , retain ) SummonerDetailsViewController *summonerDetailsVC;//召唤师详情视图控制器

@property (nonatomic , retain ) SummonerListViewController *summonerListVC;//召唤师列表

@property (nonatomic , retain ) SettingViewController *settringVC;//设置视图控制器

@property (nonatomic , retain ) FAQViewController *FAQVC;//常见问题视图控制器

@property (nonatomic , retain ) FeedbackViewController *feedbackVC;//意见反馈视图控制器

@property (nonatomic , retain ) AboutViewController *aboutVC;//关于视图控制器


@end

@implementation Union_MyUnionViewController

- (void)dealloc{
    
    [_tableView release];
    
    [_summonerDetailsVC release];
    
    [_summonerListVC release];
    
    [_settringVC release];
    
    [_FAQVC release];
    
    [_feedbackVC release];
    
    [_aboutVC release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化表视图
    
    _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 113) style:UITableViewStyleGrouped];
    
    _tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MyUnion_TableViewCell class] forCellReuseIdentifier:@"cell"];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ---UITableViewDataSource , UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return 1;
            
            break;
            
        case 1:
            
            return 1;
            
            break;
            
        case 2:
            
            return 1;
            
            break;
            
        case 3:
            
            return 4;
            
            break;
            
        default:
            
            return 0;
            
            break;
            
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0.001f;
    
    } else {
        
        return 5;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 90;
        
    } else {
        
        return 48;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case 0:
        {
            //用户
            
            MyUnion_UserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
            
            if (userCell == nil) {
                
                userCell = [[MyUnion_UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
                
            }
            
            //加载数据
            
            [userCell loadData];
            
            return userCell;
            
        }
            break;
            
        case 1:
        {
            
            //召唤师列表
            
            MyUnion_TableViewCell *slistCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
            slistCell.titleStr = @"召唤师列表";
            
            slistCell.detailStr = @"";
            
            slistCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            slistCell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            return slistCell;
            
        }
            break;
            
        case 2:
        {
            
            //设置
            
            MyUnion_TableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
            settingCell.titleStr = @"设置";
            
            settingCell.detailStr = @"";
            
            settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            settingCell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            return settingCell;
            
        }
            break;
            
        case 3:
        {
            
             switch (indexPath.row) {
                 case 0:
                 {
                     
                     //意见反馈
                     
                     MyUnion_TableViewCell *questionCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                     
                     questionCell.titleStr = @"常见问题";
                     
                     questionCell.detailStr = @"";
                     
                     questionCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                     
                     questionCell.selectionStyle = UITableViewCellSelectionStyleGray;
                     
                     return questionCell;
                     
                 }
                     break;
                     
                case 1:
                {
                    
                    //意见反馈
                    
                    MyUnion_TableViewCell *feedbackCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    
                    feedbackCell.titleStr = @"意见反馈";
                    
                    feedbackCell.detailStr = @"";
                    
                    feedbackCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    feedbackCell.selectionStyle = UITableViewCellSelectionStyleGray;
                    
                    return feedbackCell;
                    
                }
                    break;
                     
                 case 2:
                 {
                     
                     //评分
                     
                     MyUnion_TableViewCell *scoreCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                     
                     scoreCell.titleStr = @"评分";
                     
                     scoreCell.detailStr = @"";
                     
                     scoreCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                     
                     scoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
                     
                     return scoreCell;
                     
                 }
                     break;
                    
                case 3:
                {
                    
                    //关于
                    
                    MyUnion_TableViewCell *aboutCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    
                    aboutCell.titleStr = @"关于";
                    
                    aboutCell.detailStr = @"V 1.0.0";
                    
                    aboutCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    aboutCell.selectionStyle = UITableViewCellSelectionStyleGray;
                    
                    return aboutCell;
                    
                }
                    break;
                    
                default:
                    
                    return nil;
                    
                    break;
            }
            
        }
            break;
            
            
            
        default:
            
            return nil;
            
            break;
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case 0:
        {
            //召唤师详情
            
            //--获取当前召唤师名称 服务器名称
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            NSString * summonerName = [defaults stringForKey:@"SummonerName"];
            
            NSString * serverName = [defaults stringForKey:@"ServerName"];
            
            if (summonerName != nil && serverName != nil) {
                
                //跳转召唤师详情
                
                self.summonerDetailsVC.summonerName = summonerName;
                
                self.summonerDetailsVC.serverName = serverName;
                
                [self.summonerDetailsVC loadWebView];
                
                self.summonerDetailsVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
                
                [self.navigationController pushViewController:self.summonerDetailsVC animated:YES];

                
            } else {
                
                //跳转添加召唤师
                
                //初始化添加召唤师视图 并弹出
                
                AddSummonerView *addSummonerView = [[AddSummonerView alloc]init];
                
                ModalViewController *modalViewController = [ModalViewController new];
                
                modalViewController.addView = addSummonerView;
                
                modalViewController.transitioningDelegate = self;
                
                modalViewController.modalPresentationStyle = UIModalPresentationCustom;
                
                [self.navigationController presentViewController:modalViewController
                                                        animated:YES
                                                      completion:NULL];
                
                [addSummonerView release];
                
            }

        }
            break;
            
        case 1:
        {
            
            //--获取当前召唤师名称 服务器名称
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            
            NSString *summonerStr = [defaults stringForKey:@"SummonerName"];
            
            NSString *serverNameStr = [defaults stringForKey:@"ServerName"];
            
            if (summonerStr != nil && serverNameStr != nil) {
                
                //召唤师列表
                
                self.summonerListVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
                
                [self.navigationController pushViewController:self.summonerListVC animated:YES];
                
            } else {
                
                //弹出提示框
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您还没有添加召唤师\n 戳一下上面马上添加" preferredStyle:UIAlertControllerStyleAlert];
            
                
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                }];
                
                [alertController addAction:alertAction];
                
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];

            }
            
        }
            break;
            
        case 2:
        {
            
            //设置
            
            self.settringVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
            
            [self.navigationController pushViewController:self.settringVC animated:YES];
            
            
        }
            break;
            
        case 3:
        {
            
            switch (indexPath.row) {
                    
                case 0:
                {
                    
                    //常见问题
                    
                    self.FAQVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
                    
                    [self.navigationController pushViewController:self.FAQVC animated:YES];
                    
                }
                    break;
                    
                case 1:
                {
                    
                    //意见反馈
                    
                    self.feedbackVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
                    
                    [self.navigationController pushViewController:self.feedbackVC animated:YES];
                    
//                    [self presentViewController:[UMFeedback feedbackModalViewController] animated:YES completion:^{
//                        
//                    }];
                    
                }
                    break;
                    
                case 2:
                {
                    
                    //评分
                    
                    NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=xxxxxx" ];
                   
                    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
                    
                        str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/idxxxxxxx"];
                    
                    }
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                    
                }
                    break;
                    
                case 3:
                {
                 
                    //关于
                    
                    self.aboutVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
                    
                    [self.navigationController pushViewController:self.aboutVC animated:YES];
                    
                }
                    break;
                
                default:
                    
                    break;
            }
            
            
        }
            break;
            
            
        default:
            
            
            break;
    }
    


    
    
}



#pragma mark ---视图出现时

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //视图出现时 刷新表视图
    
    [self.tableView reloadData];
    
}



#pragma mark ---LazyLoading

- (SummonerDetailsViewController *)summonerDetailsVC{
    
    if (_summonerDetailsVC == nil) {
        
        _summonerDetailsVC = [[SummonerDetailsViewController alloc]init];
        
    }
    
    return _summonerDetailsVC;
    
}

- (SummonerListViewController *)summonerListVC {
    
    if (_summonerListVC == nil) {
        
        _summonerListVC = [[SummonerListViewController alloc]init];
        
    }
    
    return  _summonerListVC;
    
}

-(FAQViewController *)FAQVC{
    
    if (_FAQVC == nil) {
        
        _FAQVC = [[FAQViewController alloc]init];
        
    }
    
    return _FAQVC;
    
}

-(SettingViewController *)settringVC{
    
    if (_settringVC == nil) {
        
        _settringVC = [[SettingViewController alloc]init];
        
    }
    
    return _settringVC;

}

-(FeedbackViewController *)feedbackVC{
    
    if (_feedbackVC == nil) {
        
        _feedbackVC = [[FeedbackViewController alloc]init];
        
    }
    
    return _feedbackVC;
    
}

- (AboutViewController *)aboutVC {

    if (_aboutVC == nil) {
        
        _aboutVC = [[AboutViewController alloc]init];
        
    }
    
    return _aboutVC;
    
}





#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    
    return [PresentingAnimator new];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
    return [DismissingAnimator new];
    
}



@end
