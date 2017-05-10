//
//  HotViewController.m
//  presents
//
//  Created by dapeng on 16/1/6.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "HotViewController.h"

@interface HotViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0  blue:228 / 255.0 alpha:1.0];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.mutableArray = [NSMutableArray arrayWithCapacity:0];
    self.string =@"http://api.liwushuo.com/v2/items?limit=20&offset=%ld&gender=1&generation=1";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"热门礼品";
    self.navigationController.navigationBar.translucent = NO;
    [self getData];
    [self.view addSubview:self.collectionView];
    [self createSearchButton];
    [self addHeader];
    [self addFooter];
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
    [self night];
    [self.collectionView reloadData];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 获取网络请求

- (void)getData {
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [SAPNetWorkTool getWithUrl:[NSString stringWithFormat:self.string, (long) self.page] parameter:nil httpHeader:nil responseType:ResponseTypeJSON success:^(id result) {
        
        NSArray *array = [result[@"data"] objectForKey:@"items"];
        
        for (NSDictionary *dic in array) {
            NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:dic[@"data"][@"image_urls"]];
            
            self.hotModel = [[HotModel alloc] initWithDictionary:dic[@"data"]];
            [self.dataSource addObject:self.hotModel];
            [self.mutableArray addObject:mutableArr];
        }
        _HUD.hidden = YES;
        [self.collectionView reloadData];
        
    } fail:^(NSError *error) {
        
    }];
}


#pragma mark - collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.itemSize = CGSizeMake((self.view.width - 20) / 2, 250);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 69 - 44) collectionViewLayout:flowLayout];
        [self.collectionView registerClass:[NZCHotCollectionViewCell class] forCellWithReuseIdentifier:@"NZCHotCollectionViewCell"];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark - CollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NZCHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NZCHotCollectionViewCell" forIndexPath:indexPath];
    
    
    cell.hotModel = self.dataSource[indexPath.item];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource.count) {
        return self.dataSource.count;
    }
    return 0;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NZCHotDetialViewController *hotDetial = [[NZCHotDetialViewController alloc] init];
    HotModel *hotModel = self.dataSource[indexPath.row];
    
    if (self.mutableArray.count) {
        hotDetial.model = self.dataSource[indexPath.item];
        hotDetial.dataArray = self.dataSource[indexPath.item];
        hotDetial.array = self.mutableArray[indexPath.item];
        hotDetial.urlString = hotModel.url;
    }
    
    [self.navigationController pushViewController:hotDetial animated:YES];
    
}


#pragma mark - 刷新加载
- (void)addHeader {
    [self.collectionView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getData];
            
            [self.collectionView headerEndRefreshing];
            
            
        });
    }];
}

- (void)addFooter {
    __weak typeof(self) block = self;
    [self.collectionView addFooterWithCallback:^{
        block.page += 20;
        [block getData];
        [block.collectionView footerEndRefreshing];
        
        
    }];
    
    
}
#pragma mark ------------searchButton-------------------
- (void)createSearchButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"searchButtonIcon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
- (void)searchButtonAction:(UIBarButtonItem *)right {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
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
