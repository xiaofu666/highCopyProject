//
//  NZCMineCollectViewController.m
//  presents
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "NZCMineCollectViewController.h"


@interface NZCMineCollectViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, GuidesCollectionViewCellDelegate, collectionDelegate>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIButton *post;
@property (nonatomic, strong) UIButton *items;
@property (nonatomic, strong) PresentMdoel *presentModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) SAKeyValueStore *store;
@property (nonatomic, strong) NZCCollectModel *collectModel;

@end

@implementation NZCMineCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
    self.navigationItem.title = @"我的收藏";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete"] style:UIBarButtonItemStylePlain target:self action:@selector(rightDeleteDidPress)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.redView = [[UIView alloc] initWithFrame:CGRectZero];
    self.redView.backgroundColor = [UIColor redColor];
    
    [self creatButton];
}

- (void)rightDeleteDidPress {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"您是否要清空所有收藏" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            
            [self.store clearTable:@"my_item"];
            
            [self.dataSource removeAllObjects];
            [self.collectionView reloadData];
            break;
        default:
            break;
    }
    
}


- (void)getStoreDate {
    self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    
    NSArray *array = [[NSArray alloc] initWithArray:[self.store getAllItemsFromTable:@"my_item"]];
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (SAKeyValueItem *item in array) {
        NSLog(@"%@", item.itemObject);
        self.collectModel = [[NZCCollectModel alloc] initWithDictionary:item.itemObject];
        [self.dataSource addObject:item];
    }
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getStoreDate];
    [self.collectionView reloadData];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}


- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = CGFLOAT_MIN;
    flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
    flowLayout.itemSize = CGSizeMake(self.view.width, self.view.height - 40 - 64);
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 40 - 64) collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.collectionView registerClass:[NZCCollectItemsCollectionViewCell class] forCellWithReuseIdentifier:@"NZCCollectItemsCollectionViewCell"];
    
    [self.collectionView registerClass:[GuidesCollectionCollectionViewCell class] forCellWithReuseIdentifier:@"GuidesCollectionCollectionViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;

    [self.view addSubview:_collectionView];
    
}




#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.item == 0) {
        NZCCollectItemsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NZCCollectItemsCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1];
        cell.delegate = self;
        cell.dataSource = self.dataSource;
        return cell;
    } else {
        GuidesCollectionCollectionViewCell *guidesCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuidesCollectionCollectionViewCell" forIndexPath:indexPath];
        guidesCell.guidesDelegate = self;
        guidesCell.backgroundColor = [UIColor greenColor];
        return guidesCell;
    }
    return nil;
}

#pragma mark - 两个按钮
- (void)creatButton {
    
    self.items = [UIButton buttonWithType:UIButtonTypeCustom];
    _items.frame = CGRectMake(-1, -1, self.view.width / 2 + 1, 41);
    [_items setTitle:@"我收藏的礼物" forState:UIControlStateNormal];
    [_items setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _items.backgroundColor = [UIColor whiteColor];
    _items.layer.borderWidth = 1;
    _items.layer.borderColor = [[UIColor redColor] CGColor];
    [_items addTarget:self action:@selector(itemsDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_items];
    
    self.redView.frame = CGRectMake(0, _items.bottom - 4, _items.width, 4);
    [_items addSubview:_redView];
    
    self.post = [UIButton buttonWithType:UIButtonTypeCustom];
    _post.frame = CGRectMake(self.view.width / 2 - 1, -1, self.view.width / 2 + 2, 41);
    [_post setTitle:@"我收藏的攻略" forState:UIControlStateNormal];
    [_post setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _post.backgroundColor = [UIColor whiteColor];
    _post.layer.borderColor = [[UIColor redColor] CGColor];
    _post.layer.borderWidth = 1;

    [_post addTarget:self action:@selector(postDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_post];
    [self createCollectionView];

}


#pragma mark - 按钮点击事件
- (void)itemsDidPress:(UIButton *)sender {
    self.redView.frame = CGRectMake(0, sender.bottom - 4, sender.width, 4);
    [sender addSubview:_redView];
    self.collectionView.contentOffset = CGPointMake(0, 0);
}

- (void)postDidPress:(UIButton *)sender {
    self.redView.frame = CGRectMake(0, sender.bottom - 4, sender.width, 4);
    [sender addSubview:_redView];
    self.collectionView.contentOffset = CGPointMake(self.view.width, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        self.redView.frame = CGRectMake(0, _items.bottom - 4, _items.width, 4);
        [_items addSubview:_redView];

    }else {
        self.redView.frame = CGRectMake(0, _post.bottom - 4, _post.width, 4);
        [_post addSubview:_redView];

    }
}




- (void)passValueWithUrl:(NSString *)url withItem:(NSDictionary *)item withArray:(NSArray *)array {
    NZCHotDetialViewController *hotDetail = [[NZCHotDetialViewController alloc] init];
    hotDetail.model = [[HotModel alloc] initWithDictionary:item];
    hotDetail.urlString = url;
    hotDetail.array = array;
    [self.navigationController pushViewController:hotDetail animated:YES];
}




- (void)toPDetailVCDelegate:(NSString *)pageurl withImageUrl:(NSString *)imageUrl withTitle:(NSString *)title {
    PDetailViewController *pdVC = [[PDetailViewController alloc] init];
    pdVC.url = pageurl;
    pdVC.cover_image_url = imageUrl;
    pdVC.titles = title;
    [self.navigationController pushViewController:pdVC animated:YES];
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
