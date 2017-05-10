//
//  Union_Hero_ViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/13.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Hero_ViewController.h"

#import "TabView.h"

#import "Union_Hero_FreeHeroCollectionView.h"

#import "Union_Hero_MyHeroView.h"

#import "Union_Hero_AllHeroView.h"


#import "PresentingAnimator.h"

#import "DismissingAnimator.h"

#import "ModalViewController.h"

#import "AddSummonerView.h"

#import "Union_Hero_Details_ViewController.h"


@interface Union_Hero_ViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic , retain)TabView *tabView; //标签导航栏视图

@property (nonatomic , retain)Union_Hero_FreeHeroCollectionView *freeView; //免费英雄视图

@property (nonatomic , retain)Union_Hero_MyHeroView *myView; //我的英雄视图

@property (nonatomic , retain)Union_Hero_AllHeroView *allView; //全部英雄视图

@property (nonatomic , retain)Union_Hero_Details_ViewController *HDVC;//英雄详情视图控制器

@end

@implementation Union_Hero_ViewController

-(void)dealloc{
    
    [_tabView release];
    
    [_freeView release];
    
    [_myView release];
    
    [_allView release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"英雄";
    
    //添加标签导航栏视图
    
    [self.view addSubview:self.tabView];
    
    //标签导航栏视图回调block实现
    
    __block Union_Hero_ViewController *Self = self;
    
    self.tabView.returnIndex = ^(NSInteger selectIndex){
        
        //根据标签导航下标切换不同视图显示
        
        [Self switchViewBySelectIndex:selectIndex];
        
    };
    
    
    //添加视图
    
    [self.view addSubview:self.freeView];
    
    //添加视图
    
    [self.view addSubview:self.myView];
    
    //添加视图
    
    [self.view addSubview:self.allView];

    
    //默认显示免费英雄视图
    
    self.tabView.selectIndex = 0;
    
    [self.view bringSubviewToFront:self.freeView];
    
}

#pragma mark ---懒加载标签导航栏视图

-(TabView *)tabView{
    
    if (_tabView == nil) {
        
        NSArray * tabArray = @[@"免费英雄",@"我的英雄",@"全部英雄"];
        
        _tabView = [[TabView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        
        _tabView.dataArray = tabArray;
    }
    
    return _tabView;
    
}

#pragma mark ---根据标签导航下标切换不同视图显示

- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    
    __block Union_Hero_ViewController *Self = self;
    
    //判断选中的标签下标 执行相应的切换
    
    switch (selectIndex) {
        case 0:
            
            //免费英雄
            
            [self.view bringSubviewToFront:self.freeView];
            
            //英雄详情block回调
            
            self.freeView.heroDetailBlock = ^(NSString *heroName){
                
                //跳转英雄详情视图控制器
                
                [Self showHeroDetailWithHeroName:heroName];
                
            };
            
            break;
            
        case 1:
            
            //我的英雄
            
            [self.view bringSubviewToFront:self.myView];
            
            //调用显示我的英雄视图
            
            [self.myView showMyHeroView];
            
            self.myView.addSummonerBlock = ^(){
                
                //初始化添加召唤师视图 并弹出
                
                AddSummonerView *addSummonerView = [[AddSummonerView alloc]init];
                
                ModalViewController *modalViewController = [ModalViewController new];
                
                modalViewController.addView = addSummonerView;
                
                modalViewController.transitioningDelegate = Self;
                
                modalViewController.modalPresentationStyle = UIModalPresentationCustom;
                
                [Self.navigationController presentViewController:modalViewController
                                             animated:YES
                                           completion:NULL];
                
                [addSummonerView release];
                
            };
            
            //英雄详情block回调
            
            self.myView.heroDetailBlock = ^(NSString *heroName){
              
                //跳转英雄详情视图控制器
                
                [Self showHeroDetailWithHeroName:heroName];
                
            };
            
            break;
            
        case 2:
            
            //全部英雄
            
            [self.view bringSubviewToFront:self.allView];
            
            //英雄详情block回调
            
            self.allView.heroDetailBlock = ^(NSString *heroName){
                
                //跳转英雄详情视图控制器
                
                [Self showHeroDetailWithHeroName:heroName];
                
            };
            
            break;
            
        default:
            break;
    }
    
}



#pragma mark ---跳转英雄详情页面 <传入英雄英文名>

- (void)showHeroDetailWithHeroName:(NSString *)heroName{
    
    [self presentViewController:self.HDVC animated:NO completion:^{
        
        self.HDVC.enHeroName = heroName;
    
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //清空内存中的图片缓存
    
    [[SDImageCache sharedImageCache] clearMemory];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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




#pragma mark ---LazyLoading


-(Union_Hero_FreeHeroCollectionView *)freeView{
    
    if (_freeView == nil) {
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        
        //1.设置单元格的大小 ,itemSize
        
        flow.itemSize = CGSizeMake( ( CGRectGetWidth(self.view.frame) - 30 ) / 2 , 80);
        
        //2.设置最小左右间距,单元格之间
        
        flow.minimumInteritemSpacing = 5;
        
        //3.设置最小上下间距, 单元格之间
        
        flow.minimumLineSpacing = 10;
        
        //4.设置滑动方向 (UICollectionViewScrollDirectionVertical 纵向)
        
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //5.section中cell的边界范围
        
        flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _freeView = [[Union_Hero_FreeHeroCollectionView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 40 ) collectionViewLayout:flow];
        
        [flow release];
        
    }
    
    return _freeView;

}

-(Union_Hero_MyHeroView *)myView{
    
    if (_myView == nil) {
        
        _myView = [[Union_Hero_MyHeroView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 40)];
        
    }
    
    return _myView;

}

-(Union_Hero_AllHeroView *)allView{
    
    if (_allView == nil) {
        
        _allView = [[Union_Hero_AllHeroView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 40)];
        
    }
    
    return _allView;

}

-(Union_Hero_Details_ViewController *)HDVC{
    
    if (_HDVC == nil) {
        
        _HDVC = [[Union_Hero_Details_ViewController alloc]init];
        
    }
    
    return _HDVC;
    
}




@end
