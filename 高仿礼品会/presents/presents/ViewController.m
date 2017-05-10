//
//  ViewController.m
//  presents
//
//  Created by dapeng on 16/1/6.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, selecttionCollectionViewCellDelegate, presentCollectionViewCellDelegate, PullViewControllerDelegate>
@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, strong) UIScrollView       *scrollView;
@property (nonatomic, strong) NSArray            *scrollTitleArr;
@property (nonatomic, strong) NSMutableArray     *scrollIdArr;
@property (nonatomic, strong) NSMutableArray     *scrollButtonArr;
@property (nonatomic, strong) UIView             *pullView;
@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) UIButton           *pullButton;
@property (nonatomic, strong) PullViewController *pullVC;
@property (nonatomic, strong) NSMutableArray     *pullArr;
@property (nonatomic, copy  ) NSString           *channeltext;
@property (nonatomic, strong) UIButton           *titleButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;

    self.navigationItem.title = @"礼品会";
    
    [self createPullDownButton];
    [self createSearchButton];
    [self createCollectionView];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *result = [userDefaults valueForKey:@"userPassGuides"];
    if ([result isEqualToString:@"test"]) {

        [self getData];
    }
    
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

#pragma mark ---------------数据请求-----------------------
- (void)getData {

    [self.scrollView removeAllSubviews];
    self.pullArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.scrollButtonArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.scrollIdArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    [store createTableWithName:@"guide"];
    for (SAKeyValueItem *item in [store getAllItemsFromTable:@"guide"]) {
        [self.pullArr addObject:[item.itemObject valueForKey:@"name"]];
        [self.scrollIdArr addObject:[item.itemObject valueForKey:@"id"]];
    }
    self.scrollTitleArr = [NSArray arrayWithArray:self.pullArr];
    [self createScrollView];
    [self.collectionView reloadData];

}
#pragma mark --------------collectionView----------------------
- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = CGFLOAT_MIN;
    layout.minimumInteritemSpacing = CGFLOAT_MIN;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.width, self.view.height - 113);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 113) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PresentCollectionViewCell class] forCellWithReuseIdentifier:@"PresentCollectionViewCell"];
    [self.collectionView registerClass:[SelectionCollectionViewCell class] forCellWithReuseIdentifier:@"SelectionCollectionViewCell"];
    [self.view addSubview:self.collectionView];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pullArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        SelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectionCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];

        cell.selectionDelegate = self;
        return cell;
    
    }else {
        PresentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PresentCollectionViewCell" forIndexPath:indexPath];
        cell.ids = self.scrollIdArr[indexPath.row];
        cell.PrsentDelegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }
}

#pragma mark ------------aboutScrollView&&button---------------------

- (void)createScrollView {
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width - 40, 40)];
        [self.view addSubview:self.scrollView];
    }
    if (!self.pullVC) {
        self.pullVC = [[PullViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 30)];
        self.pullVC.pullDelegate = self;
        [self.view addSubview:self.pullVC];
        self.pullVC.hidden = YES;
    }
    self.scrollView.contentSize = CGSizeMake((SCREEN_SIZE.width - 40) / 5 * self.scrollTitleArr.count, 0);
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;

    for (int i = 0; i < self.scrollTitleArr.count; i++) {
        self.titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.titleButton addTarget:self action:@selector(scrollButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.titleButton.frame = CGRectMake((SCREEN_SIZE.width - 40) / 5 * i, 0, (SCREEN_SIZE.width - 40) / 5, 40);
        self.titleButton.tag = i + 100;
        [self.titleButton setTitle:self.pullArr[i] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        if (i == 0) {
            [self.titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
        }
        [self.scrollView addSubview:self.titleButton];
        [self.scrollButtonArr addObject:self.titleButton];
    }
    
}

- (void)scrollButtonAction:(UIButton *)sender {
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    for (int i = 0; i < self.scrollButtonArr.count; i++) {
        UIButton *button = self.scrollButtonArr[i];
        if (sender.tag != button.tag) {
            [self.scrollButtonArr[i] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    
    
    [self.collectionView setContentOffset:CGPointMake((sender.tag - 100) * self.view.width, 0)];
    [self.collectionView reloadData];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
 
    int temp = self.collectionView.contentOffset.x / SCREEN_SIZE.width;
    UIButton *button = self.scrollButtonArr[temp];
    
    if (temp  > 4) {
        self.scrollView.contentOffset = CGPointMake((temp - 4)* (SCREEN_SIZE.width - 40) / 5, 0);
    }
    else {
        self.scrollView.contentOffset= CGPointMake( 0, 0);
    }
    [self scrollButtonAction:button];
}

#pragma mark -------------------pullbutton--------------------------
- (void)createPullDownButton {
    self.pullButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pullButton.frame = CGRectMake(SCREEN_SIZE.width - 35, 0, 30, 30);
    [self.pullButton setImage:[UIImage imageNamed:@"pull_down"] forState:UIControlStateNormal];
    [self.pullButton setImage:[UIImage imageNamed:@"shangsanjiao"] forState:UIControlStateSelected];
    [self.pullButton addTarget:self action:@selector(toPullViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pullButton];
}
static bool isClick = YES;
- (void)toPullViewController:(UIButton *)pull {
    self.pullButton.selected = !self.pullButton.selected;
    if (isClick == YES) {
        isClick = NO;
        self.pullVC.hidden = NO;
        self.collectionView.hidden = YES;
        self.scrollView.hidden = YES;
        self.pullButton.hidden = NO;
        [self.view bringSubviewToFront:self.pullVC];
        [self.view bringSubviewToFront:self.pullButton];
        self.tabBarController.tabBar.hidden = YES;
    }else {
        isClick = YES;
        self.pullVC.hidden = YES;
        self.collectionView.hidden = NO;
        self.pullButton.hidden = NO;
        self.scrollView.hidden = NO;
        self.tabBarController.tabBar.hidden = NO;
      
        [self getData];
        
        [self.collectionView reloadData];

    }
    
}
#pragma mark -------------------searchButton-------------------------
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

#pragma mark -----------delegate方法---------------------

- (void)toPDetailVCDelegate:(NSString *)pageurl withImageUrl:(NSString *)imageUrl withTitle:(NSString *)title {
    PDetailViewController *detailVC = [[PDetailViewController alloc] init];
    detailVC.url = pageurl;
    detailVC.cover_image_url = imageUrl;
    detailVC.titles = title;

    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)toCarsouselNextVC:(NSString *)ids withUrl:(NSString *)url withNavTitle:(NSString *)title {
    if (ids == nil) {
        NoneIdViewController *noneIdVC = [[NoneIdViewController alloc] init];
        noneIdVC.imageUrl = url;
//        noneIdVC.navti = title;
        [self.navigationController pushViewController:noneIdVC animated:YES];
    }
    else if (url == nil) {
        CarsousekNextViewController *carsouselNextVC = [[CarsousekNextViewController alloc] init];
        carsouselNextVC.ids = ids;
        carsouselNextVC.NavTitle = title;
        [self.navigationController pushViewController:carsouselNextVC animated:YES];
    }
}


- (void)switchChannels:(NSString *)channesText {
    isClick = YES;
    self.collectionView.hidden = NO;
    self.scrollView.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;

    self.pullVC.hidden = YES;
    self.channeltext = channesText;
    for (int i = 0; i < self.scrollTitleArr.count; i++) {
        if ([self.scrollTitleArr[i] isEqualToString:channesText]) {
            self.collectionView.contentOffset = CGPointMake(self.view.width * i, 0);
            if (i  > 4) {
                self.scrollView.contentOffset = CGPointMake((i - 4)* (SCREEN_SIZE.width - 40) / 5, 0);
                
            }else {
                self.scrollView.contentOffset= CGPointMake( 0, 0);
            }
            
            UIButton *button = self.scrollButtonArr[i];
            
            [self scrollButtonAction:button];
        }
    }
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *result = [userDefaults valueForKey:@"userPassGuides"];
    if (![result isEqualToString:@"test"]) {
        [userDefaults setObject:@"test" forKey:@"userPassGuides"];
        SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
        [store createTableWithName:@"guide"];
        
        
        [SAPNetWorkTool getWithUrl:scrollButtonTitle parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
            NSDictionary *dic = [result valueForKey:@"data"];
            NSArray *arr = dic[@"channels"];
            for (NSDictionary *dic in arr) {
                [store putObject:dic withId:dic[@"name"] intoTable:@"guide"];
            }
            [self getData];
         
            
            
        } fail:^(NSError *error) {
            NSLog(@"%@", error);
        }];
        
    }
    [super viewWillAppear:animated];
    self.pullVC.hidden = YES;
    [self night];
    [self.collectionView reloadData];

    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
