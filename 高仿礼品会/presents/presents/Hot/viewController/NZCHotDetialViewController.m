//
//  NZCHotDetialViewController.m
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "NZCHotDetialViewController.h"
#import "UMSocial.h"
@interface NZCHotDetialViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *backGround;
@property (nonatomic, strong) UIView *back;

@end

@implementation NZCHotDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.flag = NO;
    
    self.string = self.model.ids;
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    self.tabBarController.tabBar.hidden =YES;
    self.navigationController.hidesBarsOnSwipe = NO;
    self.navigationItem.title = @"商品详情";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBut)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareICon"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
    
    [self creatBuyButton];
}

// 添加返回按钮
- (void)backBut {
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加分享按钮
- (void)shareAction:(UIBarButtonItem *)share {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"569ce6ff67e58e0159000cf7"
                                      shareText:self.urlString
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
                                       delegate:nil];
}

// 设置Tabbar显隐性
-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.hidden = NO;
}
//tableview懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.tableView registerClass:[NZCHotCarouselTableViewCell class] forCellReuseIdentifier:@"NZCHotCarouselTableViewCellIdentifier"];
        [self.tableView registerClass:[NZCHotDetialTableViewCell class] forCellReuseIdentifier:@"NZCHotDetialTableViewCellIdentifier"];
        _tableView.bounces = NO;
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

// KeyValueStore懒加载
- (SAKeyValueStore *)store {
    if (!_store) {
        self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
        NSString *tableName = @"my_item";
        [self.store createTableWithName:tableName];
    }
    return _store;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NZCHotCarouselTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NZCHotCarouselTableViewCellIdentifier"];
        cell.hotModel = self.model;
        cell.array = self.array;
        return cell;
    } else {
        NZCHotDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NZCHotDetialTableViewCellIdentifier"];
    
        cell.urlString = self.urlString;
        
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 商品信息cell
    if (indexPath.section == 0) {
        
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        //    通过字典计算高度和宽度
        CGRect rect = [self.model.descriptions boundingRectWithSize:CGSizeMake(self.view.width - 30, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        return 380 + rect.size.height;
    }else {
        // 图文展示cell
        return self.view.height - 35 + 50;
    }
}

#pragma mark - 创建动画
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y >= 150.00) {
//        self.backGround.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationRepeatAutoreverses:NO];
            [UIView setAnimationRepeatCount:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDelay:0];
            self.backGround.frame = CGRectMake(-1, self.view.height - 50, self.view.width + 2, 51);
        }];
    }
    if (scrollView.contentOffset.y <= 100.00) {
//        self.backGround.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationRepeatAutoreverses:NO];
            [UIView setAnimationRepeatCount:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDelay:0];
            self.backGround.frame = CGRectMake(-1, self.view.height, self.view.width + 2, 51);
        }];
    }
}

#pragma mark - 创建弹出动画
- (void)creatBuyButton {
    // 两个按钮的白色背景
    self.backGround = [[UIView alloc] initWithFrame:CGRectMake(-1, self.view.height - 44 , self.view.width + 2, 41)];
    _backGround.backgroundColor = [UIColor whiteColor];
    self.backGround.layer.borderWidth = 1;
    self.backGround.layer.borderColor = [[UIColor redColor] CGColor];
    
    [self.view addSubview:_backGround];
    
    // 喜欢按钮
    UIButton *like = [UIButton buttonWithType:UIButtonTypeCustom];
    like.frame = CGRectMake(30, 10, 100, 30);
    like.layer.cornerRadius = 15;
    like.clipsToBounds = YES;
    like.layer.borderWidth = 1;
    like.layer.borderColor = [[UIColor redColor] CGColor];
    [like setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [like setTitle:@"  喜欢" forState:UIControlStateNormal];
    
    NSArray *array = [self.store getObjectById:self.model.name fromTable:@"my_item"];
//    NSLog(@".....................%@", array);
//    NSArray *arr = [self.store getAllItemsFromTable:@"my_item"];
//    NSLog(@".....................%@", [arr lastObject]);
//    NSLog(@" %@", [[arr lastObject] itemId]);
//    NSLog(@"/////////*********%@", [[arr lastObject] itemObject][@"pic"]);
    if (array) {
//        NSLog(@"数组有值");
        [like setImage:[UIImage imageNamed:@"redLike"] forState:UIControlStateNormal];
    } else {
//        NSLog(@"数组无值");
        [like setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    
    like.backgroundColor = [UIColor whiteColor];
    [like addTarget:self action:@selector(likeButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [_backGround addSubview:like];
    
    // 购买按钮
    UIButton *Buy = [UIButton buttonWithType:UIButtonTypeCustom];
    Buy.frame = CGRectMake(like.right + 60, 10, 100, 30);
    Buy.layer.cornerRadius = 15;
    Buy.clipsToBounds = YES;
    [Buy setTitle:@"马上就去买" forState:UIControlStateNormal];
    Buy.backgroundColor = [UIColor redColor];
    [Buy addTarget:self action:@selector(BuyButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [_backGround addSubview:Buy];
}
#pragma mark - 购买按钮的点击事件
- (void)BuyButtonDidPress:(UIButton *)sender {
    NSLog(@"buy");
    
    NSLog(@"商品链接地址为 : %@", self.model.purchase_url);
    
    NSString *urlString = self.model.purchase_url;
    
    NSURL *url;
    
//    if([urlString rangeOfString:@"detail.tmall."].location != NSNotFound)   //判断Url是否是天猫商品的链接
//    {
        NSRange range = [urlString rangeOfString:@"id="]; //在URL中找到商品的ID
        if(range.location != NSNotFound) {
            
            NSString *productID = [urlString substringWithRange:NSMakeRange(range.location + 3, 11)];
            NSString *appUrl = [NSString stringWithFormat:@"tmall://tmallclient/?{\"action\":\"item:id=%@\"}", productID];
            url = [NSURL URLWithString:[appUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                
                // 如果已经安装天猫客户端，就使用客户端打开链接
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        else {
            
            //客户手机上没有装天猫客户端，这时启动浏览器以网页的方式浏览该商品。
            url = [NSURL URLWithString:self.model.purchase_url];
            [[UIApplication sharedApplication] openURL:url];
        }
//    }
    
    
}

#pragma mark - 喜欢按钮的点击事件

// 添加收藏
- (void)likeButtonDidPress:(UIButton *)sender {
    NSLog(@"like");
    NSDictionary *like = @{@"cover_image_url": self.model.cover_image_url, @"name": self.model.name, @"price": self.model.price, @"favorites_count": self.model.favorites_count, @"purchase_url": self.model.purchase_url, @"image_urls": self.model.image_urls, @"url": self.model.url, @"descriptions": self.model.descriptions};
    
    // 判断红心颜色状态来决定是否增删于数据库
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"redLike"]]) {

        [sender setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        
        [self.store deleteObjectById:self.model.name fromTable:@"my_item"];
        
        
    } else {
        [sender setImage:[UIImage imageNamed:@"redLike"] forState:UIControlStateNormal];
        [self.store putObject:like withId:self.model.name intoTable:@"my_item"];
    }
    [self.store close];
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



#pragma mark - 内存泄露
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
