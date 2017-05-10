//
//  SummonerListViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SummonerListViewController.h"

#import "SummonerListTableViewCell.h"

#import "SummonerDataBaseManager.h"

#import "SummonerView.h"

#import "AddSummonerView.h"

#import "ModalViewController.h"

#import "PresentingAnimator.h"

#import "DismissingAnimator.h"

#import "SummonerDetailsViewController.h"


@interface SummonerListViewController ()<UITableViewDataSource , UITableViewDelegate , UIViewControllerTransitioningDelegate>

@property (nonatomic , retain ) NSMutableArray *dataArray; //数据源数组

@property (nonatomic , retain ) UITableView *tableView;//表视图


@property (nonatomic , copy ) NSString *summonerName;//用户名称(召唤师名称)

@property (nonatomic , copy ) NSString *serverName;//服务器名称(召唤师区名称)

@property (nonatomic , retain ) SummonerDataBaseManager * SDBM;//召唤师数据库管理对象


@property (nonatomic , retain ) SummonerDetailsViewController *summonerDetailsVC;//召唤师详情视图控制器


@end

@implementation SummonerListViewController

-(void)dealloc{
    
    [_dataArray release];
    
    [_tableView release];
    
    [_summonerName release];
    
    [_serverName release];
    
    [_summonerDetailsVC release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"召唤师列表";
    
    //添加导航栏右按钮
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-gengduo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction:)];
    
    rightBarButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    //初始化表视图
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview: _tableView];
    
    //注册
    
    [_tableView registerClass:[SummonerListTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    //加载数据
    
    [self loadData];
    
}

//视图即将出现

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //加载数据
    
    [self loadData];

    //添加通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSuccess:) name:@"AddSuccess" object:nil];
    
}

//视图即将消失

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    //移除通知
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//添加成功通知

- (void)AddSuccess:(NSNotificationCenter *)no{
    
    //重新调用加载数据
    
    [self loadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated;

}

//从数据库中查询数据

- (void)loadData{
    
    //获取召唤师数据库管理对象
    
    _SDBM = [SummonerDataBaseManager shareSummonerDataBaseManager];
    
    //创建数据库对象
    
    [_SDBM createDB];
    
    //创建召唤师表
    
    [_SDBM createSummoner];
    
    //查询全部召唤师信息
    
    _dataArray = [_SDBM selectSummoner];
    
    
    //--获取当前召唤师名称 服务器名称
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    _summonerName = [defaults stringForKey:@"SummonerName"];
    
    _serverName = [defaults stringForKey:@"ServerName"];
    
    //判断数据源数组元素个数是否大于1 不大于1 不需要排序
    
    if (_dataArray.count >1) {
        
        //排序数据源数组 将默认召唤师排到第一位
        
        for (int i = 0 ; i < _dataArray.count  ; i++) {
                
                SummonerModel *tempSM = [_dataArray objectAtIndex:i];
                
                if ([tempSM.summonerName isEqualToString:_summonerName] && [tempSM.serverName isEqualToString:_serverName]) {
                    
                    if ([_dataArray objectAtIndex:0] != tempSM) {
                        
                        SummonerModel *temp = [_dataArray objectAtIndex:0];
                        
                        //替换一个第一个对象
                        
                        [_dataArray replaceObjectAtIndex:0 withObject:tempSM];
                        
                        //替换原位置对象
                        
                        [_dataArray replaceObjectAtIndex:i withObject:temp];
                        
                    }
                    
                    
                }
            
        }

        
    }
    
    
    //更新表视图
    
    [_tableView reloadData];
    
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
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SummonerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    SummonerModel *SM = [self.dataArray objectAtIndex:indexPath.row];
    
    //判断是否为默认召唤师
    
    if ([_summonerName isEqualToString:SM.summonerName] && [_serverName isEqualToString:SM.serverName]) {
        
        cell.isDefault = YES;
        
    } else {
        
        cell.isDefault = NO;
        
    }
    
    cell.summonerModel = SM;
    
    //更新视图block回调
    
    __block SummonerListViewController *Self = self;
    
    cell.reloadDataBlock = ^(){
      
        //加载数据
        
        [Self loadData];
        
    };
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SummonerModel *SM = [self.dataArray objectAtIndex:indexPath.row];
    
    //跳转召唤师详情
    
    self.summonerDetailsVC.summonerName = SM.summonerName;
    
    self.summonerDetailsVC.serverName = SM.serverName;
    
    [self.summonerDetailsVC loadWebView];
    
    self.summonerDetailsVC.hidesBottomBarWhenPushed = YES;//隐藏tabbar
    
    [self.navigationController pushViewController:self.summonerDetailsVC animated:YES];
    
}




#pragma mark ---rightBarButtonAction

- (void)rightBarButtonAction:(UIBarButtonItem *)sender{
    

    //弹出提示框
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前默认召唤师" message:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //创建召唤师视图
    
    SummonerView *SV = [[SummonerView alloc]initWithFrame:CGRectMake(0, 40, alertController.view.frame.size.width - 16, 255)];
    
    SV.SM = [self selectDefaultSummoner];//传入当前默认召唤师数据模型
    
    [alertController.view addSubview:SV];
    
    [SV release];
    
    __block typeof(self) Self = self;
    
    UIAlertAction *alerAddAction = [UIAlertAction actionWithTitle:@"添加召唤师" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
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
        
    }];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [alertController addAction:alerAddAction];
    
    [alertController addAction:alertAction];
    
    [Self presentViewController:alertController animated:YES completion:^{
        
    }];

    
}

//查询默认召唤师信息

- (SummonerModel *)selectDefaultSummoner{
    
    SummonerModel *SM = nil;
    
    //--获取当前召唤师名称 服务器名称
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    _summonerName = [defaults stringForKey:@"SummonerName"];
    
    _serverName = [defaults stringForKey:@"ServerName"];
    
    if (_summonerName != nil && _serverName != nil) {
        
        //查询数据库 获取召唤师信息
        
        SM = [self.SDBM selectSummonerWithSummonerName:_summonerName ServerName:_serverName];
        
        if (SM != nil) {
            
            return  SM;
        }
        
    }

    return nil;
}

#pragma mark -- UITableView---编辑:删除

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];

}

//询问是否编辑

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;

}

//确认编辑状态
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;

}

//设置进入编辑状态时，Cell不会缩进

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{

    return NO;

}

//修改编辑按钮文字

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @" 删除 ";
}

//编辑操作

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //删除操作
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
    
        SummonerModel *SM = [self.dataArray objectAtIndex:indexPath.row];
        
        //从数据库删除
        
        if ([self.SDBM deleteSummoner:SM.sID]) {
            
            //从数组中删除
            
            [self.dataArray removeObject:SM];
            
            //表视图操作
            
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            if (self.dataArray.count == 0) {
                
                //--清空当前召唤师名称 服务器名称
                
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                [defaults removeObjectForKey:@"SummonerName"];
                
                [defaults removeObjectForKey:@"ServerName"];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                
               NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                //如果删除的召唤师是默认召唤师 则将删除后数组中第一个设为默认召唤师
                
                if ([SM.summonerName isEqualToString:[defaults stringForKey:@"SummonerName"]] && [SM.serverName isEqualToString:[defaults stringForKey:@"ServerName"]]) {
                    
                    SummonerModel *tempSM = [self.dataArray objectAtIndex:0];
                    
                    [defaults setValue:tempSM.summonerName forKey:@"SummonerName"];
                    
                    [defaults setValue:tempSM.serverName forKey:@"ServerName"];

                }
                
                //更新表视图
                
                [tableView reloadData];
                
            }
            
        }
        
        
    }
    
}




#pragma mark ---LazyLoading

- (SummonerDetailsViewController *)summonerDetailsVC{
    
    if (_summonerDetailsVC == nil) {
        
        _summonerDetailsVC = [[SummonerDetailsViewController alloc]init];
        
    }
    
    return _summonerDetailsVC;
    
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
