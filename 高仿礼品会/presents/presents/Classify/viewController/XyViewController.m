//
//  XyViewController.m
//  presents
//
//  Created by Xy on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyViewController.h"

@interface XyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate>
@property (nonatomic, strong) HotModel *hotModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation XyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0  blue:228 / 255.0 alpha:1.0];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.mutableArray = [NSMutableArray arrayWithCapacity:0];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = self.titles;
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.collectionView];
    [self getData];
    [self createSearchButton];
    [self addHeader];
    [self addFooter];
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

#pragma mark - 获取网络请求
- (void)getData {
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [SAPNetWorkTool getWithUrl:[NSString stringWithFormat:@"http://api.liwushuo.com/v2/item_subcategories/%@/items?limit=20&offset=%ld", self.newsId, self.page] parameter:nil httpHeader:nil responseType:ResponseTypeJSON success:^(id result) {
        
        NSArray *array = [result[@"data"] objectForKey:@"items"];
        if (array.count == 0) {
            return;
        }
        for (NSDictionary *dic in array) {
            NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:dic[@"image_urls"]];
            
            self.hotModel = [[HotModel alloc] initWithDictionary:dic];
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
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 69) collectionViewLayout:flowLayout];
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
    cell.backgroundColor = [UIColor whiteColor];
    cell.hotModel = self.dataSource[indexPath.item];
    //    NSLog(@"1111111111111%@", self.dataSource[indexPath.item]);
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
        hotDetial.array = self.mutableArray[indexPath.item];
        hotDetial.urlString = hotModel.url;
    }
    
    [self.navigationController pushViewController:hotDetial animated:YES];
    
}


#pragma mark - 刷新加载
- (void)addHeader {
    __weak typeof(self) block = self;
    [self.collectionView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [block getData];
            [block.collectionView headerEndRefreshing];
        });
    }];
}

- (void)addFooter {
    [self.collectionView addFooterWithCallback:^{
        self.page += 20;
        [self getData];
        [self.collectionView footerEndRefreshing];   
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


@end
