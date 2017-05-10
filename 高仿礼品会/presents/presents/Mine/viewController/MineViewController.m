//
//  MineViewController.m
//  presents
//
//  Created by dapeng on 16/1/6.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISwitch *switchButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    

    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.title = @"我的";

    self.view.backgroundColor = [UIColor whiteColor];

    
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    self.imageView.frame = CGRectMake(0, -5, self.view.width, 200);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imageView];
    self.tableView.backgroundColor = [UIColor clearColor];

    self.switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.width - 60, 10, 40, 20)];
    [self night];

}
- (void)night {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"nightMode"];
    
    if (!(passWord == nil) && [passWord isEqualToString:@"day"]){
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.311 green:0.765 blue:0.756 alpha:1.000];
    }else{
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [ user objectForKey:@"nightMode"];
    if (!(passWord == nil) && [passWord isEqualToString:@"night"]){
        [_switchButton setOn:NO];

    }
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    //    if (y < 0) {
    CGRect frame = self.imageView.frame;
    //        frame.origin.y = y;
    frame.size.height =  -y;
    self.imageView.frame = frame;
    //    }
    
}

#pragma mark --- tableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.backgroundColor = [UIColor clearColor];
    

    if (indexPath.row == 0) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"清除缓存";
    } else if (indexPath.row == 2){
        cell.textLabel.text = @"礼物闹钟";
    }else {
        cell.textLabel.text = @"切换主题";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [ user objectForKey:@"nightMode"];
        if (!(passWord == nil) && [passWord isEqualToString:@"night"]){
            [_switchButton setOn:NO];
        }else{
            [_switchButton setOn:YES];
            _switchButton.onTintColor = RGB(4.0,80.0,85.0,0.9f);
            _switchButton.thumbTintColor = RGB(4.0,43.0,85.0,1.0f);
        }
        
        [_switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        self.switchButton.thumbTintColor = [UIColor colorWithWhite:0.929 alpha:1.000];//按钮颜色
        self.switchButton.onTintColor = [UIColor colorWithWhite:0.617 alpha:1.000];//开后的颜色
        self.switchButton.tintColor = [UIColor colorWithWhite:0.876 alpha:1.000];//线颜色
        self.switchButton.layer.borderColor = [UIColor colorWithWhite:0.747 alpha:1.000].CGColor;
        [cell.contentView addSubview:_switchButton];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark ---tableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        NZCMineCollectViewController *collect = [[NZCMineCollectViewController alloc] init];
        
        [self.navigationController pushViewController:collect animated:YES];
        
        
    } else if (indexPath.row == 1) {
        
        // 找到缓存路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //        [SANetWorkingTask folderSizeAtPath:cachesPath];
        //
        //        [SANetWorkingTask fileSizeAtPath:cachesPath];
        //
        //        [SANetWorkingTask clearCache:cachesPath];
        
        
        
        
        NSInteger size = [[SDImageCache sharedImageCache] getSize];
        
        float totalSize = size / 1024.0 / 1024.0;

        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"清除了%.2fMb", totalSize] preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            
            
            [[SDImageCache sharedImageCache] clearDisk];
            
            //清除内存缓存
            [[[SDWebImageManager sharedManager] imageCache] clearMemory];
            
            //清除系统缓存
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            

            NSFileManager *manager = [NSFileManager defaultManager];
            NSError *error = nil;
            // 当前路径下缓存文件夹删除
            [manager removeItemAtPath:cachesPath error:&error];
            
            
        }];
        
        [alter addAction:action];
        
        [self presentViewController:alter animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 2){
        
        AlarmClockViewController *alarmClockVC = [[AlarmClockViewController alloc] init];
        [self.navigationController pushViewController:alarmClockVC animated:NO];
        self.navigationController.navigationBarHidden = NO;

        
    }
    
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)switchAction:(id)sender{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"nightMode"];
    if ([passWord isEqualToString:@"night"]){
        NSString *passWord = @"day";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:passWord forKey:@"nightMode"];
        
    }else{
        NSString *passWord = @"night";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:passWord forKey:@"nightMode"];
    }
    
    
    
    [self.tableView reloadData];
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

@end
