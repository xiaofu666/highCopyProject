//
//  SearchViewController.m
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SearchViewController.h"
@interface SearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, searchTableViewCellDelegate, SearchCollectionViewCellDelegate, SearchPresentCollectionViewCellDelegate>
@property (nonatomic, strong) UISearchBar      *searchBar;
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *titleArr;
@property (nonatomic, strong) searchModel      *searchmodel;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton         *presentButton;
@property (nonatomic, strong) UIButton         *guidesButton;
@property (nonatomic, strong) HotModel         *hotModel;
@property (nonatomic, strong) NSMutableArray   *presentArr;

@property (nonatomic, strong) UILabel          *titles;
@property (nonatomic, strong) UIView           *backView;
@property (nonatomic, strong) UIButton         *selectArtifaButton;
@property (nonatomic, strong) UILabel          *searchLabel;
@property (nonatomic, strong) NSArray          *arrays;
@property (nonatomic, strong) PresentMdoel     *presentModel;
@property (nonatomic, strong) NSMutableArray   *guidesArr;
@property (nonatomic, strong) NSMutableArray   *buttonArr;
@property (nonatomic, strong) NSMutableArray   *imageArr;
@property (nonatomic, copy)   NSString         *next_url;
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.924 alpha:1.000];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButton:)];
    self.navigationController.navigationBar.translucent = NO;

    [self.navigationItem setHidesBackButton:TRUE animated:NO];//去掉系统默认back按钮

    [self createTwoButton];
    [self createSearchBar];
    [self getTitleData];
    [self addheader];

}

- (void)tapAction {
    [self.searchBar resignFirstResponder];

}

- (void)rightBarButton:(UIBarButtonItem *)right {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------------------searchBar----------------
- (void)createSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
    self.searchBar.backgroundColor = [UIColor redColor];
    self.searchBar.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = self.searchBar;

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchBar.text = searchText;
    if (searchText.length == 0) {
        self.tableView.hidden = NO;
        self.collectionView.hidden = YES;
        self.presentButton.hidden = YES;
        self.guidesButton.hidden = YES;
        [self.view bringSubviewToFront:self.tableView];
    } else {
        self.tableView.hidden = YES;
        self.collectionView.hidden = NO;
        self.guidesButton.hidden = NO;
        self.presentButton.hidden = NO;
        [self getPresentDataWithGuidesData];


    }
}


#pragma mark ------------------tableView----------------------
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellIndentifier"];
    [self.tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:@"SearchTableViewCell"];
    [self.view addSubview:self.tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellIndentifier"];
    if (indexPath.section == 0) {
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
        cell.titleArr = self.titleArr;
        cell.searchDelegate = self;
        return cell;
    }else {
        cell.textLabel.text = @"使用选礼神器快速挑选礼物";
        cell.imageView.image = [UIImage imageNamed:@"dingweiIcon"];
        cell.textColor = [UIColor colorWithWhite:0.206 alpha:1.000];
    return cell;
    
    }return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 130;
    }else {
        return 40;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  
    if (section == 0) {
        return 30;
    }else {
        return CGFLOAT_MIN;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return @"大家都在搜";
    }return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        SelectArtifactViewController *selectArtifactVC = [[SelectArtifactViewController alloc] init];
    [self.navigationController pushViewController:selectArtifactVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}


#pragma mark --------------数据请求-------------------

- (void)getTitleData {
    self.titleArr = [[NSMutableArray alloc] initWithCapacity:0];

    [SAPNetWorkTool getWithUrl:@"http://api.liwushuo.com/v2/search/hot_words" parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = [result[@"data"] objectForKey:@"hot_words"];
        for (NSString *str in array) {
            
            self.searchmodel = [[searchModel alloc] init];
            _searchmodel.hot_words = str;
            [self.titleArr addObject:_searchmodel];
            self.searchBar.placeholder = result[@"data"][@"placeholder"];

        }

        [self createTableView];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getPresentDataWithGuidesData {
//    presentData
    self.imageArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.presentArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *string = [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/item?keyword=%@&limit=20&offset=0&sort=", string];
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [SAPNetWorkTool getWithUrl:url parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = result[@"data"][@"items"];
        self.next_url = result[@"data"][@"paging"][@"next_url"];
        for (NSDictionary *dic in array) {
            self.hotModel = [[HotModel alloc] initWithDictionary:dic];
            [self.presentArr addObject:self.hotModel];
            [self.imageArr addObject:dic[@"cover_image_url"]];
        }
        [self createCollectionView];

    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    self.guidesArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *searchStr = [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
NSString *guidesUrl = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/post?keyword=%@&offset=0&sort=", searchStr];
    [SAPNetWorkTool getWithUrl:guidesUrl parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = [result[@"data"] objectForKey:@"posts"];
        for (NSDictionary *dic in array) {
            self.presentModel = [[PresentMdoel alloc] initWithDictionary:dic];
            [self.guidesArr addObject:self.presentModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    _HUD.hidden = YES;
}

#pragma mark --------------collectionView------------------

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = CGFLOAT_MIN;
    layout.minimumInteritemSpacing = CGFLOAT_MIN;
    layout.itemSize = CGSizeMake(SCREEN_SIZE.width, SCREEN_SIZE.height - 153);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 89) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.849 alpha:1.000];
    [self.collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"SearchCollectionViewCell"];
    [self.collectionView registerClass:[SearchPresentCollectionViewCell class] forCellWithReuseIdentifier:@"SearchPresentCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        SearchPresentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchPresentCollectionViewCell" forIndexPath:indexPath];
        cell.searchPDelegate = self;
        cell.presentArr = self.presentArr;
        cell.next_url = self.next_url;
        return cell;
    }else {
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
        cell.guidesArr = self.guidesArr;
        cell.searchDelegate = self;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    }
}
#pragma mark ---------------------切换按钮-----------------------


- (void)createTwoButton {
    self.buttonArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.presentButton.frame = CGRectMake(0, 0, self.view.width / 2, 40);
    [self.presentButton setTitle:@"礼物" forState:UIControlStateNormal];
    [self.presentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.presentButton.tag = 100;
    self.presentButton.backgroundColor = [UIColor whiteColor];

    [self.presentButton addTarget:self action:@selector(twoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.presentButton.layer.borderWidth = 1;
    self.presentButton.layer.borderColor = [UIColor colorWithWhite:0.712 alpha:1.000].CGColor;
    self.presentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.presentButton];
    
    self.guidesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.guidesButton.frame = CGRectMake(self.view.width / 2, 0, self.view.width / 2, 40);
    [self.guidesButton setTitle:@"攻略" forState:UIControlStateNormal];
    [self.guidesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.guidesButton.tag = 101;
    self.guidesButton.backgroundColor = [UIColor whiteColor];
    [self.guidesButton addTarget:self action:@selector(twoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.guidesButton.layer.borderWidth = 1;
    self.guidesButton.layer.borderColor = [UIColor colorWithWhite:0.712 alpha:1.000].CGColor;
    self.guidesButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.guidesButton];
    [self.buttonArr addObject:self.presentButton];
    [self.buttonArr addObject:self.guidesButton];
    
   
}
- (void)twoButtonAction:(UIButton *)sender {
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    for (int i = 0; i < self.buttonArr.count; i++) {
        UIButton *button = self.buttonArr[i];
        if (sender.tag != button.tag) {
            [self.buttonArr[i] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    
    [self.collectionView setContentOffset:CGPointMake((sender.tag - 100) * self.view.frame.size.width, 0)];
    [self.collectionView reloadData];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int temp = self.collectionView.contentOffset.x / SCREEN_SIZE.width;
    UIButton *button = self.buttonArr[temp];
    [self twoButtonAction:button];
}

#pragma mark ----------------delegate方法-------------------

- (void)passTitle:(NSString *)title {
    self.searchBar.text = title;
    self.guidesButton.hidden = NO;
    self.presentButton.hidden = NO;
    self.tableView.hidden = YES;
    [self getPresentDataWithGuidesData];
}

- (void)toPDetailDelegate:(NSString *)pageurl withImageUrl:(NSString *)imageUrl withTitle:(NSString *)title {
    NSString *str = [NSString stringWithFormat:@"http://www.liwushuo.com/posts/%@/content", pageurl];
    
    PDetailViewController *detailVC = [[PDetailViewController alloc] init];
    
    detailVC.url = str;
    detailVC.cover_image_url = imageUrl;
    detailVC.titles = title;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)passArray:(NSArray *)arr withModel:(HotModel *)model withString:(NSString *)url {
    NZCHotDetialViewController *detailVC = [[NZCHotDetialViewController alloc] init];
    detailVC.model = model;
    detailVC.urlString = url;
    detailVC.array = arr;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark ------------加载刷新------------------------
-(void)addheader {
    __weak typeof(self) block = self;
    
    [self.collectionView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [block getPresentDataWithGuidesData];
            [block.collectionView reloadData];
            [block.collectionView headerEndRefreshing];
            
        });
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
