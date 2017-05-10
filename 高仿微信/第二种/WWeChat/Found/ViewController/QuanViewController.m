//
//  QuanViewController.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "QuanViewController.h"
#import "UserInfoManager.h"
#import "UIImageView+WebCache.h"


#import "QuanCell.h"
@interface QuanViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView * tableView;


@property(nonatomic,strong)NSMutableArray * dataArr;

//刷新控件
@property(nonatomic,strong)UIImageView * refreshView;

/** 是否刷新 */
@property(nonatomic,assign)BOOL isRefrsh;

/** 是否在旋转 */
@property(nonatomic,assign)BOOL isRevolve;

@end

@implementation QuanViewController

{
   // NSInteger _num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    self.view.backgroundColor = [UIColor colorWithRed:34/255.0 green:37/255.0 blue:38/255.0 alpha:1];
    
    [self preData];
}

- (void)preData
{
  //  _num = 0;
    _isRevolve = NO;
    _isRefrsh = NO;
    _dataArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 100; i++)
    {
        [_dataArr addObject:@""];
    }
    
    [self createTableView];
}

- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        tableView.backgroundColor = [UIColor colorWithRed:34/255.0 green:37/255.0 blue:38/255.0 alpha:1];
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuanCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QuanCell"];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"QuanCell" owner:self options:nil][0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WGiveHeight(300);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, WGiveHeight(300))];
    //背景部分
    UIImageView * realView = [[UIImageView alloc]initWithFrame:CGRectMake(0, - WGiveHeight(64), self.view.frame.size.width, WGiveHeight(330))];
    realView.image = [UIImage imageNamed:@"Quan"];
    [view addSubview:realView];
    
    //头像部分
    {
    UIView * avaterBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(WGiveWidth(236), WGiveHeight(270), WGiveHeight(75), WGiveHeight(75))];
    avaterBackGroundView.backgroundColor = [UIColor whiteColor];
    avaterBackGroundView.layer.borderColor = [UIColor grayColor].CGColor;
    avaterBackGroundView.layer.borderWidth = 0.5;
    [realView addSubview:avaterBackGroundView];
    
    UIImageView * avaterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(2), WGiveWidth(2), WGiveHeight(75) - WGiveWidth(4), WGiveHeight(75) - WGiveWidth(4))];
        
    [avaterImgView setImageWithURL:[NSURL URLWithString:[[UserInfoManager manager]avaterUrl]] placeholderImage:[[UserInfoManager manager] avater] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
        
    [avaterBackGroundView addSubview:avaterImgView];
    }
    
    //名字部分
    {
        UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, WGiveHeight(285), WGiveWidth(218), WGiveHeight(44))];
        userNameLabel.text = [[UserInfoManager manager]userName];
        userNameLabel.font = [UIFont boldSystemFontOfSize:17];
        userNameLabel.textColor = [UIColor whiteColor];
        userNameLabel.textAlignment = NSTextAlignmentRight;
        [realView addSubview:userNameLabel];
    }
    
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

#pragma mark -- scrollview --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isRefrsh == NO)
    {
        CGFloat tran =  scrollView.contentOffset.y;
        NSLog(@"%f",tran);
        CGRect frame = self.refreshView.frame;
        CGFloat nowY = 64 - WGiveHeight(28) - tran;
        if (nowY > 64 + WGiveHeight(16))
        {
            nowY = 64 + WGiveHeight(16);
        }
        frame.origin.y = nowY;
        self.refreshView.frame = frame;
        
        
        if (_isRevolve == NO)
        {
            [UIView animateWithDuration:1 animations:^{
                _isRevolve = YES;
                self.refreshView.layer.transform = CATransform3DRotate(self.refreshView.layer.transform, M_PI, 0, 0, 1);
            }completion:^(BOOL finished) {
                _isRevolve = NO;
            }];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     _isRefrsh = YES;
    
    [self startRefresh];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
        [UIView animateWithDuration:0.5 animations:^{
            self.refreshView.frame = CGRectMake(WGiveWidth(20),64 - WGiveHeight(28), WGiveHeight(28), WGiveHeight(28));
        } completion:^(BOOL finished) {
            _isRefrsh = NO;
        }];

    });
    
}

- (UIImageView *)refreshView
{
    if (!_refreshView)
    {
        _refreshView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(20),64 - WGiveHeight(28), WGiveHeight(28), WGiveHeight(28))];
        _refreshView.image = [UIImage imageNamed:@"found_quan"];
        [self.view addSubview:_refreshView];
    }
    return _refreshView;
}

- (void)startRefresh
{
    [UIView animateWithDuration:1 animations:^{
        self.refreshView.layer.transform = CATransform3DRotate(self.refreshView.layer.transform, M_PI, 0, 0, 1);
    }];
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
